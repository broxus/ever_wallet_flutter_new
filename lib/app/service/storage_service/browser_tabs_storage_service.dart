import 'dart:io';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:collection/collection.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

const _browserTabsDomain = 'browser_tabs';
const _browserTabsKey = 'browser_tabs_key';
const _browserTabsActiveTabIdKey = 'browser_tabs_active_tab_id_key';

/// This is a wrapper-class above [GetStorage] that provides methods
/// to interact with all browser tabs - related data.
@singleton
class BrowserTabsStorageService extends AbstractStorageService {
  BrowserTabsStorageService(
    @Named(container) this._storage,
  );

  static const container = _browserTabsDomain;

  final GetStorage _storage;

  // ===== Active tab related =====

  /// Subject of active browser tab id
  final _browserActiveTabIdSubject = BehaviorSubject<String?>();

  /// Stream of active browser tab id
  Stream<String?> get browserActiveTabIdStream => _browserActiveTabIdSubject;

  /// Get last cached of active browser tab id
  String? get browserActiveTabId => _browserActiveTabIdSubject.valueOrNull;

  /// Put browser active tab stream
  void _streamedBrowserActiveTabId() =>
      _browserActiveTabIdSubject.add(readBrowserActiveTabId());

  /// Read active tab from storage
  String? readBrowserActiveTabId() => _storage.read(_browserTabsActiveTabIdKey);

  /// Save active tab id to storage
  void saveBrowserActiveTabId(String? id) {
    final verifiedId =
        _browserTabById(id) != null ? id : browserTabs.firstOrNull?.id ?? '-1';

    if (id == browserActiveTabId) {
      return;
    }

    _storage.write(_browserTabsActiveTabIdKey, verifiedId);
    _streamedBrowserActiveTabId();
  }

  // ===== Tab list related =====

  /// Subject of browser tabs
  final _browserTabsSubject = BehaviorSubject<List<BrowserTab>>();

  /// Stream of browser tabs
  Stream<List<BrowserTab>> get browserTabsStream => _browserTabsSubject;

  /// Get last cached browser tabs
  List<BrowserTab> get browserTabs => _browserTabsSubject.valueOrNull ?? [];

  /// Put browser tabs to stream
  void _streamedBrowserTabs() => _browserTabsSubject.add(readBrowserTabs());

  /// Read list of browser tabs from storage
  List<BrowserTab> readBrowserTabs() {
    final list = _storage.read<List<dynamic>>(_browserTabsKey);
    if (list == null) {
      return [];
    }

    return list
        .map((entry) => BrowserTab.fromJson(entry as Map<String, dynamic>))
        .toList();
  }

  /// Save list of browser tabs to storage
  void saveBrowserTabs(List<BrowserTab> tabs) {
    _storage.write(
      _browserTabsKey,
      tabs.map((e) => e.toJson()).toList(),
    );
    _streamedBrowserTabs();
    // assure that we don't have active tab id that doesn't exist
    saveBrowserActiveTabId(browserActiveTabId);
  }

  /// Clear all browser tabs
  Future<void> clearBrowserTabs() async {
    await _storage.remove(_browserTabsKey);
    _browserTabsSubject.add([]);

    _streamedBrowserTabs();
    saveBrowserActiveTabId(null);

    try {
      await Directory(BrowserTab.tabsDirectoryPath!).delete(recursive: true);
    } catch (_) {}
    try {
      await File(BrowserTab.defaultImagePath!).delete();
    } catch (_) {}
  }

  /// Add browser tab
  void addBrowserTab(BrowserTab tab) {
    /// Provide unique id for tab
    final newId = tab.id;
    saveBrowserTabs([...browserTabs, tab]);
    saveBrowserActiveTabId(newId);
  }

  /// Set browser tab
  void setBrowserTab(BrowserTab tab) {
    final id = tab.id;
    final index = browserTabs.indexWhere((tab) => tab.id == id);
    final tabs = [...browserTabs];

    if (index == -1) {
      tabs.add(tab);
    } else {
      tabs[index] = tab;
    }

    saveBrowserTabs(tabs);
  }

  /// Remove browser tab by id
  Future<void> removeBrowserTab(String id) async {
    final tabs = [...browserTabs]..removeWhere((tab) => tab.id == id);

    saveBrowserTabs(tabs);

    try {
      await Directory(BrowserTab.getTabDirectoryPath(id))
          .delete(recursive: true);
    } catch (_) {}
  }

  /// Get tab by id
  BrowserTab? _browserTabById(String? id) =>
      id != null ? browserTabs.firstWhereOrNull((tab) => tab.id == id) : null;

  @override
  Future<void> init() async {
    await GetStorage.init(container);
    _streamedBrowserTabs();
    _streamedBrowserActiveTabId();
  }

  @override
  Future<void> clearSensitiveData() => Future.wait([
        clearBrowserTabs(),
      ]);
}
