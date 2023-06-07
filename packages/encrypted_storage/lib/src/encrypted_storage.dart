import 'package:encrypted_storage/src/abstract_storage.dart';
import 'package:encrypted_storage/src/cipher_storage.dart';
import 'package:encrypted_storage/src/encrypt_helper.dart';
import 'package:encrypted_storage/src/storage.dart';
import 'package:injectable/injectable.dart';

/// {@template encrypted_storage}
/// Encrypted storage
/// {@endtemplate}
@singleton
class EncryptedStorage implements AbstractStorage {
  /// {@macro encrypted_storage}
  EncryptedStorage()
      : _storage = Storage(),
        _cipherStorage = CipherStorage();

  final CipherStorage _cipherStorage;
  late EncryptHelper _encryptHelper;
  final Storage _storage;

  static const String _storageFileName = 'encrypted_storage.db';

  /// Init encrypted storage
  Future<void> init([String dbName = _storageFileName]) async {
    await Future.wait([
      _cipherStorage.init(),
      _storage.init(dbName),
    ]);
    _encryptHelper = EncryptHelper(_cipherStorage);
  }

  /// Reset storage
  /// @visibleForTesting
  Future<void> reset([String dbName = _storageFileName]) async {
    return _storage.reset(dbName);
  }

  @override
  Future<void> clearAll() async {
    return _storage.clearAll();
  }

  @override
  Future<void> clearDomain([String? domain = defaultDomain]) async {
    return _storage.clearDomain(domain);
  }

  @override
  Future<void> delete(String key, {String domain = defaultDomain}) async {
    return _storage.delete(_encryptHelper.encrypt(key), domain: domain);
  }

  @override
  Future<void> deleteDomain(
    List<String> keys, {
    String domain = defaultDomain,
  }) async {
    return _storage.deleteDomain(
      keys.map((key) => _encryptHelper.encrypt(key)).toList(),
      domain: domain,
    );
  }

  @override
  Future<String?> get(
    String key, {
    String? defaultValue,
    String domain = defaultDomain,
  }) async {
    final storageValue = await _storage.get(
      _encryptHelper.encrypt(key),
      defaultValue: defaultValue != null
          ? StorageValue(_encryptHelper.encrypt(defaultValue), '')
          : null,
      domain: domain,
    );

    return _encryptHelper.decryptNullable(
      storageValue?.value,
      storageValue?.iv,
    );
  }

  @override
  Future<Map<String, String>> getDomain({String domain = defaultDomain}) async {
    final pairs = await _storage.getDomain(
      domain: domain,
    );

    return pairs.map(
      (key, value) => MapEntry(
        _encryptHelper.decrypt(key),
        _encryptHelper.decrypt(value.value, value.iv),
      ),
    );
  }

  @override
  Future<List<String>> getDomainKeys({
    String domain = defaultDomain,
  }) async {
    final keys = await _storage.getDomainKeys(
      domain: domain,
    );

    return keys.map((key) => _encryptHelper.decrypt(key)).toList();
  }

  @override
  Future<void> set(
    String key,
    String value, {
    String domain = defaultDomain,
    bool overwrite = true,
  }) {
    final iv = CipherStorage.ivFromSecureRandom().base64;

    return _storage.set(
      _encryptHelper.encrypt(key),
      StorageValue(_encryptHelper.encrypt(value, iv), iv),
      domain: domain,
      overwrite: overwrite,
    );
  }

  @override
  Future<void> setDomain(
    Map<String, String> pairs, {
    String domain = defaultDomain,
    bool overwrite = true,
  }) =>
      _storage.setDomain(
        pairs.map((key, value) {
          final iv = CipherStorage.ivFromSecureRandom().base64;

          return MapEntry(
            _encryptHelper.encrypt(key),
            StorageValue(_encryptHelper.encrypt(value, iv), iv),
          );
        }),
        domain: domain,
        overwrite: overwrite,
      );
}
