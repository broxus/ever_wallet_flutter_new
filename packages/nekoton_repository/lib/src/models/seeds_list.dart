import 'package:flutter/foundation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// List of seeds that user added into application.
/// This list allows iterating over [seeds] and add/remove seeds.
///
/// This instance is immutable and it can't change its state.
/// To listen SeedList changes, use [NekotonRepository.seedsStream]
@immutable
class SeedsList {
  SeedsList({
    required SeedKeyRepository seedKeyRepository,
    required this.allKeys,
  })  : _seedKeyRepository = seedKeyRepository,
        _seedsMap = _mapKeysToSeeds(allKeys, seedKeyRepository);

  final SeedKeyRepository _seedKeyRepository;

  /// All cached seeds.
  /// This structure uses to simplify searching of seeds.
  /// Key - publicKey of masterKey.
  /// Value - Seed.
  final Map<String, Seed> _seedsMap;

  /// Get seed by masterKey if it's in list.
  Seed? getSeed(String masterKey) => _seedsMap[masterKey];

  /// List of seeds that user added into application.
  /// Every seed is a group of masterKey and its subKeys.
  List<Seed> get seeds => _seedsMap.values.toList();

  /// This is a plane list of all keys(master and sub) in application.
  /// This can be useful sometimes.
  final List<KeyStoreEntry> allKeys;

  /// Add new seed to application.
  /// Returns publicKey of masterKey of added seed.
  Future<String> addSeed({
    required List<String> phrase,
    required String password,
    String? name,
  }) =>
      _seedKeyRepository.addSeed(
        phrase: phrase,
        password: password,
        name: name,
      );

  /// Encrypt data for external usages.
  /// [publicKey] is key that must be used for signing.
  /// If there is no key for [publicKey], exception will be thrown.
  Future<List<EncryptedData>> encrypt({
    required String data,
    required List<String> publicKeys,
    required EncryptionAlgorithm algorithm,
    required String publicKey,
    required String password,
  }) {
    final key = allKeys.firstWhere((k) => k.publicKey == publicKey);
    return _seedKeyRepository.encrypt(
      data: data,
      algorithm: algorithm,
      publicKeys: publicKeys,
      signInput: key.signInput(password),
    );
  }

  /// Decrypt data from external usages.
  /// If there is no key for [publicKey], exception will be thrown.
  Future<String> decrypt({
    required EncryptedData data,
    required String publicKey,
    required String password,
  }) {
    final key = allKeys.firstWhere((k) => k.publicKey == publicKey);
    return _seedKeyRepository.decrypt(
      data: data,
      signInput: key.signInput(password),
    );
  }

  /// Sign [data] message with [publicKey]
  /// If there is no key for [publicKey], exception will be thrown.
  /// [signatureId] is [Transport.getSignatureId].
  Future<String> sign({
    required String data,
    required String publicKey,
    required String password,
    required int? signatureId,
  }) {
    final key = allKeys.firstWhere((k) => k.publicKey == publicKey);
    return _seedKeyRepository.sign(
      data: data,
      signatureId: signatureId,
      signInput: key.signInput(password),
    );
  }

  /// Sign [data] message with [publicKey]
  /// If there is no key for [publicKey], exception will be thrown.
  /// [signatureId] is [Transport.getSignatureId].
  Future<SignedData> signData({
    required String data,
    required String publicKey,
    required String password,
    required int? signatureId,
  }) {
    final key = allKeys.firstWhere((k) => k.publicKey == publicKey);
    return _seedKeyRepository.signData(
      data: data,
      signatureId: signatureId,
      signInput: key.signInput(password),
    );
  }

  /// Sign raw [data] message with [publicKey]
  /// If there is no key for [publicKey], exception will be thrown.
  /// [signatureId] is [Transport.getSignatureId].
  Future<SignedDataRaw> signRawData({
    required String data,
    required String publicKey,
    required String password,
    required int? signatureId,
  }) {
    final key = allKeys.firstWhere((k) => k.publicKey == publicKey);
    return _seedKeyRepository.signRawData(
      data: data,
      signatureId: signatureId,
      signInput: key.signInput(password),
    );
  }

  /// Check if password of [publicKey] equals to [password].
  /// [signatureId] is [Transport.getSignatureId].
  Future<bool> checkKeyPassword({
    required String publicKey,
    required String password,
    required int? signatureId,
  }) async {
    try {
      await sign(
        data: fakeSignature(),
        password: password,
        publicKey: publicKey,
        signatureId: signatureId,
      );

      return true;
    } catch (_) {
      return false;
    }
  }

  /// Return map grouped by masterKey.
  /// Key - publicKey of masterKey.
  /// Value - Seed related to masterKey.
  static Map<String, Seed> _mapKeysToSeeds(
    List<KeyStoreEntry> allKeys,
    SeedKeyRepository seedKeyRepository,
  ) {
    /// Key - publicKey of masterKey.
    /// Value - list of all keys that derives from this masterKey.
    /// MasterKey is always first in this list.
    final seeds = <String, List<KeyStoreEntry>>{};

    for (final key in allKeys) {
      if (seeds.containsKey(key.masterKey)) {
        if (key.isMaster) {
          seeds[key.masterKey]!.insert(0, key);
        } else {
          seeds[key.masterKey]!.add(key);
        }
      } else {
        seeds[key.masterKey] = [key];
      }
    }

    return seeds.map(
      (master, keys) => MapEntry(
        master,
        Seed(
          masterKey: keys.first,
          subKeys: keys.sublist(1),
          seedKeyRepository: seedKeyRepository,
        ),
      ),
    );
  }
}
