import 'package:nekoton_repository/nekoton_repository.dart';

/// Repository that can be used in data-classes related to Seeds/Keys.
/// This repository can be used as <SeedKeyRepositoryImpl> or you can add
/// custom logic.
abstract class SeedKeyRepository {
  /// Derive keys from [masterKey] which is key of seed.
  /// !!! This method won't work for legacy keys.
  /// This method returns list of public keys that allows add additional logic
  /// related to newly added keys.
  Future<List<String>> deriveKeys({
    required List<int> accountIds,
    required String password,
    required String masterKey,
  });

  /// Add new seed to application.
  /// Returns publicKey of masterKey of added seed.
  Future<String> addSeed({
    required List<String> phrase,
    required String password,
    String? name,
  });

  /// Change password of seed phrase.
  // TODO(alex-a4): verify accepting this action to master key, recursively
  //   change password of all sub keys.
  Future<void> changeSeedPassword({
    required String publicKey,
    required String oldPassword,
    required String newPassword,
    required bool isLegacy,
  });

  /// Rename key (sub or master) with [publicKey] to [name].
  Future<void> renameKey({
    required String publicKey,
    required String masterKey,
    required String name,
    required bool isLegacy,
  });

  /// Return seeds phrase of [masterKey].
  /// Do not works for ledger key.
  Future<List<String>> exportKey({
    required String masterKey,
    required String password,
    required bool isLegacy,
  });

  /// Encrypt data for external usages.
  /// [signInput] can be get from [KeyStoreExtension.signInput].
  Future<List<EncryptedData>> encrypt({
    required String data,
    required List<String> publicKeys,
    required EncryptionAlgorithm algorithm,
    required SignInput signInput,
  });

  /// Decrypt data from external usages.
  /// [signInput] can be get from [KeyStoreExtension.signInput].
  Future<String> decrypt({
    required EncryptedData data,
    required SignInput signInput,
  });

  /// Sign [data] message with key it was called on.
  /// [signatureId] is [Transport.getSignatureId].
  /// [signInput] can be get from [KeyStoreExtension.signInput].
  Future<String> sign({
    required String data,
    required SignInput signInput,
    required int? signatureId,
  });

  /// Sign [data] message with key it was called on.
  /// [signatureId] is [Transport.getSignatureId].
  /// [signInput] can be get from [KeyStoreExtension.signInput].
  Future<SignedData> signData({
    required String data,
    required SignInput signInput,
    required int? signatureId,
  });

  /// Sign raw [data] message with key it was called on.
  /// [signatureId] is [Transport.getSignatureId].
  /// [signInput] can be get from [KeyStoreExtension.signInput].
  Future<SignedDataRaw> signRawData({
    required String data,
    required SignInput signInput,
    required int? signatureId,
  });

  /// Remove keys from keystore and return public keys that were deleted
  Future<List<String>> removeKeys(List<String> publicKeys);
}
