import 'package:encrypted_storage/src/abstract_storage.dart';
import 'package:encrypted_storage/src/cipher_storage.dart';
import 'package:encrypted_storage/src/encrypt_helper.dart';
import 'package:encrypted_storage/src/storage.dart';

/// {@template encrypted_storage}
/// Encrypted storage
/// {@endtemplate}
class EncryptedStorage implements AbstractStorage {
  /// {@macro encrypted_storage}
  EncryptedStorage()
      : _storage = Storage(),
        _cipherStorage = CipherStorage();

  final CipherStorage _cipherStorage;
  late EncryptHelper _encryptHelper;
  final Storage _storage;

  /// Init encrypted storage
  Future<void> init([String dbName = 'encrypted_storage.db']) async {
    await Future.wait([
      _cipherStorage.init(),
      _storage.init(dbName),
    ]);
    _encryptHelper = EncryptHelper(_cipherStorage);
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
    final a = await _storage.get(
      _encryptHelper.encrypt(key),
      defaultValue: _encryptHelper.encryptNullable(defaultValue),
      domain: domain,
    );
    return _encryptHelper.decryptNullable(a);
  }

  @override
  Future<Map<String, String>> getDomain({String domain = defaultDomain}) async {
    return (await _storage.getDomain(
      domain: domain,
    ))
        .map(
      (key, value) => MapEntry(
        _encryptHelper.decrypt(key),
        _encryptHelper.decrypt(value),
      ),
    );
  }

  @override
  Future<void> set(
    String key,
    String value, {
    String domain = defaultDomain,
    bool overwrite = true,
  }) {
    return _storage.set(
      _encryptHelper.encrypt(key),
      _encryptHelper.encrypt(value),
      domain: domain,
      overwrite: overwrite,
    );
  }

  @override
  Future<void> setDomain(
    Map<String, String> pairs, {
    String domain = defaultDomain,
    bool overwrite = true,
  }) {
    return _storage.setDomain(
      pairs.map(
        (key, value) => MapEntry(
          _encryptHelper.encrypt(key),
          _encryptHelper.encrypt(value),
        ),
      ),
      domain: domain,
      overwrite: overwrite,
    );
  }
}
