import 'dart:async';
import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/currency.dart';
import 'package:app/data/models/network_type.dart';
import 'package:app/data/models/token_contract_asset.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Currency;
import 'package:rxdart/rxdart.dart';

/// List of keys to store in storage
const _migrationKey = 'migration_key';
const _passwordsKey = 'passwords_key';
const _systemContractAssetsKey = 'system_contract_assets_key';
const _customContractAssetsKey = 'custom_contract_assets_key';
const _preferencesKey = 'preferences_key';
const _currenciesKey = 'currencies_key';
const _biometryStatusKey = 'biometry_status_key';
const _currentConnectionKey = 'current_connection_key';
const _localeKey = 'locale';
const _wasStEverOpenedKey = 'was_stever_opened_key';
const _currentKey = 'current_public_key';
const _lastSelectedSeedsKey = 'last_selected_seeds_key';

/// This is a wrapper-class above [EncryptedStorage] that provides methods
/// to interact with general information that is not related to some specified
/// module.
/// This storage can be filled with data from the old version of the app via
/// migration service.
@singleton
class GeneralStorageService extends AbstractStorageService {
  GeneralStorageService(this._storage);

  /// Storage that is used to store data
  final EncryptedStorage _storage;

  @override
  Future<void> init() => Future.wait([
        _streamedCurrentConnection(),
        _streamedSystemContractAssets(),
        _streamedCustomContractAssets(),
        _streamedCurrencies(),
        _streamedLocale(),
        _streamedCurrentKey(),
        _streamedLastViewedSeeds(),
      ]);

  @override
  Future<void> clearSensitiveData() => Future.wait([
        clearKeyPasswords(),
        clearCurrencies(),
        clearPreferences(),
      ]);

  /// Clear all preferences data
  Future<void> clearPreferences() => _storage.clearDomain(_preferencesKey);

  /// Subject of public keys names
  final _currentKeySubject = BehaviorSubject<String?>();

  /// Stream of public keys names
  Stream<String?> get currentKeyStream => _currentKeySubject;

  /// Get last cached public key that user set before
  String? get currentKey => _currentKeySubject.valueOrNull;

  /// Read from storage current public key that user set before
  Future<String?> readCurrentKey() =>
      _storage.get(_currentKey, domain: _preferencesKey);

  /// Put current public key of user to stream
  Future<void> _streamedCurrentKey() async =>
      _currentKeySubject.add(await readCurrentKey());

  /// Set current public key of user
  Future<void> setCurrentKey(String publicKey) => _storage
      .set(
        _currentKey,
        publicKey,
        domain: _preferencesKey,
      )
      .then((_) => _streamedCurrentKey());

  /// Subject of last viewed seeds (master keys)
  final _lastViewedSeedsSubject = BehaviorSubject<List<String>>();

  /// Stream of last viewed seeds (master keys)
  Stream<List<String>> get lastViewedSeedsStream => _lastViewedSeedsSubject;

  /// Get last cached viewed seeds (master keys)
  List<String> get lastViewedSeeds => _lastViewedSeedsSubject.value;

  /// Put last viewed seeds (master keys) to stream
  Future<void> _streamedLastViewedSeeds() async =>
      _lastViewedSeedsSubject.add(await readLastViewedSeeds());

  /// Returns up to [maxLastSelectedSeeds] public keys of seeds that were used.
  ///
  /// After updating to application version with this list, it's filled with 4
  /// (or less) random keys with [currentKey] at 1-st place.
  Future<List<String>> readLastViewedSeeds() async {
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
  Future<void> updateLastViewedSeeds(List<String> seedsKeys) => _storage
      .set(
        _lastSelectedSeedsKey,
        jsonEncode(seedsKeys),
        domain: _preferencesKey,
      )
      .then((_) => _streamedLastViewedSeeds());

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

  /// Subject of current connection
  final _currentConnectionSubject = BehaviorSubject<String?>();

  /// Stream of current connection
  Stream<String?> get currentConnectionStream => _currentConnectionSubject;

  /// Get last cached current connection
  String? get currentConnection => _currentConnectionSubject.valueOrNull;

  /// Put current connection to stream
  Future<void> _streamedCurrentConnection() async =>
      _currentConnectionSubject.add(await readCurrentConnection());

  /// Read from storage current connection of network by name
  Future<String?> readCurrentConnection() =>
      _storage.get(_currentConnectionKey, domain: _preferencesKey);

  /// Set current connection of network by name
  Future<void> setCurrentConnection(String currentConnection) => _storage
      .set(
        _currentConnectionKey,
        currentConnection,
        domain: _preferencesKey,
      )
      .then((_) => _streamedCurrentConnection());

  /// Subject of system token contract assets
  final _systemTokenContractAssetsSubject =
      BehaviorSubject<Map<NetworkType, List<TokenContractAsset>>>();

  /// Stream of system token contract assets by specified network type
  Stream<List<TokenContractAsset>> systemTokenContractAssetsStream(
    NetworkType network,
  ) =>
      _systemTokenContractAssetsSubject.map((event) => event[network] ?? []);

  /// Get last cached system token contract assets by network type
  List<TokenContractAsset> getSystemTokenContractAssets(NetworkType network) =>
      _systemTokenContractAssetsSubject.value[network] ?? [];

  /// Put system token contract assets to stream
  Future<void> _streamedSystemContractAssets() async {
    final encoded = await _storage.getDomain(domain: _systemContractAssetsKey);
    final decoded = encoded.map(
      (key, value) => MapEntry(
        NetworkType.values[int.parse(key)],
        (jsonDecode(value) as List<dynamic>)
            .map(
              (asset) =>
                  TokenContractAsset.fromJson(asset as Map<String, dynamic>),
            )
            .toList(),
      ),
    );
    _systemTokenContractAssetsSubject.add(decoded);
  }

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
      unawaited(_streamedSystemContractAssets());
    }
  }

  /// Get list of system assets by network type
  Future<List<TokenContractAsset>> readSystemTokenContractAssets(
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

  /// Subject of custom token contract assets
  final _customTokenContractAssetsSubject =
      BehaviorSubject<Map<NetworkType, List<TokenContractAsset>>>();

  /// Stream of custom token contract assets by specified network type
  Stream<List<TokenContractAsset>> customTokenContractAssetsStream(
    NetworkType network,
  ) =>
      _customTokenContractAssetsSubject.map((event) => event[network] ?? []);

  /// Get last cached custom token contract assets by network type
  List<TokenContractAsset> getCustomTokenContractAssets(NetworkType type) =>
      _customTokenContractAssetsSubject.value[type] ?? [];

  /// Put custom token contract assets to stream
  Future<void> _streamedCustomContractAssets() async {
    final encoded = await _storage.getDomain(domain: _customContractAssetsKey);
    final decoded = encoded.map(
      (key, value) => MapEntry(
        NetworkType.values[int.parse(key)],
        (jsonDecode(value) as List<dynamic>)
            .map(
              (asset) =>
                  TokenContractAsset.fromJson(asset as Map<String, dynamic>),
            )
            .toList(),
      ),
    );
    _customTokenContractAssetsSubject.add(decoded);
  }

  /// Read from storage list of custom assets by network type
  Future<List<TokenContractAsset>> readCustomTokenContractAssets(
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
    final assets = await readCustomTokenContractAssets(
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
    unawaited(_streamedCustomContractAssets());
  }

  /// Remove custom token contract asset from list of tokens with same type.
  Future<void> removeCustomTokenContractAsset(
    TokenContractAsset asset,
  ) async {
    final assets = await readCustomTokenContractAssets(asset.networkType);
    final newAssets = assets.where((a) => a.address != asset.address).toList();
    await _storage.set(
      asset.networkType.index.toString(),
      jsonEncode(newAssets),
      domain: _customContractAssetsKey,
    );
    unawaited(_streamedCustomContractAssets());
  }

  /// Delete all custom token contract assets with same type.
  Future<void> deleteCustomTokens(NetworkType type) => _storage
      .delete(
        type.index.toString(),
        domain: _customContractAssetsKey,
      )
      .then((value) => _streamedCustomContractAssets());

  /// Clear all custom tokens
  Future<void> clearAllCustomTokens() => _storage
      .clearDomain(_customContractAssetsKey)
      .then((value) => _customTokenContractAssetsSubject.add({}));

  /// Subject of locale
  final _localeSubject = BehaviorSubject<String?>();

  /// Stream of locale
  Stream<String?> get localeStream => _localeSubject;

  /// Get last cached locale
  String? get locale => _localeSubject.valueOrNull;

  Future<void> _streamedLocale() async =>
      _localeSubject.add(await readLocale());

  /// Read from storage locale that used could save in settings
  Future<String?> readLocale() =>
      _storage.get(_localeKey, domain: _preferencesKey);

  /// Set locale that used could save in settings
  Future<void> setLocale(String locale) => _storage
      .set(_localeKey, locale, domain: _preferencesKey)
      .then((_) => _streamedLocale());

  /// Clear locale
  Future<void> clearLocale() => _storage
      .delete(_localeKey, domain: _preferencesKey)
      .then((_) => _localeSubject.add(null));

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

  /// Subject of currencies by network type
  final _currencySubject = BehaviorSubject<Map<NetworkType, List<Currency>>>();

  /// Stream of currencies by specified network type
  Stream<List<Currency>> currenciesStream(NetworkType network) =>
      _currencySubject.map((event) => event[network] ?? []);

  /// Get last cached currencies by network type
  List<Currency> getCurrencies(NetworkType type) =>
      _currencySubject.value[type] ?? [];

  /// Put custom token contract assets to stream
  Future<void> _streamedCurrencies() async {
    final encoded = await _storage.getDomain(domain: _currenciesKey);
    final decoded = encoded.map(
      (key, value) => MapEntry(
        NetworkType.values[int.parse(key)],
        (jsonDecode(value) as List<dynamic>)
            .map((entry) => Currency.fromJson(entry as Map<String, dynamic>))
            .toList(),
      ),
    );
    _currencySubject.add(decoded);
  }

  /// Read from storage list of all currencies specified for network type
  Future<List<Currency>> readCurrencies(NetworkType type) async {
    final encoded = await _storage.get(
      type.index.toString(),
      domain: _currenciesKey,
    );
    if (encoded == null) {
      return [];
    }
    final list = jsonDecode(encoded) as List<dynamic>;
    return list
        .map((entry) => Currency.fromJson(entry as Map<String, dynamic>))
        .toList();
  }

  /// Save currency to storage for specified network type.
  /// This ignores duplicates and saves only one currency with same address.
  Future<void> saveOrUpdateCurrency({required Currency currency}) async {
    final type = currency.networkType;
    final list = await readCurrencies(type);
    final newList = list.where((e) => e.address != currency.address).toList()
      ..add(currency);

    return _storage
        .set(
          type.index.toString(),
          jsonEncode(newList),
          domain: _currenciesKey,
        )
        .then((_) => _streamedCurrencies());
  }

  /// Clear information about all currencies.
  Future<void> clearCurrencies() => _storage
      .clearDomain(_currenciesKey)
      .then((_) => _currencySubject.add({}));

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

  /// Return true if storage was migrated from old hive to this one
  Future<bool> get isStorageMigrated async {
    final encoded = await _storage.get(_migrationKey, domain: _preferencesKey);
    return jsonDecode(encoded ?? 'false') as bool;
  }

  /// Set flag that storage was migrated from old hive to this one.
  /// This must happens only in the end of migration process.
  Future<void> completeStorageMigration() => _storage.set(
        _migrationKey,
        jsonEncode(true),
        domain: _preferencesKey,
      );
}
