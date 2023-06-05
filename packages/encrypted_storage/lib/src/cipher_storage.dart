import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _keyLength = 32;
const _ivLength = 16;

/// {@template ciper_storage}
/// Ciper storage
/// {@endtemplate}
class CipherStorage {
  /// {@macro ciper_storage}
  CipherStorage();

  static const String _keyKey = 'cipher_storage_key';
  static const String _ivKey = 'cipher_storage_iv';
  late FlutterSecureStorage _storage;
  late final Key _key;
  late final IV _iv;

  /// Init ciper storage
  Future<void> init() async {
    _storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

    final rows = await _storage.readAll();
    final key = rows[_keyKey];
    final iv = rows[_ivKey];

    if (key != null && iv != null) {
      _key = keyFromBase64(key);
      _iv = ivFromBase64(iv);

      return;
    }

    if ((key == null && iv != null) || (key != null && iv == null)) {
      throw StateError(
        'key and iv reading error: one of them is null while another is not',
      );
    }

    _key = keyFromSecureRandom();
    _iv = ivFromSecureRandom();

    await _storage.write(key: _keyKey, value: _key.base64);
    await _storage.write(key: _ivKey, value: _iv.base64);
  }

  /// Get key
  Key get key => _key;

  /// Get initialization vector
  IV get iv => _iv;

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  /// Generate key from base64
  static Key keyFromBase64(String key) => Key.fromBase64(key);

  /// Generate initialization vector from base64
  static IV ivFromBase64(String iv) => IV.fromBase64(iv);

  /// Generate a new key
  static Key keyFromSecureRandom() => Key.fromSecureRandom(_keyLength);

  /// Generate a new initialization vector
  static IV ivFromSecureRandom() => IV.fromSecureRandom(_ivLength);
}
