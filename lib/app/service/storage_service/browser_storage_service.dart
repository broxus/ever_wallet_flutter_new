import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/bookmark.dart';
import 'package:app/data/models/browser_tab.dart';
import 'package:app/data/models/permissions.dart';
import 'package:app/data/models/search_history.dart';
import 'package:app/data/models/site_meta_data.dart';
import 'package:collection/collection.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

const _permissionsKey = 'permissions_key';

const _bookmarksKey = 'bookmarks_key';
const _searchHistoryKey = 'search_history_key';
const _siteMetaDataKey = 'site_meta_data_key';
const _browserNeedKey = 'browser_need_key';
const _browserTabsKey = 'browser_tabs_key';
const _browserTabsActiveTabIdKey = 'browser_tabs_active_tab_id_key';

const _browserPreferencesKey = 'browser_preferences_key';

/// This is a wrapper-class above [EncryptedStorage] that provides methods
/// to interact with all browser-related data.
@singleton
class BrowserStorageService extends AbstractStorageService {
  BrowserStorageService(this._storage);

  /// Storage that is used to store data
  final EncryptedStorage _storage;

  @override
  Future<void> init() => Future.wait([
        _streamedBookmarks(),
        _streamedSearchHistory(),
        _streamedBrowserTabs(),
        _streamedBrowserActiveTabId(),
      ]);

  @override
  Future<void> clearSensitiveData() => Future.wait([
        clearPreferences(),
        clearBookmarks(),
        clearSitesMetaData(),
        clearPermissions(),
      ]);

  /// Get all permissions that user had granted to dapps.
  /// key - url address, value - permissions
  Future<Map<String, Permissions>> get permissions async {
    final encoded = await _storage.getDomain(domain: _permissionsKey);

    return encoded.map(
      (key, value) => MapEntry(
        key,
        Permissions.fromJson(jsonDecode(value) as Map<String, dynamic>),
      ),
    );
  }

  /// Set permission for specified url
  Future<void> setPermissions({
    required String origin,
    required Permissions permissions,
  }) =>
      _storage.set(
        origin,
        jsonEncode(permissions.toJson()),
        domain: _permissionsKey,
      );

  /// Delete permissions for specified url
  Future<void> deletePermissionsForOrigin(String origin) =>
      _storage.delete(origin, domain: _permissionsKey);

  /// Delete permissions for specified account
  Future<void> deletePermissionsForAccount(Address address) async {
    final perms = await permissions;
    final origins = perms.entries
        .where((e) => e.value.accountInteraction?.address == address)
        .map((e) => e.key);

    for (final origin in origins) {
      final permissions = perms[origin]!.copyWith(accountInteraction: null);

      await setPermissions(origin: origin, permissions: permissions);
    }
  }

  /// Clear information about permissions
  Future<void> clearPermissions() => _storage.clearDomain(_permissionsKey);

  // Subject of bookmarks
  final _bookmarksSubject = BehaviorSubject<List<Bookmark>>();

  /// Stream of bookmarks
  Stream<List<Bookmark>> get bookmarksStream => _bookmarksSubject;

  /// Get last cached bookmarks
  List<Bookmark> get bookmarks => _bookmarksSubject.value;

  /// Put bookmarks to stream
  Future<void> _streamedBookmarks() async =>
      _bookmarksSubject.add(await readBookmarks());

  /// Read from storage list of bookmarks that user had saved
  Future<List<Bookmark>> readBookmarks() async {
    final bookmarks = await _storage.getDomain(domain: _bookmarksKey);

    return bookmarks.values
        .map(
          (bookmark) => Bookmark.fromJson(
            jsonDecode(bookmark) as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  /// Add bookmark to storage, where [Bookmark.id] is key
  Future<void> addBookmark(Bookmark bookmark) async {
    await _storage.set(
      bookmark.id.toString(),
      jsonEncode(bookmark.toJson()),
      domain: _bookmarksKey,
    );
    await _streamedBookmarks();
  }

  /// Delete bookmark from storage by its id
  Future<void> deleteBookmark(int id) async {
    await _storage.delete(id.toString(), domain: _bookmarksKey);
    await _streamedBookmarks();
  }

  /// Clear all bookmarks
  Future<void> clearBookmarks() async {
    await _storage.clearDomain(_bookmarksKey);
    _bookmarksSubject.add([]);
  }

  /// Subject of search history
  final _searchHistorySubject = BehaviorSubject<List<SearchHistory>>();

  /// Get last cached search history
  List<SearchHistory> get searchHistory => _searchHistorySubject.value;

  /// Stream of search history
  Stream<List<SearchHistory>> get searchHistoryStream => _searchHistorySubject;

  /// Put search history to stream
  Future<void> _streamedSearchHistory() async =>
      _searchHistorySubject.add(await readSearchHistory());

  /// Read from storage list of search history in browser
  Future<List<SearchHistory>> readSearchHistory() async {
    final encoded = await _storage.get(
      _searchHistoryKey,
      domain: _browserPreferencesKey,
    );
    if (encoded == null) {
      return [];
    }
    final history = jsonDecode(encoded) as List<dynamic>;

    return history
        .map((entry) => SearchHistory.fromJson(entry as Map<String, dynamic>))
        .toList();
  }

  /// Add search history entry to storage. Search sorts by date and saves only
  /// last 50 entries.
  Future<void> addSearchHistoryEntry(SearchHistory entry) async {
    var list = await readSearchHistory();
    list = list.where((e) => e.url != entry.url).toList();

    final entries = [
      ...list,
      entry,
    ]..sort((a, b) => -a.openTime.compareTo(b.openTime));

    await _storage.set(
      _searchHistoryKey,
      // ignore: no-magic-number
      jsonEncode(entries.take(50).toList()),
      domain: _browserPreferencesKey,
    );
    await _streamedSearchHistory();
  }

  /// Remove search history entry from storage
  Future<void> removeSearchHistoryEntry(SearchHistory entry) async {
    var list = await readSearchHistory();
    list = list.where((e) => e.url != entry.url).toList();

    await _storage.set(
      _searchHistoryKey,
      jsonEncode(list),
      domain: _browserPreferencesKey,
    );
    await _streamedSearchHistory();
  }

  /// Clear all search history
  Future<void> clearSearchHistory() async {
    await _storage.delete(_searchHistoryKey, domain: _browserPreferencesKey);
    _searchHistorySubject.add([]);
  }

  /// Get metadata of site by its url
  Future<SiteMetaData?> getSiteMetaData(String url) async {
    final encoded = await _storage.get(url, domain: _siteMetaDataKey);
    if (encoded == null) {
      return null;
    }

    return SiteMetaData.fromJson(
      jsonDecode(encoded) as Map<String, dynamic>,
    );
  }

  /// Add metadata of site by its url
  Future<void> addSiteMetaData({
    required String url,
    required SiteMetaData metaData,
  }) =>
      _storage.set(
        url,
        jsonEncode(metaData.toJson()),
        domain: _siteMetaDataKey,
      );

  /// Clear all sites metadata
  Future<void> clearSitesMetaData() => _storage.clearDomain(_siteMetaDataKey);

  /// Get flag if Why Need Browser screen was shown
  Future<bool> get getWhyNeedBrowser async {
    final encoded = await _storage.get(
      _browserNeedKey,
      domain: _browserPreferencesKey,
    );

    return jsonDecode(encoded ?? 'false') as bool;
  }

  /// Set flag that Why Need Browser screen was shown
  Future<void> saveWhyNeedBrowser() => _storage
      .set(_browserNeedKey, jsonEncode(true), domain: _browserPreferencesKey);

  /// Subject of active browser tab id
  final _browserActiveTabIdSubject = BehaviorSubject<int>();

  /// Stream of active browser tab id
  Stream<int> get browserActiveTabIdStream => _browserActiveTabIdSubject;

  /// Get last cached of active browser tab id
  int get browserActiveTabId => _browserActiveTabIdSubject.value;

  /// Put browser active tab stream
  Future<void> _streamedBrowserActiveTabId() async =>
      _browserActiveTabIdSubject.add(await readBrowserActiveTabId());

  /// Read active tab from storage
  Future<int> readBrowserActiveTabId() async {
    final encoded = await _storage.get(
      _browserTabsActiveTabIdKey,
      domain: _browserPreferencesKey,
    );

    if (encoded == null) {
      return -1;
    }

    return int.tryParse(encoded) ?? -1;
  }

  /// Save active tab id to storage
  Future<void> saveBrowserActiveTabId(int id) async {
    final verifiedId =
        browserTabById(id) != null ? id : browserTabs.firstOrNull?.id ?? -1;

    if (id == browserActiveTabId) {
      return;
    }

    await _storage.set(
      _browserTabsActiveTabIdKey,
      verifiedId.toString(),
      domain: _browserPreferencesKey,
    );
    await _streamedBrowserActiveTabId();
  }

  /// Subject of browser tabs
  final _browserTabsSubject = BehaviorSubject<List<BrowserTab>>();

  /// Stream of browser tabs
  Stream<List<BrowserTab>> get browserTabsStream => _browserTabsSubject;

  /// Get last cached browser tabs
  List<BrowserTab> get browserTabs => _browserTabsSubject.value;

  /// Put browser tabs to stream
  Future<void> _streamedBrowserTabs() async =>
      _browserTabsSubject.add(await readBrowserTabs());

  /// Get tab by id
  BrowserTab? browserTabById(int id) =>
      browserTabs.firstWhereOrNull((tab) => tab.id == id);

  /// Get active tab
  BrowserTab? get browserTabActive =>
      browserTabs.firstWhereOrNull((tab) => tab.id == browserActiveTabId);

  /// Read list of browser tabs from storage
  Future<List<BrowserTab>> readBrowserTabs() async {
    final encoded = await _storage.get(
      _browserTabsKey,
      domain: _browserPreferencesKey,
    );
    if (encoded == null) {
      return [];
    }
    final list = jsonDecode(encoded) as List<dynamic>;

    return list
        .map((entry) => BrowserTab.fromJson(entry as Map<String, dynamic>))
        .toList();
  }

  /// Add browser tab
  Future<void> addBrowserTab(BrowserTab tab) async {
    /// Provide unique id for tab
    final newId = browserTabs.fold(
          0,
          (max, tab) => tab.id > max ? tab.id : max,
        ) +
        1;
    await saveBrowserTabs([...browserTabs, tab.copyWith(id: newId)]);
    await saveBrowserActiveTabId(newId);
  }

  /// Set browser tab
  Future<void> setBrowserTab(BrowserTab tab) async {
    final id = tab.id;
    final tabs = browserTabs..removeWhere((tab) => tab.id == id);
    await saveBrowserTabs([...tabs, tab]);
  }

  /// Remove browser tab by id
  Future<void> removeBrowserTab(int id) async {
    final tabs = browserTabs..removeWhere((tab) => tab.id == id);

    return saveBrowserTabs(tabs);
  }

  /// Save list of browser tabs to storage
  Future<void> saveBrowserTabs(List<BrowserTab> tabs) async {
    await _storage.set(
      _browserTabsKey,
      jsonEncode(tabs),
      domain: _browserPreferencesKey,
    );
    await _streamedBrowserTabs();
    // assure that we don't have active tab id that doesn't exist
    await saveBrowserActiveTabId(browserActiveTabId);
  }

  /// Clear all browser tabs
  Future<void> clearBrowserTabs() async {
    await _storage.delete(_browserTabsKey, domain: _browserPreferencesKey);
    _browserTabsSubject.add([]);

    await _streamedBrowserTabs();
    await saveBrowserActiveTabId(-1);
  }

  /// Clear information about all preferences
  Future<void> clearPreferences() =>
      _storage.clearDomain(_browserPreferencesKey);
}
