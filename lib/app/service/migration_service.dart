import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:app/app/service/dto/account_interaction_dto.dart';
import 'package:app/app/service/dto/bookmark_dto.dart';
import 'package:app/app/service/dto/browser_tab_dto.dart';
import 'package:app/app/service/dto/currency_dto.dart';
import 'package:app/app/service/dto/permissions_dto.dart';
import 'package:app/app/service/dto/search_history_dto.dart';
import 'package:app/app/service/dto/site_meta_data_dto.dart';
import 'package:app/app/service/dto/token_contract_asset_dto.dart';
import 'package:app/app/service/dto/wallet_contract_type_dto.dart';
import 'package:app/app/service/storage_service/account_seed_storage_service.dart';
import 'package:app/app/service/storage_service/browser_storage_service.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/data/models/bookmark.dart';
import 'package:app/data/models/browser_tab.dart';
import 'package:app/data/models/currency.dart' as cur;
import 'package:app/data/models/network_type.dart';
import 'package:app/data/models/permissions.dart';
import 'package:app/data/models/search_history.dart';
import 'package:app/data/models/site_meta_data.dart';
import 'package:app/data/models/token_contract_asset.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:path_provider/path_provider.dart';

final _migrationLogger = Logger('MigrationService');

/// This class is used only for migration from old version of storage.
@visibleForTesting
class HiveSourceMigration {
  HiveSourceMigration._();

  final _keyPasswordsBoxName = 'keys_passwords_v1';
  final _userPreferencesBoxName = 'user_preferences_v1';
  final _everSystemTokenContractAssetsBoxName =
      'system_token_contract_assets_v1';
  final _everCustomTokenContractAssetsBoxName =
      'custom_token_contract_assets_v1';
  final _venomSystemTokenContractAssetsBoxName =
      'venom_system_token_contract_assets_v1';
  final _venomCustomTokenContractAssetsBoxName =
      'venom_custom_token_contract_assets_v1';
  final _hiddenAccountsKey = 'hidden_accounts_key';
  final _seedsBoxName = 'seeds_v1';
  final _nekotonFlutterBoxName = 'nekoton_flutter';
  final _preferencesBoxName = 'nekoton_preferences';
  final _permissionsBoxName = 'nekoton_permissions_v1';
  final _externalAccountsBoxName = 'nekoton_external_accounts';
  final _bookmarksBoxName = 'bookmarks_box_v2';
  final _searchHistoryBoxName = 'search_history_v2';
  final _siteMetaDataBoxName = 'site_meta_data_v1';
  final _currenciesBoxName = 'currencies_v1';
  final _venomCurrenciesBoxName = 'venom_currencies_v1';
  final _biometryStatusKey = 'biometry_status';
  final _currentKeyKey = 'current_public_key';
  final _currentConnectionKey = 'current_connection';
  final _localeKey = 'locale';
  final _browserNeedKey = 'browser_need_key';
  final _browserTabsKey = 'browser_tabs_key';
  final _browserTabsLastIndexKey = 'browser_tabs_last_index_key';
  final _wasStEverOpenedKey = 'was_stever_opened_key';
  final _lastSelectedSeedsKey = 'last_selected_seeds_key';

  static Future<HiveSourceMigration> create() async {
    final instance = HiveSourceMigration._();
    await instance._initialize();
    return instance;
  }

  Box<String> get _keyPasswordsBox => Hive.box<String>(_keyPasswordsBoxName);

  Box<Object?> get _userPreferencesBox =>
      Hive.box<Object?>(_userPreferencesBoxName);

  Box<TokenContractAssetDto> get _everSystemTokenContractAssetsBox =>
      Hive.box<TokenContractAssetDto>(_everSystemTokenContractAssetsBoxName);

  Box<TokenContractAssetDto> get _venomSystemTokenContractAssetsBox =>
      Hive.box<TokenContractAssetDto>(_venomSystemTokenContractAssetsBoxName);

  Box<TokenContractAssetDto> get _everCustomTokenContractAssetsBox =>
      Hive.box<TokenContractAssetDto>(_everCustomTokenContractAssetsBoxName);

  Box<TokenContractAssetDto> get _venomCustomTokenContractAssetsBox =>
      Hive.box<TokenContractAssetDto>(_venomCustomTokenContractAssetsBoxName);

  Box<String> get _seedsBox => Hive.box<String>(_seedsBoxName);

  Box<String> get _nekotonFlutterBox =>
      Hive.box<String>(_nekotonFlutterBoxName);

  Box<dynamic> get _preferencesBox => Hive.box<dynamic>(_preferencesBoxName);

  Box<PermissionsDto> get _permissionsBox =>
      Hive.box<PermissionsDto>(_permissionsBoxName);

  Box<List<String>> get _externalAccountsBox =>
      Hive.box<List<String>>(_externalAccountsBoxName);

  Box<BookmarkDto> get _bookmarksBox =>
      Hive.box<BookmarkDto>(_bookmarksBoxName);

  Box<SearchHistoryDto> get _searchHistoryBox =>
      Hive.box<SearchHistoryDto>(_searchHistoryBoxName);

  Box<SiteMetaDataDto> get _siteMetaDataBox =>
      Hive.box<SiteMetaDataDto>(_siteMetaDataBoxName);

  Box<CurrencyDto> get _everCurrenciesBox =>
      Hive.box<CurrencyDto>(_currenciesBoxName);

  Box<CurrencyDto> get _venomCurrenciesBox =>
      Hive.box<CurrencyDto>(_venomCurrenciesBoxName);

  Box<dynamic> get _browserTabsBox => Hive.box<dynamic>(_browserTabsKey);

  Box<List<String>> get _hiddenAccountsBox =>
      Hive.box<List<String>>(_hiddenAccountsKey);

  Map<String, String> get seeds => _seedsBox.toMap().cast<String, String>();

  Future<void> addSeedOrRename({
    required String masterKey,
    required String name,
  }) =>
      _seedsBox.put(masterKey, name);

  Future<void> removeSeed(String masterKey) => _seedsBox.delete(masterKey);

  Future<void> clearSeeds() => _seedsBox.clear();

  String? get currentKey => _preferencesBox.get(_currentKeyKey) as String?;

  /// Set label(name) to publicKey
  Future<void> setCurrentKey(String? publicKey) => _preferencesBox.put(
        _currentKeyKey,
        publicKey,
      );

  /// Returns up to [maxLastSelectedSeeds] public keys of seeds that were used.
  ///
  /// After updating to application version with this list, it's filled with 4
  /// (or less) random keys
  /// with [currentKey] at 1-st place.
  List<String> lastViewedSeeds() =>
      (_preferencesBox.get(_lastSelectedSeedsKey) as List? ?? [])
          .cast<String>();

  /// Update seeds that were used by user.
  /// There must be only master keys, if key is sub, then put its master.
  /// Count of seeds must be less or equals to [maxLastSelectedSeeds] and
  /// cropped outside.
  Future<void> updateLastViewedSeeds(List<String> seedsKeys) =>
      _preferencesBox.put(_lastSelectedSeedsKey, seedsKeys);

  /// List of addresses of accounts
  List<String> get hiddenAccounts =>
      _hiddenAccountsBox.get(_hiddenAccountsKey) ?? <String>[];

  /// Hide account address
  Future<void> addHiddenAccount(String address) {
    final accounts = hiddenAccounts..add(address);

    return _hiddenAccountsBox.put(
      _hiddenAccountsKey,
      accounts.toSet().toList(),
    );
  }

  /// Remove information about hidden account (make it visible)
  Future<void> removeHiddenIfPossible(String address) {
    final accounts = hiddenAccounts..remove(address);
    return _hiddenAccountsBox.put(_hiddenAccountsKey, accounts);
  }

  String? getKeyPassword(String publicKey) => _keyPasswordsBox.get(publicKey);

  Map<String, String> get _passwords => _keyPasswordsBox
      .toJson()
      .map((key, value) => MapEntry(key, value as String));

  Future<void> setKeyPassword({
    required String publicKey,
    required String password,
  }) =>
      _keyPasswordsBox.put(publicKey, password);

  Future<void> removeKeyPassword(String publicKey) =>
      _keyPasswordsBox.delete(publicKey);

  Future<void> clearKeyPasswords() => _keyPasswordsBox.clear();

  Map<String, List<String>> get externalAccounts => _externalAccountsBox
      .toMap()
      .map((k, v) => MapEntry(k as String, v.cast<String>()));

  Future<void> addExternalAccount({
    required String publicKey,
    required String address,
  }) async {
    final list = (_externalAccountsBox
            .get(publicKey)
            ?.cast<String>()
            .where((e) => e != address)
            .toList() ??
        [])
      ..add(address);

    await _externalAccountsBox.put(publicKey, list);
  }

  Future<void> removeExternalAccount({
    required String publicKey,
    required String address,
  }) async {
    final list = _externalAccountsBox
        .get(publicKey)
        ?.cast<String>()
        .where((e) => e != address)
        .toList();

    if (list == null) return;

    if (list.isNotEmpty) {
      await _externalAccountsBox.put(publicKey, list);
    } else {
      await _externalAccountsBox.delete(publicKey);
    }
  }

  Future<void> clearExternalAccounts() => _externalAccountsBox.clear();

  String? get currentConnection =>
      _preferencesBox.get(_currentConnectionKey) as String?;

  Future<void> setCurrentConnection(String currentConnection) =>
      _preferencesBox.put(
        _currentConnectionKey,
        currentConnection,
      );

  Map<String, String> get _storageData => _nekotonFlutterBox
      .toJson()
      .map((key, value) => MapEntry(key, value as String));

  Future<String?> getStorageData(String key) async =>
      _nekotonFlutterBox.get(key);

  Future<void> setStorageData({
    required String key,
    required String value,
  }) =>
      _nekotonFlutterBox.put(key, value);

  Future<void> removeStorageData(String key) => _nekotonFlutterBox.delete(key);

  List<TokenContractAsset> get everSystemTokenContractAssets =>
      _everSystemTokenContractAssetsBox.values
          .map((e) => e.toModel(NetworkType.ever))
          .toList();

  List<TokenContractAsset> get venomSystemTokenContractAssets =>
      _venomSystemTokenContractAssetsBox.values
          .map((e) => e.toModel(NetworkType.venom))
          .toList();

  Future<void> updateEverSystemTokenContractAssets(
    List<TokenContractAsset> assets,
  ) async {
    await _everSystemTokenContractAssetsBox.clear();
    await _everSystemTokenContractAssetsBox
        .addAll(assets.map((e) => e.toDto()));
  }

  Future<void> updateVenomSystemTokenContractAssets(
    List<TokenContractAsset> assets,
  ) async {
    await _venomSystemTokenContractAssetsBox.clear();
    await _venomSystemTokenContractAssetsBox
        .addAll(assets.map((e) => e.toDto()));
  }

  List<TokenContractAsset> get everCustomTokenContractAssets =>
      _everCustomTokenContractAssetsBox.values
          .map((e) => e.toModel(NetworkType.ever))
          .toList();

  List<TokenContractAsset> get venomCustomTokenContractAssets =>
      _venomCustomTokenContractAssetsBox.values
          .map((e) => e.toModel(NetworkType.venom))
          .toList();

  Future<void> addEverCustomTokenContractAsset(
    TokenContractAsset tokenContractAsset,
  ) =>
      _everCustomTokenContractAssetsBox.put(
        tokenContractAsset.address,
        tokenContractAsset.toDto(),
      );

  Future<void> addVenomCustomTokenContractAsset(
    TokenContractAsset tokenContractAsset,
  ) =>
      _venomCustomTokenContractAssetsBox.put(
        tokenContractAsset.address,
        tokenContractAsset.toDto(),
      );

  Future<void> removeEverCustomTokenContractAsset(String address) =>
      _everCustomTokenContractAssetsBox.delete(address);

  Future<void> removeVenomCustomTokenContractAsset(String address) =>
      _venomCustomTokenContractAssetsBox.delete(address);

  Future<void> clearEverCustomTokenContractAssets() =>
      _everCustomTokenContractAssetsBox.clear();

  Future<void> clearVenomCustomTokenContractAssets() =>
      _venomCustomTokenContractAssetsBox.clear();

  String? get locale => _userPreferencesBox.get(_localeKey) as String?;

  Future<void> setLocale(String locale) =>
      _userPreferencesBox.put(_localeKey, locale);

  Future<void> clearLocale() => _userPreferencesBox.delete(_localeKey);

  bool get isBiometryEnabled =>
      _userPreferencesBox.get(_biometryStatusKey) as bool? ?? false;

  Future<void> setIsBiometryEnabled({required bool isEnabled}) =>
      _userPreferencesBox.put(_biometryStatusKey, isEnabled);

  Future<void> clearIsBiometryEnabled() =>
      _userPreferencesBox.delete(_biometryStatusKey);

  Map<String, Permissions> get permissions => _permissionsBox
      .toMap()
      .cast<String, PermissionsDto>()
      .map((k, v) => MapEntry(k, v.toModel()));

  Future<void> setPermissions({
    required String origin,
    required Permissions permissions,
  }) =>
      _permissionsBox.put(origin, permissions.toDto());

  Future<void> deletePermissionsForOrigin(String origin) =>
      _permissionsBox.delete(origin);

  Future<void> deletePermissionsForAccount(String address) async {
    final origins = permissions.entries
        .where((e) => e.value.accountInteraction?.address == address)
        .map((e) => e.key);

    for (final origin in origins) {
      final permissions =
          _permissionsBox.get(origin)!.copyWith(accountInteraction: null);

      await _permissionsBox.put(origin, permissions);
    }
  }

  List<Bookmark> get bookmarks =>
      _bookmarksBox.values.map((e) => e.toModel()).toList();

  Future<void> addBookmark(Bookmark bookmark) =>
      _bookmarksBox.put(bookmark.id, bookmark.toDto());

  Future<void> deleteBookmark(int id) => _bookmarksBox.delete(id);

  Future<void> clearBookmarks() => _bookmarksBox.clear();

  List<SearchHistory> get searchHistory =>
      _searchHistoryBox.values.map((e) => e.toModel()).toList();

  Future<void> addSearchHistoryEntry(SearchHistory entry) async {
    var list =
        _searchHistoryBox.toMap().cast<String, SearchHistoryDto>().entries;

    list = list.where((e) => e.value.url != entry.url);

    final entries = [
      ...list,
      MapEntry(entry.openTime.toString(), entry.toDto()),
    ]..sort((a, b) => -a.value.openTime.compareTo(b.value.openTime));

    await _searchHistoryBox.clear();

    await _searchHistoryBox.putAll(Map.fromEntries(entries.take(50)));
  }

  Future<void> removeSearchHistoryEntry(SearchHistory entry) async {
    final keys = _searchHistoryBox
        .toMap()
        .cast<String, SearchHistoryDto>()
        .entries
        .where((e) => e.value.url == entry.url)
        .map((e) => e.key);

    for (final key in keys) {
      await _searchHistoryBox.delete(key);
    }
  }

  Future<void> clearSearchHistory() => _searchHistoryBox.clear();

  Map<String, SiteMetaData> get _siteMetadata => _siteMetaDataBox
      .toMap()
      .map((key, value) => MapEntry(key as String, value.toModel()));

  SiteMetaData? getSiteMetaData(String url) =>
      _siteMetaDataBox.get(url)?.toModel();

  Future<void> cacheSiteMetaData({
    required String url,
    required SiteMetaData metaData,
  }) =>
      _siteMetaDataBox.put(url, metaData.toDto());

  Future<void> clearSitesMetaData() => _siteMetaDataBox.clear();

  List<cur.Currency> get everCurrencies => _everCurrenciesBox.values
      .map((e) => e.toModel(NetworkType.ever))
      .toList();

  List<cur.Currency> get venomCurrencies => _venomCurrenciesBox.values
      .map((e) => e.toModel(NetworkType.venom))
      .toList();

  Future<void> saveEverCurrency({
    required String address,
    required cur.Currency currency,
  }) =>
      _everCurrenciesBox.put(address, currency.toDto());

  Future<void> saveVenomCurrency({
    required String address,
    required cur.Currency currency,
  }) =>
      _venomCurrenciesBox.put(address, currency.toDto());

  Future<void> clearCurrencies() async {
    await _everCurrenciesBox.clear();
    await _venomCurrenciesBox.clear();
  }

  bool get getWhyNeedBrowser =>
      _preferencesBox.get(_browserNeedKey) as bool? ?? false;

  Future<void> saveWhyNeedBrowser() =>
      _preferencesBox.put(_browserNeedKey, true);

  bool get wasStEverOpened =>
      _preferencesBox.get(_wasStEverOpenedKey) as bool? ?? false;

  Future<void> saveWasStEverOpened() =>
      _preferencesBox.put(_wasStEverOpenedKey, true);

  List<BrowserTab> get browserTabs =>
      (_browserTabsBox.get(_browserTabsKey) as List<dynamic>?)
          ?.cast<BrowserTabDto>()
          .map((e) => e.toModel())
          .toList() ??
      <BrowserTab>[];

  int get browserTabsLastIndex =>
      _browserTabsBox.get(_browserTabsLastIndexKey) as int? ?? -1;

  Future<void> saveBrowserTabs(List<BrowserTab> tabs) =>
      _browserTabsBox.put(_browserTabsKey, tabs.map((e) => e.toDto()).toList());

  Future<void> saveBrowserTabsLastIndex(int lastIndex) =>
      _browserTabsBox.put(_browserTabsLastIndexKey, lastIndex);

  Future<void> dispose() => Hive.close();

  // TODO(alex-a4): delete boxes after some time to prevent data loss
  // Future<void> eraseHive() => Hive.deleteFromDisk();

  Future<void> _initialize() async {
    final key = Uint8List.fromList(
      [
        142,
        201,
        97,
        67,
        9,
        207,
        25,
        19,
        205,
        112,
        165,
        64,
        130,
        45,
        105,
        15,
        199,
        146,
        22,
        64,
        34,
        45,
        150,
        200,
        199,
        63,
        145,
        56,
        34,
        80,
        128,
        80
      ],
    );

    final usedAdapters = [1, 2, 3, 4, 55, 56, 221, 222, 223];

    Hive
      ..tryRegisterAdapter(TokenContractAssetDtoAdapter())
      ..tryRegisterAdapter(WalletContractTypeDtoAdapter())
      ..tryRegisterAdapter(PermissionsDtoAdapter())
      ..tryRegisterAdapter(AccountInteractionDtoAdapter())
      ..tryRegisterAdapter(BookmarkDtoAdapter())
      ..tryRegisterAdapter(SiteMetaDataDtoAdapter())
      ..tryRegisterAdapter(BrowserTabAdapter())
      ..tryRegisterAdapter(SearchHistoryDtoAdapter())
      ..tryRegisterAdapter(CurrencyDtoAdapter());

    for (var i = 1; i < 224; i++) {
      if (!usedAdapters.contains(i) && Hive.isAdapterRegistered(i)) {
        Hive.ignoreTypeId<Object>(i);
      }
    }

    await Hive.initFlutter();

    await Hive.openBox<String>(
      _keyPasswordsBoxName,
      encryptionCipher: HiveAesCipher(key),
    );
    await Hive.openBox<Object?>(_userPreferencesBoxName);
    await Hive.openBox<TokenContractAssetDto>(
      _everSystemTokenContractAssetsBoxName,
    );
    await Hive.openBox<TokenContractAssetDto>(
      _venomSystemTokenContractAssetsBoxName,
    );
    await Hive.openBox<TokenContractAssetDto>(
      _everCustomTokenContractAssetsBoxName,
    );
    await Hive.openBox<TokenContractAssetDto>(
      _venomCustomTokenContractAssetsBoxName,
    );
    await Hive.openBox<String>(_seedsBoxName);
    await Hive.openBox<String>(_nekotonFlutterBoxName);
    await Hive.openBox<dynamic>(_preferencesBoxName);
    await Hive.openBox<PermissionsDto>(_permissionsBoxName);
    await Hive.openBox<List<String>>(_externalAccountsBoxName);
    await Hive.openBox<BookmarkDto>(_bookmarksBoxName);
    await Hive.openBox<SearchHistoryDto>(_searchHistoryBoxName);
    await Hive.openBox<SiteMetaDataDto>(_siteMetaDataBoxName);
    await Hive.openBox<CurrencyDto>(_currenciesBoxName);
    await Hive.openBox<CurrencyDto>(_venomCurrenciesBoxName);
    await Hive.openBox<bool>(_browserNeedKey);
    await Hive.openBox<dynamic>(_browserTabsKey);
    await Hive.openBox<List<String>>(_hiddenAccountsKey);

    await _migrateStorage();
    await _migrateLastViewedSeeds();
  }

  /// Return true, if any sensitive data was found
  bool get _hasAnySensitiveData =>
      _nekotonFlutterBox.isNotEmpty ||
      _userPreferencesBox.isNotEmpty ||
      _preferencesBox.isNotEmpty;

  /// Check if some of hive boxes was opened
  @visibleForTesting
  bool checkIfSensitiveBoxesOpened() =>
      Hive.isBoxOpen(_nekotonFlutterBoxName) ||
      Hive.isBoxOpen(_userPreferencesBoxName) ||
      Hive.isBoxOpen(_preferencesBoxName);

  @visibleForTesting
  Future<File> get migrationFile async {
    final tempDir = await getTemporaryDirectory();
    return File('${tempDir.path}/migration.json');
  }

  @visibleForTesting
  Map<String, dynamic> get jsonData => {
        'nekoton': _nekotonFlutterBox.toJson(),
        'ever_custom':
            everCustomTokenContractAssets.map((e) => e.toJson()).toList(),
        'venom_custom':
            venomCustomTokenContractAssets.map((e) => e.toJson()).toList(),
        'ever_system':
            everSystemTokenContractAssets.map((e) => e.toJson()).toList(),
        'venom_system':
            venomSystemTokenContractAssets.map((e) => e.toJson()).toList(),
        'prefs': _preferencesBox.toJson(),
        'search_history': searchHistory
            .map(
              (e) => {'url': e.url, 'date': e.openTime.millisecondsSinceEpoch},
            )
            .toList(),
        'external_accounts': externalAccounts,
        'hidden_accounts': hiddenAccounts,
        'browser_tabs': browserTabs.map((e) => e.toJson()).toList(),
        'user_prefs': _userPreferencesBox.toJson(),
        'permissions':
            permissions.map((key, value) => MapEntry(key, value.toJson())),
        'passwords': _keyPasswordsBox.toJson(),
      };

  /// Migrate all data from old storage to temporary migration file to avoid
  /// losing data if problem occurs during migration.
  @visibleForTesting
  Future<void> saveStorageData() async {
    try {
      final tempJsonData = jsonData;
      final migrationFile = await this.migrationFile;
      await migrationFile.writeAsString(jsonEncode(tempJsonData));
    } catch (e, t) {
      _migrationLogger.severe('saveStorageData', e, t);
    }
  }

  /// This is old migration (not linked to migration to EncryptedStorage)
  Future<void> _migrateStorage() async {
    try {
      final directory = await getApplicationDocumentsDirectory();

      final file = File('${directory.path}/nekoton_storage.db');

      final content = await file.readAsString();

      final json = jsonDecode(content) as List<dynamic>;
      final map =
          json.cast<Map<String, dynamic>>().first.cast<String, String>();
      final keystoreDataStr = map[keystoreStorageKey];
      final accountsStorageDataStr = map[accountsStorageKey];

      if (keystoreDataStr != null) {
        final keystoreData = jsonDecode(keystoreDataStr) as String;
        await _nekotonFlutterBox.put(keystoreStorageKey, keystoreData);
      }

      if (accountsStorageDataStr != null) {
        final accountsStorageData =
            jsonDecode(accountsStorageDataStr) as String;
        await _nekotonFlutterBox.put(accountsStorageKey, accountsStorageData);
      }

      await file.delete();
    } catch (_) {}
  }

  // TODO(alex-a4): move this migration to EncryptedStorage
  /// Put all master names from [masterKeysNames] into [_seedsBox]
  ///  This can happens only one time after app upgrading when there were old
  ///  box with names.
  ///
  /// Function is public because names of keys were stored in keystore, not in
  /// box.
  Future<void> migrateSeedsNames(Map<String, String> masterKeysNames) async {
    const labelsBoxName = 'public_keys_labels_v1';
    if (await Hive.boxExists(labelsBoxName)) {
      final box = await Hive.openBox<String>(labelsBoxName);

      for (final publicKey in masterKeysNames.keys) {
        await _seedsBox.put(publicKey, masterKeysNames[publicKey]!);
      }

      await box.deleteFromDisk();
    }
  }

  /// If app was initialized before seeds order was added, then create fake
  /// order with currentKey
  /// at 1-st place.
  Future<void> _migrateLastViewedSeeds() async {
    final seedsKeys = seeds.keys.toList();
    if (lastViewedSeeds().isEmpty && seedsKeys.isNotEmpty) {
      if (currentKey != null) seedsKeys.insert(0, currentKey!);
      final fakeViewed = LinkedHashSet<String>.from(seedsKeys)
          .take(maxLastSelectedSeeds)
          .toList();
      return updateLastViewedSeeds(fakeViewed);
    }
  }
}

/// A service that migrates data from the old storage to the new one.
class MigrationService {
  MigrationService(
    this._storage,
    this._browserStorage,
    this._accountSeedStorage,
    this._hive,
  );

  final GeneralStorageService _storage;
  final BrowserStorageService _browserStorage;
  final NekotonStorageService _accountSeedStorage;
  final HiveSourceMigration _hive;

  /// Migration method for app that includes hive initialization.
  static Future<void> migrateWithHiveInit(
    GeneralStorageService storage,
    BrowserStorageService browserStorage,
    NekotonStorageService accountSeedStorage,
  ) async {
    return MigrationService(
      storage,
      browserStorage,
      accountSeedStorage,
      await HiveSourceMigration.create(),
    ).migrate();
  }

  /// This is a full process of migration with all steps.
  Future<void> migrate() async {
    if (await needMigration()) {
      try {
        await verifyMigrationFileExists();
        await applyMigration();
        await completeMigration();
      } catch (e, t) {
        _migrationLogger.severe('migrate()', e, t);
        // TODO(alex-a4): decide what to do with migration error
        rethrow;
      }
    } else {
      await completeMigration();
    }
  }

  /// Returns true if migration was not completed (no data in new storage
  /// and exists data in old storage).
  @visibleForTesting
  Future<bool> needMigration() async =>
      !(await _storage.isStorageMigrated) && _hive._hasAnySensitiveData;

  /// If migration file not exists and we decided to migrate, then we need
  /// to create this file.
  @visibleForTesting
  Future<void> verifyMigrationFileExists() async {
    final file = await _hive.migrationFile;
    if (!file.existsSync()) {
      await _hive.saveStorageData();
    }
  }

  /// Migrate all data from hive to new storage.
  @visibleForTesting
  Future<void> applyMigration() async {
    /// Storage
    for (final entry in _hive._storageData.entries) {
      await _accountSeedStorage.setStorageData(
        key: entry.key,
        value: entry.value,
      );
    }

    /// Seeds
    for (final entry in _hive.seeds.entries) {
      await _accountSeedStorage.addSeedOrRename(
        masterKey: entry.key,
        name: entry.value,
      );
    }

    /// Passwords
    for (final entry in _hive._passwords.entries) {
      await _storage.setKeyPassword(
        publicKey: entry.key,
        password: entry.value,
      );
    }

    /// System contracts
    await _storage
        .updateSystemTokenContractAssets(_hive.everSystemTokenContractAssets);
    await _storage
        .updateSystemTokenContractAssets(_hive.venomSystemTokenContractAssets);

    /// Custom contracts
    for (final asset in _hive.everCustomTokenContractAssets) {
      await _storage.addCustomTokenContractAsset(asset);
    }
    for (final asset in _hive.venomCustomTokenContractAssets) {
      await _storage.addCustomTokenContractAsset(asset);
    }

    /// Currencies
    for (final cur in _hive.everCurrencies) {
      await _storage.saveOrUpdateCurrency(currency: cur);
    }
    for (final cur in _hive.venomCurrencies) {
      await _storage.saveOrUpdateCurrency(currency: cur);
    }

    /// Permissions
    for (final entry in _hive.permissions.entries) {
      await _browserStorage.setPermissions(
        origin: entry.key,
        permissions: entry.value,
      );
    }

    /// Bookmarks
    for (final bookmark in _hive.bookmarks) {
      await _browserStorage.addBookmark(bookmark);
    }

    /// Search history
    for (final entry in _hive.searchHistory) {
      await _browserStorage.addSearchHistoryEntry(entry);
    }

    /// Site metadata
    for (final entry in _hive._siteMetadata.entries) {
      await _browserStorage.addSiteMetaData(
        url: entry.key,
        metaData: entry.value,
      );
    }

    /// Preferences
    if (_hive.locale != null) await _storage.setLocale(_hive.locale!);
    await _storage.setIsBiometryEnabled(isEnabled: _hive.isBiometryEnabled);
    if (_hive.wasStEverOpened) await _storage.saveWasStEverOpened();
    if (_hive.getWhyNeedBrowser) await _browserStorage.saveWhyNeedBrowser();
    await _storage.updateLastViewedKeys(_hive.lastViewedSeeds());
    await _accountSeedStorage.hideAccounts(_hive.hiddenAccounts);
    for (final entry in _hive.externalAccounts.entries) {
      await _accountSeedStorage.updateExternalAccounts(
        publicKey: entry.key,
        accounts: entry.value,
      );
    }
    if (_hive.currentConnection != null) {
      await _storage.setCurrentConnection(_hive.currentConnection!);
    }
    if (_hive.currentKey != null) {
      await _storage.setCurrentKey(_hive.currentKey!);
    }

    /// Browser
    await _browserStorage.saveBrowserTabsLastIndex(_hive.browserTabsLastIndex);
    await _browserStorage.saveBrowserTabs(_hive.browserTabs);
  }

  /// Complete migration by deleting temp file and closing boxes.
  @visibleForTesting
  Future<void> completeMigration() async {
    final file = await _hive.migrationFile;
    if (file.existsSync()) await file.delete();

    await _hive.dispose();
    await _storage.completeStorageMigration();
    // TODO(alex-a4): delete boxes after some time to prevent data loss
    // _hiveSourceMigration.eraseHive();
  }
}

extension<T> on Box<T> {
  /// For simple types
  Map<String, dynamic> toJson() => toMap().cast<String, dynamic>();
}

extension on HiveInterface {
  void tryRegisterAdapter<T>(TypeAdapter<T> adapter) {
    if (!isAdapterRegistered(adapter.typeId)) registerAdapter(adapter);
  }
}
