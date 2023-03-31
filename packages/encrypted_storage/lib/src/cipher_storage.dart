import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';

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

  final _log = Logger('CiperStorage');

  /// Init ciper storage
  Future<void> init() async {
    _storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

    final rows = await _storage.readAll();
    final key = rows[_keyKey];
    final iv = rows[_ivKey];

    if (key != null && iv != null) {
      _key = Key.fromBase64(key);
      _iv = IV.fromBase64(iv);
      return;
    }

    if ((key == null && iv != null) || (key != null && iv == null)) {
      throw StateError(
        'key and iv reading error: one of them is null while another is not',
      );
    }

    _key = Key.fromSecureRandom(32);
    _iv = IV.fromSecureRandom(16);

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
}
