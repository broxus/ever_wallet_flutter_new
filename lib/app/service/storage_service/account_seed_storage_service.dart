import 'dart:convert';
import 'package:app/app/constants.dart';
import 'package:app/app/service/storage_service/abstract_storage_service.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

const _hiddenAccountsKey = 'hidden_accounts_key';
const _seedsKey = 'seeds_key';
const _externalAccountsKey = 'external_accounts_key';
const _currentKey = 'current_public_key';
const _lastSelectedSeedsKey = 'last_selected_seeds_key';

const _accountSeedPreferencesKey = 'account_seed_preferences_key';

/// This is a wrapper-class above [EncryptedStorage] that provides methods
/// to interact account/seed/public keys.
@singleton
class AccountSeedStorageService extends AbstractStorageService {
  AccountSeedStorageService(this._storage);

  /// Storage that is used to store data
  final EncryptedStorage _storage;

  @override
  Future<void> init() => Future.wait([
        _streamedSeeds(),
        _streamedCurrentKey(),
        _streamedLastViewedSeeds(),
        _streamedHiddenAccounts(),
        _streamedExternalAccounts(),
      ]);

  @override
  Future<void> clearSensitiveData() => Future.wait([
        clearPreferences(),
        clearSeeds(),
        clearExternalAccounts(),
      ]);

  /// Subject of public keys names
  final _seedsSubject = BehaviorSubject<Map<String, String>>();

  /// Stream of public keys names
  Stream<Map<String, String>> get seedsStream => _seedsSubject.stream;

  /// Put public keys names to stream
  Future<void> _streamedSeeds() async => _seedsSubject.add(await seeds);

  /// Get all names of public keys
  Future<Map<String, String>> get seeds =>
      _storage.getDomain(domain: _seedsKey);

  /// Add or rename public key
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

  /// Subject of public keys names
  final _currentKeySubject = BehaviorSubject<String?>();

  /// Stream of public keys names
  Stream<String?> get currentKeyStream => _currentKeySubject.stream;

  /// Get current public key that user set before
  Future<String?> get currentKey =>
      _storage.get(_currentKey, domain: _accountSeedPreferencesKey);

  /// Put current public key of user to stream
  Future<void> _streamedCurrentKey() async =>
      _currentKeySubject.add(await currentKey);

  /// Set current public key of user
  Future<void> setCurrentKey(String publicKey) => _storage
      .set(
        _currentKey,
        publicKey,
        domain: _accountSeedPreferencesKey,
      )
      .then((_) => _streamedCurrentKey());

  /// Subject of last viewed seeds
  final _lastViewedSeedsSubject = BehaviorSubject<List<String>>();

  /// Stream of last viewed seeds
  Stream<List<String>> get lastViewedSeedsStream =>
      _lastViewedSeedsSubject.stream;

  /// Put last viewed seeds to stream
  Future<void> _streamedLastViewedSeeds() async =>
      _lastViewedSeedsSubject.add(await lastViewedSeeds());

  /// Returns up to [maxLastSelectedSeeds] public keys of seeds that were used.
  ///
  /// After updating to application version with this list, it's filled with 4
  /// (or less) random keys with [currentKey] at 1-st place.
  Future<List<String>> lastViewedSeeds() async {
    final seeds = await _storage.get(
      _lastSelectedSeedsKey,
      domain: _accountSeedPreferencesKey,
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
        domain: _accountSeedPreferencesKey,
      )
      .then((_) => _streamedLastViewedSeeds());

  /// Subject of hidden accounts
  final _hiddenAccountsSubject = BehaviorSubject<List<String>>();

  /// Stream of hidden accounts
  Stream<List<String>> get hiddenAccountsStream =>
      _hiddenAccountsSubject.stream;

  /// Put last viewed seeds to stream
  Future<void> _streamedHiddenAccounts() async =>
      _hiddenAccountsSubject.add(await hiddenAccounts);

  /// List of addresses of accounts that were hidden by user
  Future<List<String>> get hiddenAccounts async {
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

  /// Hide account address so it won't be displayed at accounts list
  Future<void> hideAccount(String address) async {
    final accounts = await hiddenAccounts;
    accounts.add(address);
    return _storage
        .set(
          _hiddenAccountsKey,
          jsonEncode(accounts.toSet().toList()),
          domain: _accountSeedPreferencesKey,
        )
        .then((_) => _streamedHiddenAccounts());
  }

  /// Show account address so it will be displayed at accounts list
  Future<void> showAccount(String address) async {
    final accounts = await hiddenAccounts;
    accounts.remove(address);
    return _storage
        .set(
          _hiddenAccountsKey,
          jsonEncode(accounts),
          domain: _accountSeedPreferencesKey,
        )
        .then((_) => _streamedHiddenAccounts());
  }

  /// Remove information about hidden account (make it visible)
  Future<void> removeHiddenIfPossible(String address) async {
    final accounts = (await hiddenAccounts)..remove(address);
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

  // Subject of external accounts
  final _externalAccountsSubject = BehaviorSubject<Map<String, List<String>>>();

  /// Stream of external accounts
  Stream<Map<String, List<String>>> get externalAccountsStream =>
      _externalAccountsSubject.stream;

  /// Put last viewed seeds to stream
  Future<void> _streamedExternalAccounts() async =>
      _externalAccountsSubject.add(await externalAccounts);

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
