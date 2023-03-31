import 'package:encrypt/encrypt.dart';
import 'package:encrypted_storage/src/cipher_storage.dart';

/// {@template encrypt_helper}
/// Encrtypt helper
/// {@endtemplate}
class EncryptHelper {
  /// {@macro encrypt_helper}
  EncryptHelper(this._cipherStorage)
      : _encrypter = Encrypter(
          AES(_cipherStorage.key),
        );
  final CipherStorage _cipherStorage;
  final Encrypter _encrypter;

  /// Encrypt [String], return base64-encoded String
  String encrypt(String input) {
    return _encrypter.encrypt(input, iv: _cipherStorage.iv).base64;
  }

  /// Decrypt base64-encoded String [String], return original String
  String decrypt(String input) {
    return _encrypter.decrypt64(input, iv: _cipherStorage.iv);
  }
}
