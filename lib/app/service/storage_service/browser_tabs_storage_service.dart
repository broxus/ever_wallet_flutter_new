import 'dart:convert';
import 'dart:io';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:collection/collection.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

const _browserTabsDomain = 'browser_tabs';
const _browserTabsKey = 'browser_tabs_key';
const _browserTabsActiveTabIdKey = 'browser_tabs_active_tab_id_key';

/// This is a wrapper-class above [EncryptedStorage] that provides methods
/// to interact with all browser tabs - related data.
@singleton
class BrowserTabsStorageService extends AbstractStorageService {
  BrowserTabsStorageService(this._storage);

  /// Storage that is used to store data
  final EncryptedStorage _storage;

  // ===== Active tab related =====

  /// Subject of active browser tab id
  final _browserActiveTabIdSubject = BehaviorSubject<String?>();

  /// Stream of active browser tab id
  Stream<String?> get browserActiveTabIdStream => _browserActiveTabIdSubject;

  /// Get last cached of active browser tab id
  String? get browserActiveTabId => _browserActiveTabIdSubject.valueOrNull;

  /// Put browser active tab stream
  Future<void> _streamedBrowserActiveTabId() async =>
      _browserActiveTabIdSubject.add(await readBrowserActiveTabId());

  /// Read active tab from storage
  Future<String?> readBrowserActiveTabId() async {
    return _storage.get(
      _browserTabsActiveTabIdKey,
      domain: _browserTabsDomain,
    );
  }

  /// Save active tab id to storage
  Future<void> saveBrowserActiveTabId(String? id) async {
    final verifiedId =
        _browserTabById(id) != null ? id : browserTabs.firstOrNull?.id ?? -1;

    if (id == browserActiveTabId) {
      return;
    }

    await _storage.set(
      _browserTabsActiveTabIdKey,
      verifiedId.toString(),
      domain: _browserTabsDomain,
    );
    await _streamedBrowserActiveTabId();
  }

  // ===== Tab list related =====

  /// Subject of browser tabs
  final _browserTabsSubject = BehaviorSubject<List<BrowserTab>>();

  /// Stream of browser tabs
  Stream<List<BrowserTab>> get browserTabsStream => _browserTabsSubject;

  /// Get last cached browser tabs
  List<BrowserTab> get browserTabs => _browserTabsSubject.valueOrNull ?? [];

  /// Put browser tabs to stream
  Future<void> _streamedBrowserTabs() async =>
      _browserTabsSubject.add(await readBrowserTabs());

  /// Read list of browser tabs from storage
  Future<List<BrowserTab>> readBrowserTabs() async {
    final encoded = await _storage.get(
      _browserTabsKey,
      domain: _browserTabsDomain,
    );
    if (encoded == null) {
      return [];
    }
    final list = jsonDecode(encoded) as List<dynamic>;

    return list
        .map((entry) => BrowserTab.fromJson(entry as Map<String, dynamic>))
        .toList();
  }

  /// Save list of browser tabs to storage
  Future<void> saveBrowserTabs(List<BrowserTab> tabs) async {
    await _storage.set(
      _browserTabsKey,
      jsonEncode(tabs),
      domain: _browserTabsDomain,
    );
    await _streamedBrowserTabs();
    // assure that we don't have active tab id that doesn't exist
    await saveBrowserActiveTabId(browserActiveTabId);
  }

  /// Clear all browser tabs
  Future<void> clearBrowserTabs() async {
    await _storage.delete(
      _browserTabsKey,
      domain: _browserTabsDomain,
    );
    _browserTabsSubject.add([]);

    await _streamedBrowserTabs();
    await saveBrowserActiveTabId(null);

    try {
      await Directory(BrowserTab.tabsDirectoryPath).delete(recursive: true);
    } catch (_) {}
    try {
      await File(BrowserTab.defaultImagePath).delete();
    } catch (_) {}
  }

  /// Add browser tab
  Future<void> addBrowserTab(BrowserTab tab) async {
    /// Provide unique id for tab
    final newId = tab.id;
    await saveBrowserTabs([...browserTabs, tab]);
    await saveBrowserActiveTabId(newId);
  }

  /// Set browser tab
  Future<void> setBrowserTab(BrowserTab tab) async {
    final id = tab.id;
    final index = browserTabs.indexWhere((tab) => tab.id == id);
    final tabs = [...browserTabs];

    if (index == -1) {
      tabs.add(tab);
    } else {
      tabs[index] = tab;
    }

    await saveBrowserTabs(tabs);
  }

  /// Remove browser tab by id
  Future<void> removeBrowserTab(String id) async {
    final tabs = [...browserTabs]..removeWhere((tab) => tab.id == id);

    await saveBrowserTabs(tabs);

    try {
      await Directory(BrowserTab.getTabDirectoryPath(id))
          .delete(recursive: true);
    } catch (_) {}
  }

  /// Get tab by id
  BrowserTab? _browserTabById(String? id) =>
      id != null ? browserTabs.firstWhereOrNull((tab) => tab.id == id) : null;

  @override
  Future<void> init() => Future.wait([
        _streamedBrowserTabs(),
        _streamedBrowserActiveTabId(),
      ]);

  @override
  Future<void> clearSensitiveData() => Future.wait([
        clearBrowserTabs(),
      ]);
}
