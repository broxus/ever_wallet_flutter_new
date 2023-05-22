import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Any seed of application, that contains [masterKey] and [subKeys].
/// [masterKey] is a main key that derives directly from seed phrase.
/// [subKeys] is a list of keys that derives from [masterKey].
///
/// This instance is immutable and it can't change its state.
/// To listen SeedList changes, use [NekotonRepository.seedsStream]
@immutable
class Seed {
  const Seed({
    required this.masterKey,
    required this.subKeys,
  });

  /// Master key of seed.
  /// This key is derived directly from seed phrase.
  final KeyStoreEntry masterKey;

  /// List of derived keys of [masterKey].
  /// This list do not contains [masterKey].
  final List<KeyStoreEntry> subKeys;

  /// Just for iterating over all keys.
  List<KeyStoreEntry> get allKeys => [masterKey, ...subKeys];

  /// Derive keys from [masterKey] this call adds list of sub keys to
  /// [subKeys].
  /// This method returns list of public keys that allows add additional logic
  /// related to newly added keys.
  Future<List<String>> deriveKeys({
    required List<int> accountIds,
    required String password,
  }) =>
      GetIt.instance<SeedKeyRepository>().deriveKeys(
        accountIds: accountIds,
        password: password,
        masterKey: masterKey.publicKey,
      );

  /// Change password of seed phrase.
  Future<void> changeSeedPassword({
    required String oldPassword,
    required String newPassword,
  }) =>
      GetIt.instance<SeedKeyRepository>().changeSeedPassword(
        publicKey: masterKey.publicKey,
        oldPassword: oldPassword,
        newPassword: newPassword,
        isLegacy: masterKey.isLegacy,
      );

  /// Return seeds phrase of this seed.
  /// Do not works for ledger key.
  Future<List<String>> exportKey(String password) =>
      GetIt.instance<SeedKeyRepository>().exportKey(
        masterKey: masterKey.publicKey,
        password: password,
        isLegacy: masterKey.isLegacy,
      );

  /// This method allows remove full seed and all related keys (master and sub)
  Future<void> removeSeed() {
    return GetIt.instance<SeedKeyRepository>().removeKeys(
      [masterKey.publicKey, ...subKeys.map((e) => e.publicKey)],
    );
  }
}
