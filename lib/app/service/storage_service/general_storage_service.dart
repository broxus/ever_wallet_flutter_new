import 'dart:async';

import 'package:app/app/service/connection/network_type.dart';
import 'package:app/app/service/service.dart';
import 'package:app/data/models/custom_currency.dart';
import 'package:app/data/models/token_contract/token_contract_asset.dart';
import 'package:app/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Currency;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

const _biometryStatusKey = 'biometry_status_key';
const _currenciesKey = 'currencies_key';
const _currentAddress = 'current_address';
const _currentKey = 'current_public_key';

const _customContractAssetsKey = 'custom_contract_assets_key';
const _lastSelectedSeedsKey = 'last_selected_seeds_key';
const _migrationKey = 'migration_key';
const _preferencesKey = 'preferences_key';
const _systemContractAssetsKey = 'system_contract_assets_key';
const _wasStEverOpenedKey = 'was_stever_opened_key';

/// This is a wrapper-class above [GetStorage] that provides methods
/// to interact with general information that is not related to some specified
/// module.
/// This storage can be filled with data from the old version of the app via
/// migration service.
@singleton
class GeneralStorageService extends AbstractStorageService {
  GeneralStorageService(
    @Named(prefContainer) this._prefStorage,
    @Named(currenciesContainer) this._currenciesStorage,
    @Named(systemContractAssetsContainer) this._systemContractAssetsStorage,
    @Named(customContractAssetsContainer) this._customContractAssetsStorage,
  );

  static const prefContainer = _preferencesKey;
  static const currenciesContainer = _currenciesKey;
  static const systemContractAssetsContainer = _systemContractAssetsKey;
  static const customContractAssetsContainer = _customContractAssetsKey;
  static const containers = [
    prefContainer,
    currenciesContainer,
    systemContractAssetsContainer,
    customContractAssetsContainer,
  ];

  final GetStorage _prefStorage;
  final GetStorage _currenciesStorage;
  final GetStorage _systemContractAssetsStorage;
  final GetStorage _customContractAssetsStorage;

  /// Subject of public keys names
  final _currentKeySubject = BehaviorSubject<PublicKey?>();

  /// Subject of current active account address
  final _currentAddressSubject = BehaviorSubject<Address?>();

  /// Subject of last viewed seeds (master keys)
  final _lastViewedSeedsSubject = BehaviorSubject<List<PublicKey>>();

  /// Subject of system token contract assets
  final _systemTokenContractAssetsSubject =
      BehaviorSubject<Map<NetworkType, List<TokenContractAsset>>>();

  /// Subject of custom token contract assets
  final _customTokenContractAssetsSubject =
      BehaviorSubject<Map<NetworkType, List<TokenContractAsset>>>();

  /// Subject of biometry enabled status
  final _biometryEnabledSubject = BehaviorSubject<bool>();

  /// Subject of currencies by network type
  final _currencySubject =
      BehaviorSubject<Map<NetworkType, List<CustomCurrency>>>();

  /// Application documents directory, used for syncrhronous path operations
  late final String applicationDocumentsDirectory;

  /// Get last cached public key that user set before
  PublicKey? get currentKey => _currentKeySubject.valueOrNull;

  /// Get last cached active account address
  Address? get currentAddress => _currentAddressSubject.valueOrNull;

  /// Stream of public keys names
  Stream<PublicKey?> get currentKeyStream => _currentKeySubject;

  /// Stream of active account address
  Stream<Address?> get currentAddressStream => _currentAddressSubject;

  /// Get flag if What's StEver screen was shown
  bool get getWasStEverOpened {
    final value = _prefStorage.read<bool>(_wasStEverOpenedKey);
    return value ?? false;
  }

  /// Get last cached biometry enabled status
  bool get isBiometryEnabled => _biometryEnabledSubject.valueOrNull ?? false;

  /// Stream of biometry enabled status
  Stream<bool> get isBiometryEnabledStream => _biometryEnabledSubject;

  /// Return true if storage was migrated from old hive to this one
  bool get isStorageMigrated {
    final value = _prefStorage.read<bool>(_migrationKey);
    return value ?? false;
  }

  /// Get last cached viewed seeds (master keys)
  List<PublicKey> get lastViewedSeeds => _lastViewedSeedsSubject.value;

  /// Stream of last viewed seeds (master keys)
  Stream<List<PublicKey>> get lastViewedSeedsStream => _lastViewedSeedsSubject;

  /// Add custom token contract asset to list of tokens with same type.
  /// Ignores asset with duplicate address.
  void addCustomTokenContractAsset(
    TokenContractAsset tokenContractAsset,
  ) {
    final assets = readCustomTokenContractAssets(
      tokenContractAsset.networkType,
    );
    final newAssets = assets
        .where((e) => e.address != tokenContractAsset.address)
        .toList()
      ..add(tokenContractAsset);
    _customContractAssetsStorage.write(
      tokenContractAsset.networkType,
      newAssets.map((e) => e.toJson()).toList(),
    );
    _streamedCustomContractAssets();
  }

  /// Clear all custom tokens
  Future<void> clearAllContracts() async {
    try {
      await _systemContractAssetsStorage.erase();
    } catch (_) {}
  }

  /// Clear all custom tokens
  Future<void> clearAllCustomTokens() async {
    try {
      await _customContractAssetsStorage.erase();
    } catch (_) {}
    _customTokenContractAssetsSubject.add({});
  }

  /// Clear information about all currencies.
  Future<void> clearCurrencies() async {
    try {
      await _currenciesStorage.erase();
    } catch (_) {}
    _currencySubject.add({});
  }

  /// Delete information about biometry
  Future<void> clearIsBiometryEnabled() async {
    await _prefStorage.remove(_biometryStatusKey);
    _biometryEnabledSubject.add(false);
  }

  /// Clear all preferences data
  Future<void> clearPreferences() async {
    try {
      return await _prefStorage.erase();
    } catch (_) {}
  }

  @override
  Future<void> clear() async {
    await Future.wait([
      clearCurrencies(),
      clearPreferences(),
      clearIsBiometryEnabled(),
      clearAllContracts(),
      clearAllCustomTokens(),
    ]);

    _currentKeySubject.add(null);
    _currentAddressSubject.add(null);
    _lastViewedSeedsSubject.add([]);
    _systemTokenContractAssetsSubject.add({});
  }

  /// Set flag that storage was migrated from old hive to this one.
  /// This must happens only in the end of migration process.
  void completeStorageMigration() => _prefStorage.write(_migrationKey, true);

  /// Stream of currencies by specified network type
  Stream<List<CustomCurrency>> currenciesStream(NetworkType network) =>
      _currencySubject.map((event) => event[network] ?? []);

  /// Stream of custom token contract assets by specified network type
  Stream<List<TokenContractAsset>> customTokenContractAssetsStream(
    String network,
  ) =>
      _customTokenContractAssetsSubject.map((event) => event[network] ?? []);

  /// Delete all custom token contract assets with same type.
  void deleteCustomTokens(NetworkType type) {
    _customContractAssetsStorage.remove(type);
    _streamedCustomContractAssets();
  }

  /// Get last cached currencies by network type
  List<CustomCurrency> getCurrencies(NetworkType type) =>
      _currencySubject.value[type] ?? [];

  /// Get last cached custom token contract assets by network type
  List<TokenContractAsset> getCustomTokenContractAssets(NetworkType type) =>
      _customTokenContractAssetsSubject.value[type] ?? [];

  /// Get last cached system token contract assets by network type
  List<TokenContractAsset> getSystemTokenContractAssets(NetworkType network) =>
      _systemTokenContractAssetsSubject.value[network] ?? [];

  @override
  Future<void> init() async {
    await Future.wait(containers.map(GetStorage.init));
    await _initAppDirectories();
    _streamedSystemContractAssets();
    _streamedCustomContractAssets();
    _streamedCurrencies();
    _streamedCurrentKey();
    _streamedCurrentAddress();
    _streamedLastViewedSeeds();
    _streamedBiometryEnabled();
  }

  /// Read from storage list of all currencies specified for network type
  List<CustomCurrency> readCurrencies(NetworkType type) {
    final encoded = _currenciesStorage.read<List<dynamic>>(type);
    if (encoded == null) {
      return [];
    }
    return encoded
        .map((entry) => CustomCurrency.fromJson(entry as Map<String, dynamic>))
        .toList();
  }

  /// Read from storage current public key that user set before
  PublicKey? readCurrentKey() {
    final keyString = _prefStorage.read<String>(_currentKey);
    return keyString != null ? PublicKey(publicKey: keyString) : null;
  }

  /// Read from storage current public key that user set before
  Address? readCurrentAddress() {
    final value = _prefStorage.read<String>(_currentAddress);
    return value != null ? Address(address: value) : null;
  }

  /// Read from storage list of custom assets by network type
  List<TokenContractAsset> readCustomTokenContractAssets(
    NetworkType type,
  ) {
    final assets = _customContractAssetsStorage.read<List<dynamic>>(type);
    if (assets == null) {
      return [];
    }
    return assets.map(
      (json) {
        json = json as Map<String, dynamic>;
        if (json['isCustom'] == null) {
          json['isCustom'] = true;
        }

        return TokenContractAsset.fromJson(json);
      },
    ).toList();
  }

  /// Get if biometry is enabled in app
  bool readIsBiometryEnabled() {
    final value = _prefStorage.read<bool>(_biometryStatusKey);
    return value ?? false;
  }

  /// Returns up to [maxLastSelectedSeeds] public keys of seeds that were used.
  ///
  /// After updating to application version with this list, it's filled with 4
  /// (or less) random keys with [currentKey] at 1-st place.
  List<PublicKey> readLastViewedSeeds() {
    final seeds = _prefStorage.read<List<dynamic>>(_lastSelectedSeedsKey);
    if (seeds == null) {
      return [];
    }

    return seeds
        .cast<String>()
        .map((keyString) => PublicKey(publicKey: keyString))
        .toList();
  }

  /// Get list of system assets by network type
  List<TokenContractAsset> readSystemTokenContractAssets(
    NetworkType type,
  ) {
    final assets = _systemContractAssetsStorage.read<List<dynamic>>(type);
    if (assets == null) {
      return [];
    }

    return assets.map(
      (json) {
        json = json as Map<String, dynamic>;
        if (json['isCustom'] == null) {
          json['isCustom'] = false;
        }

        return TokenContractAsset.fromJson(json);
      },
    ).toList();
  }

  /// Remove custom token contract asset from list of tokens with same type.
  void removeCustomTokenContractAsset(
    TokenContractAsset asset,
  ) {
    final assets = readCustomTokenContractAssets(asset.networkType);
    final newAssets = assets.where((a) => a.address != asset.address).toList();
    _customContractAssetsStorage.write(
      asset.networkType,
      newAssets.map((e) => e.toJson()).toList(),
    );
    _streamedCustomContractAssets();
  }

  /// Save currencies to storage for specified network type.
  /// This ignores duplicates and saves only one currency with same address.
  void saveOrUpdateCurrencies({
    required List<CustomCurrency> currencies,
    required NetworkType networkType,
  }) {
    final list = readCurrencies(networkType);
    final keys = currencies.map((e) => e.address).toSet();
    final newList = list.where((e) => !keys.contains(e.address)).toList()
      ..addAll(currencies);

    _currenciesStorage.write(
      networkType,
      newList.map((e) => e.toJson()).toList(),
    );
    _streamedCurrencies();
  }

  /// Save currency to storage for specified network type.
  /// This ignores duplicates and saves only one currency with same address.
  void saveOrUpdateCurrency({required CustomCurrency currency}) {
    final type = currency.networkType;
    final list = readCurrencies(type);
    final newList = list.where((e) => e.address != currency.address).toList()
      ..add(currency);

    _currenciesStorage.write(
      type,
      newList.map((e) => e.toJson()).toList(),
    );
    _streamedCurrencies();
  }

  /// Set flag that What's StEver screen was shown
  void saveWasStEverOpened() => _prefStorage.write(_wasStEverOpenedKey, true);

  /// Set current public key of user
  void setCurrentKey(PublicKey publicKey) {
    _prefStorage.write(_currentKey, publicKey.toJson());
    _streamedCurrentKey();
  }

  void setCurrentAddress(Address? address) {
    _prefStorage.write(_currentAddress, address?.toJson());
    _streamedCurrentAddress();
  }

  /// Set if biometry is enabled in app
  void setIsBiometryEnabled({required bool isEnabled}) {
    _prefStorage.write(_biometryStatusKey, isEnabled);
    _streamedBiometryEnabled();
  }

  /// Stream of system token contract assets by specified network type
  Stream<List<TokenContractAsset>> systemTokenContractAssetsStream(
    NetworkType network,
  ) =>
      _systemTokenContractAssetsSubject.map((event) => event[network] ?? []);

  /// Update seeds that were used by user.
  /// There must be only master keys, if key is sub, then put its master.
  /// Count of seeds must be less or equals to [maxLastSelectedSeeds] and
  /// cropped outside.
  void updateLastViewedSeeds(List<PublicKey> seedsKeys) {
    _prefStorage.write(
      _lastSelectedSeedsKey,
      seedsKeys.map((e) => e.toJson()).toList(),
    );
    _streamedLastViewedSeeds();
  }

  /// Clear previous system assets and set new ones
  void updateSystemTokenContractAssets(
    List<TokenContractAsset> assets,
  ) {
    if (assets.isNotEmpty) {
      assert(
        assets.every((asset) => asset.networkType == assets.first.networkType),
        'All system assets must have the same type',
      );
      _systemContractAssetsStorage
        ..remove(
          assets.first.networkType,
        )
        ..write(
          assets.first.networkType,
          assets.map((e) => e.toJson()).toList(),
        );
      _streamedSystemContractAssets();
    }
  }

  Future<void> _initAppDirectories() async {
    final directory = await getApplicationDocumentsDirectory();
    applicationDocumentsDirectory = directory.path;
  }

  /// Convert biometry enabled status to stream
  void _streamedBiometryEnabled() =>
      _biometryEnabledSubject.add(readIsBiometryEnabled());

  /// Put custom token contract assets to stream
  void _streamedCurrencies() {
    final encoded = _currenciesStorage.getEntries();
    final decoded = encoded.map(
      (key, value) => MapEntry(
        key,
        (value as List<dynamic>)
            .map(
              (json) => CustomCurrency.fromJson(json as Map<String, dynamic>),
            )
            .toList(),
      ),
    );
    _currencySubject.add(decoded);
  }

  /// Put current public key of user to stream
  void _streamedCurrentKey() => _currentKeySubject.add(readCurrentKey());

  /// Put current active account address to stream
  void _streamedCurrentAddress() => _currentAddressSubject.add(
        readCurrentAddress(),
      );

  /// Put custom token contract assets to stream
  void _streamedCustomContractAssets() {
    final encoded = _customContractAssetsStorage.getEntries();
    final decoded = encoded.map(
      (key, value) => MapEntry(
        key,
        (value as List<dynamic>).map(
          (json) {
            json = json as Map<String, dynamic>;
            if (json['isCustom'] == null) {
              json['isCustom'] = true;
            }

            return TokenContractAsset.fromJson(json);
          },
        ).toList(),
      ),
    );
    _customTokenContractAssetsSubject.add(decoded);
  }

  /// Put last viewed seeds (master keys) to stream
  void _streamedLastViewedSeeds() =>
      _lastViewedSeedsSubject.add(readLastViewedSeeds());

  /// Put system token contract assets to stream
  void _streamedSystemContractAssets() {
    final encoded = _systemContractAssetsStorage.getEntries();
    final decoded = encoded.map(
      (key, value) => MapEntry(
        key,
        (value as List<dynamic>).map(
          (json) {
            json = json as Map<String, dynamic>;
            if (json['isCustom'] == null) {
              json['isCustom'] = false;
            }

            return TokenContractAsset.fromJson(json);
          },
        ).toList(),
      ),
    );
    _systemTokenContractAssetsSubject.add(decoded);
  }
}
