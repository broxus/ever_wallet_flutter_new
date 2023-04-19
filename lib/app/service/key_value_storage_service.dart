import 'dart:convert';

import 'package:app/app/constants.dart';
import 'package:app/data/models/bookmark.dart';
import 'package:app/data/models/browser_tab.dart';
import 'package:app/data/models/currency.dart';
import 'package:app/data/models/network_type.dart';
import 'package:app/data/models/permissions.dart';
import 'package:app/data/models/search_history.dart';
import 'package:app/data/models/site_meta_data.dart';
import 'package:app/data/models/token_contract_asset.dart';
import 'package:encrypted_storage/encrypted_storage.dart';

/// List of keys to store in storage
const _passwordsKey = 'passwords_key';
const _systemContractAssetsKey = 'system_contract_assets_key';
const _customContractAssetsKey = 'custom_contract_assets_key';
const _hiddenAccountsKey = 'hidden_accounts_key';
const _seedsKey = 'seeds_key';
const _nekotonBridgeKey = 'nekoton_bridge_key';
const _preferencesKey = 'preferences_key';
const _permissionsKey = 'permissions_key';
const _externalAccountsKey = 'external_accounts_key';
const _bookmarksKey = 'bookmarks_key';
const _searchHistoryKey = 'search_history_key';
const _siteMetaDataKey = 'site_meta_data_key';
const _currenciesKey = 'currencies_key';
const _biometryStatusKey = 'biometry_status_key';
const _currentKey = 'current_public_key';
const _currentConnectionKey = 'current_connection_key';
const _localeKey = 'locale';
const _browserNeedKey = 'browser_need_key';
const _browserTabsKey = 'browser_tabs_key';
const _browserTabsLastIndexKey = 'browser_tabs_last_index_key';
const _wasStEverOpenedKey = 'was_stever_opened_key';
const _lastSelectedSeedsKey = 'last_selected_seeds_key';

/// This is a wrapper-class above [EncryptedStorage] that provides methods
/// to interact with basic nekoton-app models.
/// This storage can be filled with data from the old version of the app via
/// migration service.
class KeyValueStorageService {
  KeyValueStorageService(this._storage);

  /// Storage that is used to store data
  final EncryptedStorage _storage;

  /// Clear all data that can be related to some user
  Future<void> clearUserSensitiveData() async {
    await Future.wait([
      clearSeeds(),
      clearStorageData(),
      clearKeyPasswords(),
      clearExternalAccounts(),
      clearBookmarks(),
      clearSitesMetaData(),
      clearCurrencies(),
      clearPreferences(),
    ]);
  }

  Future<void> clearPreferences() => _storage.clearDomain(_preferencesKey);

  /// Get all seed names
  Future<Map<String, String>> get seeds =>
      _storage.getDomain(domain: _seedsKey);

  /// Add or rename public key
  Future<void> addSeedOrRename({
    required String masterKey,
    required String name,
  }) =>
      _storage.set(masterKey, name, domain: _seedsKey);

  /// Remove name of public key
  Future<void> removeSeed(String masterKey) =>
      _storage.delete(masterKey, domain: _seedsKey);

  /// Clear information about all names of public keys
  Future<void> clearSeeds() => _storage.clearDomain(_seedsKey);

  /// Get current public key that user set before
  Future<String?> get currentKey =>
      _storage.get(_currentKey, domain: _preferencesKey);

  /// Set current public key of user
  Future<void> setCurrentKey(String publicKey) => _storage.set(
        _currentKey,
        publicKey,
        domain: _preferencesKey,
      );

  /// Returns up to [maxLastSelectedSeeds] public keys of seeds that were used.
  ///
  /// After updating to application version with this list, it's filled with 4
  /// (or less) random keys with [currentKey] at 1-st place.
  Future<List<String>> lastViewedSeeds() async {
    final seeds = await _storage.get(
      _lastSelectedSeedsKey,
      domain: _preferencesKey,
    );
    if (seeds == null) {
      return [];
    }
    final seedsList = jsonDecode(seeds) as List<dynamic>;
    return seedsList.cast<String>();
  }

  /// Update seeds that were used by user.
  /// There must be only master keys, if key is sub, then put its master.
  /// Count of seeds must be less or equals to [maxLastSelectedSeeds] and
  /// cropped outside.
  Future<void> updateLastViewedSeeds(List<String> seedsKeys) => _storage.set(
        _lastSelectedSeedsKey,
        jsonEncode(seedsKeys),
        domain: _preferencesKey,
      );

  /// List of addresses of accounts that were hidden by user
  Future<List<String>> get hiddenAccounts async {
    final accounts = await _storage.get(
      _hiddenAccountsKey,
      domain: _preferencesKey,
    );
    if (accounts == null) {
      return [];
    }
    final accountsList = jsonDecode(accounts) as List<dynamic>;
    return accountsList.cast<String>();
  }

  /// Hide or show account address
  Future<void> toggleHiddenAccount(String address) async {
    final accounts = await hiddenAccounts;
    if (accounts.contains(address)) {
      accounts.remove(address);
    } else {
      accounts.add(address);
    }
    return _storage.set(
      _hiddenAccountsKey,
      jsonEncode(accounts),
      domain: _preferencesKey,
    );
  }

  /// Remove information about hidden account (make it visible)
  Future<void> removeHiddenIfPossible(String address) async {
    final accounts = (await hiddenAccounts)..remove(address);
    return _storage.set(
      _hiddenAccountsKey,
      jsonEncode(accounts),
      domain: _preferencesKey,
    );
  }

  /// Clear information about hidden accounts
  Future<void> clearHiddenAccounts() => _storage.delete(
        _hiddenAccountsKey,
        domain: _preferencesKey,
      );

  /// Get password of public key if it was cached with biometry
  Future<String?> getKeyPassword(String publicKey) => _storage.get(
        publicKey,
        domain: _passwordsKey,
      );

  /// Set password of public key to cache it with biometry
  Future<void> setKeyPassword({
    required String publicKey,
    required String password,
  }) =>
      _storage.set(
        publicKey,
        password,
        domain: _passwordsKey,
      );

  /// Remove password of public key from cache
  Future<void> removeKeyPassword(String publicKey) =>
      _storage.delete(publicKey, domain: _passwordsKey);

  /// Clear all passwords of public keys from cache
  Future<void> clearKeyPasswords() => _storage.clearDomain(_passwordsKey);

  /// Get external accounts where key - public key, value - list of addresses
  /// of accounts
  Future<Map<String, List<String>>> get externalAccounts async {
    final accounts = await _storage.getDomain(domain: _externalAccountsKey);
    return accounts.map(
      (key, value) => MapEntry(
        key,
        (jsonDecode(value) as List<dynamic>).cast<String>(),
      ),
    );
  }

  /// Add external account for specified [publicKey]
  Future<void> addExternalAccount({
    required String publicKey,
    required String address,
  }) async {
    final accountsEncoded = await _storage.get(
      publicKey,
      domain: _externalAccountsKey,
    );
    List<String> accounts;
    if (accountsEncoded == null) {
      accounts = [];
    } else {
      accounts = (jsonDecode(accountsEncoded) as List<dynamic>).cast<String>();
    }

    accounts.add(address);

    return _storage.set(
      publicKey,
      jsonEncode(accounts),
      domain: _externalAccountsKey,
    );
  }

  /// Remove external account for specified [publicKey]
  Future<void> removeExternalAccount({
    required String publicKey,
    required String address,
  }) async {
    final accountsEncoded = await _storage.get(
      publicKey,
      domain: _externalAccountsKey,
    );
    List<String> accounts;
    if (accountsEncoded == null) {
      accounts = [];
    } else {
      accounts = (jsonDecode(accountsEncoded) as List<dynamic>).cast<String>();
    }

    accounts.remove(address);

    return _storage.set(
      publicKey,
      jsonEncode(accounts),
      domain: _externalAccountsKey,
    );
  }

  /// Clear all external accounts
  Future<void> clearExternalAccounts() =>
      _storage.clearDomain(_externalAccountsKey);

  /// Get current connection of network by name
  Future<String?> get currentConnection =>
      _storage.get(_currentConnectionKey, domain: _preferencesKey);

  /// Set current connection of network by name
  Future<void> setCurrentConnection(String currentConnection) => _storage.set(
        _currentConnectionKey,
        currentConnection,
        domain: _preferencesKey,
      );

  /// Get data of nekoton storage
  Future<String?> getStorageData(String key) async =>
      _storage.get(key, domain: _nekotonBridgeKey);

  /// Set data of nekoton storage
  Future<void> setStorageData({
    required String key,
    required String value,
  }) =>
      _storage.set(key, value, domain: _nekotonBridgeKey);

  /// Clear data of nekoton storage by key
  Future<void> removeStorageData(String key) =>
      _storage.delete(key, domain: _nekotonBridgeKey);

  /// Clear all data of nekoton storage
  Future<void> clearStorageData() => _storage.clearDomain(_nekotonBridgeKey);

  /// Clear previous system assets and set new ones
  Future<void> updateSystemTokenContractAssets(
    List<TokenContractAsset> assets,
  ) async {
    if (assets.isNotEmpty) {
      assert(
        assets.every((asset) => asset.networkType == assets.first.networkType),
        'All system assets must have the same type',
      );
      await _storage.delete(
        assets.first.networkType.index.toString(),
        domain: _systemContractAssetsKey,
      );
      await _storage.set(
        assets.first.networkType.index.toString(),
        jsonEncode(assets),
        domain: _systemContractAssetsKey,
      );
    }
  }

  /// Get list of system assets by network type
  Future<List<TokenContractAsset>> getSystemTokenContractAssets(
    NetworkType type,
  ) async {
    final assets = await _storage.get(
      type.index.toString(),
      domain: _systemContractAssetsKey,
    );
    if (assets == null) {
      return [];
    }
    final assetsList = jsonDecode(assets) as List<dynamic>;
    return assetsList
        .map(
          (asset) => TokenContractAsset.fromJson(asset as Map<String, dynamic>),
        )
        .toList();
  }

  /// Get list of custom assets by network type
  Future<List<TokenContractAsset>> getCustomTokenContractAssets(
    NetworkType type,
  ) async {
    final assets = await _storage.get(
      type.index.toString(),
      domain: _customContractAssetsKey,
    );
    if (assets == null) {
      return [];
    }
    final assetsList = jsonDecode(assets) as List<dynamic>;
    return assetsList
        .map(
          (asset) => TokenContractAsset.fromJson(asset as Map<String, dynamic>),
        )
        .toList();
  }

  /// Add custom token contract asset to list of tokens with same type.
  /// Ignores asset with duplicate address.
  Future<void> addCustomTokenContractAsset(
    TokenContractAsset tokenContractAsset,
  ) async {
    final assets = await getCustomTokenContractAssets(
      tokenContractAsset.networkType,
    );
    final newAssets = assets
        .where((e) => e.address != tokenContractAsset.address)
        .toList()
      ..add(tokenContractAsset);
    await _storage.set(
      tokenContractAsset.networkType.index.toString(),
      jsonEncode(newAssets),
      domain: _customContractAssetsKey,
    );
  }

  /// Remove custom token contract asset from list of tokens with same type.
  Future<void> removeCustomTokenContractAsset(
    TokenContractAsset asset,
  ) async {
    final assets = await getCustomTokenContractAssets(asset.networkType);
    final newAssets = assets.where((a) => a.address != asset.address).toList();
    await _storage.set(
      asset.networkType.index.toString(),
      jsonEncode(newAssets),
      domain: _customContractAssetsKey,
    );
  }

  /// Delete all custom token contract assets with same type.
  Future<void> deleteCustomTokens(NetworkType type) => _storage.delete(
        type.index.toString(),
        domain: _customContractAssetsKey,
      );

  /// Clear all custom tokens
  Future<void> clearAllCustomTokens() =>
      _storage.clearDomain(_customContractAssetsKey);

  /// Get locale that used could save in settings
  Future<String?> get locale =>
      _storage.get(_localeKey, domain: _preferencesKey);

  /// Set locale that used could save in settings
  Future<void> setLocale(String locale) =>
      _storage.set(_localeKey, locale, domain: _preferencesKey);

  /// Clear locale
  Future<void> clearLocale() =>
      _storage.delete(_localeKey, domain: _preferencesKey);

  /// Get if biometry is enabled in app
  Future<bool> get isBiometryEnabled async {
    final encoded = await _storage.get(
      _biometryStatusKey,
      domain: _preferencesKey,
    );
    return jsonDecode(encoded ?? 'false') as bool;
  }

  /// Set if biometry is enabled in app
  Future<void> setIsBiometryEnabled({required bool isEnabled}) => _storage.set(
        _biometryStatusKey,
        jsonEncode(isEnabled),
        domain: _preferencesKey,
      );

  /// Delete information about biometry
  Future<void> clearIsBiometryEnabled() =>
      _storage.delete(_biometryStatusKey, domain: _preferencesKey);

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
  Future<void> deletePermissionsForAccount(String address) async {
    final perms = await permissions;
    final origins = perms.entries
        .where((e) => e.value.accountInteraction?.address == address)
        .map((e) => e.key);

    for (final origin in origins) {
      final permissions = perms[origin]!.copyWith(accountInteraction: null);

      await setPermissions(origin: origin, permissions: permissions);
    }
  }

  /// Get list of bookmarks that user had saved
  Future<List<Bookmark>> get bookmarks async {
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
  Future<void> addBookmark(Bookmark bookmark) => _storage.set(
        bookmark.id.toString(),
        jsonEncode(bookmark.toJson()),
        domain: _bookmarksKey,
      );

  /// Delete bookmark from storage by its id
  Future<void> deleteBookmark(int id) =>
      _storage.delete(id.toString(), domain: _bookmarksKey);

  /// Clear all bookmarks
  Future<void> clearBookmarks() => _storage.clearDomain(_bookmarksKey);

  /// Get list of search history in browser
  Future<List<SearchHistory>> get searchHistory async {
    final encoded = await _storage.get(
      _searchHistoryKey,
      domain: _preferencesKey,
    );
    if (encoded == null) {
      return [];
    }
    final history = jsonDecode(encoded) as List<dynamic>;
    return history
        .map(
          (entry) => SearchHistory.fromJson(
            jsonDecode(entry as String) as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  /// Add search history entry to storage. Search sorts by date and saves only
  /// last 50 entries.
  Future<void> addSearchHistoryEntry(SearchHistory entry) async {
    var list = await searchHistory;
    list = list.where((e) => e.url != entry.url).toList();

    final entries = [
      ...list,
      entry,
    ]..sort((a, b) => -a.openTime.compareTo(b.openTime));

    return _storage.set(
      _searchHistoryKey,
      jsonEncode(entries.take(50)),
      domain: _preferencesKey,
    );
  }

  /// Remove search history entry from storage
  Future<void> removeSearchHistoryEntry(SearchHistory entry) async {
    var list = await searchHistory;
    list = list.where((e) => e.url != entry.url).toList();

    return _storage.set(
      _searchHistoryKey,
      jsonEncode(list),
      domain: _preferencesKey,
    );
  }

  /// Clear all search history
  Future<void> clearSearchHistory() =>
      _storage.delete(_searchHistoryKey, domain: _preferencesKey);

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

  /// Get list of all currencies specified for network type
  Future<List<Currency>> getCurrencies(NetworkType type) async {
    final encoded = await _storage.get(
      type.index.toString(),
      domain: _currenciesKey,
    );
    if (encoded == null) {
      return [];
    }
    final list = jsonDecode(encoded) as List<dynamic>;
    return list
        .map(
          (entry) => Currency.fromJson(
            jsonDecode(entry as String) as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  /// Save currency to storage for specified network type.
  /// This ignores duplicates and saves only one currency with same address.
  Future<void> saveOrUpdateCurrency({required Currency currency}) async {
    final type = currency.networkType;
    final list = await getCurrencies(type);
    final newList = list.where((e) => e.address != currency.address).toList()
      ..add(currency);

    return _storage.set(
      type.index.toString(),
      jsonEncode(newList),
      domain: _currenciesKey,
    );
  }

  /// Clear information about all currencies.
  Future<void> clearCurrencies() => _storage.clearDomain(_currenciesKey);

  /// Get flag if Why Need Browser screen was shown
  Future<bool> get getWhyNeedBrowser async {
    final encoded = await _storage.get(
      _browserNeedKey,
      domain: _preferencesKey,
    );
    return jsonDecode(encoded ?? 'false') as bool;
  }

  /// Set flag that Why Need Browser screen was shown
  Future<void> saveWhyNeedBrowser() =>
      _storage.set(_browserNeedKey, jsonEncode(true), domain: _preferencesKey);

  /// Get flag if What's StEver screen was shown
  Future<bool> get getWasStEverOpened async {
    final encoded = await _storage.get(
      _wasStEverOpenedKey,
      domain: _preferencesKey,
    );
    return jsonDecode(encoded ?? 'false') as bool;
  }

  /// Set flag that What's StEver screen was shown
  Future<void> saveWasStEverOpened() => _storage.set(
        _wasStEverOpenedKey,
        jsonEncode(true),
        domain: _preferencesKey,
      );

  /// Get last selected browser tab index
  Future<int> get browserTabsLastIndex async {
    final encoded = await _storage.get(
      _browserTabsLastIndexKey,
      domain: _preferencesKey,
    );
    return int.tryParse(encoded ?? '') ?? -1;
  }

  /// Save last selected browser tab index
  Future<void> saveBrowserTabsLastIndex(int index) => _storage.set(
        _browserTabsLastIndexKey,
        index.toString(),
        domain: _preferencesKey,
      );

  /// Get list of browser tabs from storage
  Future<List<BrowserTab>> get browserTabs async {
    final encoded = await _storage.get(
      _browserTabsKey,
      domain: _preferencesKey,
    );
    if (encoded == null) {
      return [];
    }
    final list = jsonDecode(encoded) as List<dynamic>;
    return list
        .map(
          (entry) => BrowserTab.fromJson(
            jsonDecode(entry as String) as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  /// Save list of browser tabs to storage
  Future<void> saveBrowserTabs(List<BrowserTab> tabs) => _storage.set(
        _browserTabsKey,
        jsonEncode(tabs),
        domain: _preferencesKey,
      );

  /// Clear all browser tabs
  Future<void> clearBrowserTabs() =>
      _storage.delete(_browserTabsKey, domain: _preferencesKey);
}
