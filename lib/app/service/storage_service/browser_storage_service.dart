import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/bookmark.dart';
import 'package:app/data/models/permissions.dart';
import 'package:app/data/models/search_history.dart';
import 'package:app/data/models/site_meta_data.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

const _permissionsKey = 'permissions_key';

const _bookmarksKey = 'bookmarks_key';
const _searchHistoryKey = 'search_history_key';
const _siteMetaDataKey = 'site_meta_data_key';
const _browserNeedKey = 'browser_need_key';
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

  /// Clear information about all preferences
  Future<void> clearPreferences() =>
      _storage.clearDomain(_browserPreferencesKey);
}
