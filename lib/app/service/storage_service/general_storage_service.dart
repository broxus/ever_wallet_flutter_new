import 'dart:async';
import 'dart:convert';

import 'package:app/app/service/storage_service/abstract_storage_service.dart';
import 'package:app/data/models/currency.dart';
import 'package:app/data/models/network_type.dart';
import 'package:app/data/models/token_contract_asset.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

/// List of keys to store in storage
const _migrationKey = 'migration_key';
const _passwordsKey = 'passwords_key';
const _systemContractAssetsKey = 'system_contract_assets_key';
const _customContractAssetsKey = 'custom_contract_assets_key';
const _nekotonBridgeKey = 'nekoton_bridge_key';
const _preferencesKey = 'preferences_key';
const _currenciesKey = 'currencies_key';
const _biometryStatusKey = 'biometry_status_key';
const _currentConnectionKey = 'current_connection_key';
const _localeKey = 'locale';
const _wasStEverOpenedKey = 'was_stever_opened_key';

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
      ]);

  @override
  Future<void> clearSensitiveData() => Future.wait([
        clearStorageData(),
        clearKeyPasswords(),
        clearCurrencies(),
        clearPreferences(),
      ]);

  /// Clear all preferences data
  Future<void> clearPreferences() => _storage.clearDomain(_preferencesKey);

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
  Stream<String?> get currentConnectionStream =>
      _currentConnectionSubject.stream;

  /// Put current connection to stream
  Future<void> _streamedCurrentConnection() async =>
      _currentConnectionSubject.add(await currentConnection);

  /// Get current connection of network by name
  Future<String?> get currentConnection =>
      _storage.get(_currentConnectionKey, domain: _preferencesKey);

  /// Set current connection of network by name
  Future<void> setCurrentConnection(String currentConnection) => _storage
      .set(
        _currentConnectionKey,
        currentConnection,
        domain: _preferencesKey,
      )
      .then((_) => _streamedCurrentConnection());

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

  /// Subject of system token contract assets
  final _systemTokenContractAssetsSubject =
      BehaviorSubject<Map<NetworkType, List<TokenContractAsset>>>();

  /// Stream of system token contract assets by specified network type
  Stream<List<TokenContractAsset>> systemTokenContractAssetsStream(
    NetworkType network,
  ) =>
      _systemTokenContractAssetsSubject.stream
          .map((event) => event[network] ?? []);

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

  /// Subject of custom token contract assets
  final _customTokenContractAssetsSubject =
      BehaviorSubject<Map<NetworkType, List<TokenContractAsset>>>();

  /// Stream of custom token contract assets by specified network type
  Stream<List<TokenContractAsset>> customTokenContractAssetsStream(
    NetworkType network,
  ) =>
      _customTokenContractAssetsSubject.stream
          .map((event) => event[network] ?? []);

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
    unawaited(_streamedCustomContractAssets());
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
  Stream<String?> get localeStream => _localeSubject.stream;

  Future<void> _streamedLocale() async => _localeSubject.add(await locale);

  /// Get locale that used could save in settings
  Future<String?> get locale =>
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
      _currencySubject.stream.map((event) => event[network] ?? []);

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
        .map((entry) => Currency.fromJson(entry as Map<String, dynamic>))
        .toList();
  }

  /// Save currency to storage for specified network type.
  /// This ignores duplicates and saves only one currency with same address.
  Future<void> saveOrUpdateCurrency({required Currency currency}) async {
    final type = currency.networkType;
    final list = await getCurrencies(type);
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
