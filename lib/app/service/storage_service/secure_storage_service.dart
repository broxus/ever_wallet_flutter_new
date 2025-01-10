import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Currency;

const _passwordsKey = 'passwords_key';
const _connectionJsonDomain = 'connection_json_domain';

const _connectionJsonKey = 'connection_json_key';
const _connectionJsonHashKey = 'connection_json_hash_key';

/// This is a wrapper-class above [EncryptedStorage] that provides methods
/// to interact with general information that is not related to some specified
/// module.
@singleton
class SecureStorageService extends AbstractStorageService {
  SecureStorageService(this._storage);

  /// Storage that is used to store data
  final EncryptedStorage _storage;

  @override
  Future<void> init() => Future.value();

  /// Get password of public key if it was cached with biometry
  Future<String?> getKeyPassword(PublicKey publicKey) => _storage.get(
        publicKey.publicKey,
        domain: _passwordsKey,
      );

  /// Set password of public key to cache it with biometry
  Future<void> setKeyPassword({
    required PublicKey publicKey,
    required String password,
  }) =>
      _storage.set(
        publicKey.publicKey,
        password,
        domain: _passwordsKey,
      );

  /// Remove password of public key from cache
  Future<void> removeKeyPassword(PublicKey publicKey) =>
      _storage.delete(publicKey.publicKey, domain: _passwordsKey);

  /// Clear all passwords of public keys from cache
  Future<void> clearKeyPasswords() => _storage.clearDomain(_passwordsKey);

  Future<String?> getConnectionJson() {
    return _storage.get(
      _connectionJsonKey,
      domain: _connectionJsonDomain,
    );
  }

  Future<void> setConnectionJson(String json) => _storage.set(
        _connectionJsonKey,
        json,
        domain: _connectionJsonDomain,
      );

  Future<String?> getConnectionJsonHash() {
    return _storage.get(
      _connectionJsonHashKey,
      domain: _connectionJsonDomain,
    );
  }

  Future<void> setConnectionJsonHash(String hash) => _storage.set(
        _connectionJsonHashKey,
        hash,
        domain: _connectionJsonDomain,
      );

  @override
  Future<void> clear({
    bool isSaveConnectionJson = true,
  }) async {
    String? hash;
    String? json;

    if (isSaveConnectionJson) {
      hash = await getConnectionJsonHash();
      json = await getConnectionJson();
    }

    await _storage.clearAll();

    if (hash != null) {
      await setConnectionJsonHash(hash);
    }

    if (json != null) {
      await setConnectionJson(json);
    }
  }
}
