import 'dart:convert';

import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:rxdart/rxdart.dart';

const _hiddenAccountsKey = 'hidden_accounts_key';
const _seedsKey = 'seeds_key';
const _nekotonBridgeKey = 'nekoton_bridge_key';
const _externalAccountsKey = 'external_accounts_key';

const _accountSeedPreferencesKey = 'account_seed_preferences_key';

/// This is a wrapper-class above [EncryptedStorage] that provides methods
/// to interact with account/seed/public keys and all nekoton's related things.
class NekotonStorageRepository {
  NekotonStorageRepository(this._storage);

  /// Storage that is used to store data
  final EncryptedStorage _storage;

  Future<void> init() => Future.wait([
        _streamedSeeds(),
        _streamedHiddenAccounts(),
        _streamedExternalAccounts(),
      ]);

  Future<void> clearSensitiveData() => Future.wait([
        clearPreferences(),
        clearStorageData(),
        clearSeeds(),
        clearExternalAccounts(),
      ]);

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

  /// Subject of public keys names
  final _seedsSubject = BehaviorSubject<Map<String, String>>();

  /// Stream of public keys names
  Stream<Map<String, String>> get seedsStream => _seedsSubject;

  /// Get previously cached seeds
  Map<String, String> get seeds => _seedsSubject.value;

  /// Put public keys names to stream
  Future<void> _streamedSeeds() async => _seedsSubject.add(await readSeeds());

  /// Get all names of public keys from storage
  Future<Map<String, String>> readSeeds() =>
      _storage.getDomain(domain: _seedsKey);

  /// Add or rename public key
  // TODO(alex-a4): remove this method and move this names inside keys calling
  //   updateKey
  Future<void> addSeedOrRename({
    required String masterKey,
    required String name,
  }) =>
      _storage
          .set(masterKey, name, domain: _seedsKey)
          .then((_) => _streamedSeeds());

  /// Remove name of public key
  Future<void> removeSeed(String masterKey) => _storage
      .delete(masterKey, domain: _seedsKey)
      .then((_) => _streamedSeeds());

  /// Clear information about all names of public keys
  Future<void> clearSeeds() =>
      _storage.clearDomain(_seedsKey).then((_) => _seedsSubject.add({}));

  /// Subject of hidden accounts
  final _hiddenAccountsSubject = BehaviorSubject<List<String>>();

  /// Get previously cached hidden accounts
  List<String> get hiddenAccounts => _hiddenAccountsSubject.value;

  /// Stream of hidden accounts
  Stream<List<String>> get hiddenAccountsStream => _hiddenAccountsSubject;

  /// Put last viewed seeds to stream
  Future<void> _streamedHiddenAccounts() async =>
      _hiddenAccountsSubject.add(await readHiddenAccounts());

  /// Read from storage list of addresses of accounts that were hidden by user
  Future<List<String>> readHiddenAccounts() async {
    final accounts = await _storage.get(
      _hiddenAccountsKey,
      domain: _accountSeedPreferencesKey,
    );
    if (accounts == null) {
      return [];
    }
    final accountsList = jsonDecode(accounts) as List<dynamic>;
    return accountsList.cast<String>();
  }

  /// Hide account addresses so it won't be displayed at accounts list
  Future<void> hideAccounts(List<String> addresses) async {
    final accounts = await readHiddenAccounts();
    accounts.addAll(addresses);
    return _storage
        .set(
          _hiddenAccountsKey,
          jsonEncode(accounts.toSet().toList()),
          domain: _accountSeedPreferencesKey,
        )
        .then((_) => _streamedHiddenAccounts());
  }

  /// Show account addresses so it will be displayed at accounts list
  Future<void> showAccounts(List<String> addresses) async {
    final accounts = await readHiddenAccounts();
    accounts.removeWhere((a) => addresses.contains(a));
    return _storage
        .set(
          _hiddenAccountsKey,
          jsonEncode(accounts),
          domain: _accountSeedPreferencesKey,
        )
        .then((_) => _streamedHiddenAccounts());
  }

  /// Clear information about hidden accounts
  Future<void> clearHiddenAccounts() => _storage
      .delete(
        _hiddenAccountsKey,
        domain: _accountSeedPreferencesKey,
      )
      .then((_) => _hiddenAccountsSubject.add([]));

  /// Subject of external accounts
  final _externalAccountsSubject = BehaviorSubject<Map<String, List<String>>>();

  /// Get previously cached external accounts
  Map<String, List<String>> get externalAccounts =>
      _externalAccountsSubject.value;

  /// Stream of external accounts
  Stream<Map<String, List<String>>> get externalAccountsStream =>
      _externalAccountsSubject;

  /// Put last viewed seeds to stream
  Future<void> _streamedExternalAccounts() async =>
      _externalAccountsSubject.add(await readExternalAccounts());

  /// Read from storage external accounts where key - public key,
  /// value - list of addresses of accounts
  Future<Map<String, List<String>>> readExternalAccounts() async {
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

    return _storage
        .set(
          publicKey,
          jsonEncode(accounts),
          domain: _externalAccountsKey,
        )
        .then((_) => _streamedExternalAccounts());
  }

  /// Update list of accounts for specified [publicKey].
  Future<void> updateExternalAccounts({
    required String publicKey,
    required List<String> accounts,
  }) =>
      _storage
          .set(
            publicKey,
            jsonEncode(accounts),
            domain: _externalAccountsKey,
          )
          .then((_) => _streamedExternalAccounts());

  /// Remove external account for specified [publicKey]
  Future<void> removeExternalAccounts({
    required String publicKey,
    required List<String> addresses,
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

    accounts.removeWhere((a) => addresses.contains(a));

    return _storage
        .set(
          publicKey,
          jsonEncode(accounts),
          domain: _externalAccountsKey,
        )
        .then((_) => _streamedExternalAccounts());
  }

  /// Clear all external accounts
  Future<void> clearExternalAccounts() => _storage
      .clearDomain(_externalAccountsKey)
      .then((_) => _externalAccountsSubject.add({}));

  /// Clear information about all preferences
  Future<void> clearPreferences() =>
      _storage.clearDomain(_accountSeedPreferencesKey);
}
