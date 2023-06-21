import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Any seed of application, that contains [masterKey] and [subKeys].
/// [masterKey] is a main key that derives directly from seed phrase.
/// [subKeys] is a list of keys that derives from [masterKey].
///
/// This instance is immutable and it can't change its state.
/// To listen SeedList changes, use [NekotonRepository.seedListStream]
@immutable
class Seed extends Equatable {
  const Seed({
    required this.masterKey,
    required this.subKeys,
  });

  /// Master key of seed.
  /// This key is derived directly from seed phrase.
  final SeedKey masterKey;

  /// Proxy getter of name of master key
  String get name => masterKey.key.name;

  /// Proxy getter of public key of master key
  String get publicKey => masterKey.key.publicKey;

  /// List of derived keys of [masterKey].
  /// This list do not contains [masterKey].
  final List<SeedKey> subKeys;

  /// Just for iterating over all keys.
  List<SeedKey> get allKeys => [masterKey, ...subKeys];

  /// Get instance of SeedKey if [publicKey] is part of this seed.
  SeedKey? findKeyByPublicKey(String publicKey) =>
      allKeys.firstWhereOrNull((key) => key.publicKey == publicKey);

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
  Future<void> changePassword({
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
  Future<List<String>> export(String password) =>
      GetIt.instance<SeedKeyRepository>().exportKey(
        masterKey: masterKey.publicKey,
        password: password,
        isLegacy: masterKey.isLegacy,
      );

  /// This method allows remove full seed and all related keys (master and sub)
  Future<void> remove() =>
      GetIt.instance<SeedKeyRepository>().removeKeys(allKeys);

  @override
  List<Object?> get props => allKeys;
}
