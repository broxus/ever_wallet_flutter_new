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
  String encrypt(String input, [String? iv]) {
    return _encrypter
        .encrypt(
          input,
          iv: iv != null ? CipherStorage.ivFromBase64(iv) : _cipherStorage.iv,
        )
        .base64;
  }

  /// Decrypt base64-encoded String [String], return original String
  String decrypt(String input, [String? iv]) {
    return _encrypter.decrypt64(
      input,
      iv: iv != null ? CipherStorage.ivFromBase64(iv) : _cipherStorage.iv,
    );
  }

  /// Encrypt [String], return base64-encoded String
  String? encryptNullable(String? input, [String? iv]) {
    return input != null ? encrypt(input, iv) : null;
  }

  /// Decrypt base64-encoded String [String], return original String
  String? decryptNullable(String? input, [String? iv]) {
    return input != null ? decrypt(input, iv) : null;
  }
}
