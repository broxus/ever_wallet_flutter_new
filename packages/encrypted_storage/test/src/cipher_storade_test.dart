// ignore_for_file: prefer_const_constructors
import 'package:encrypted_storage/src/cipher_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

const String cipherStorageKey = 'B0oxgy0Ddb+NxhGIDgmoRjvhKjESZKPrMfHzqlP9xEk=';
const String cipherStorageIv = 'lOpf2c8QsEg7AoexDh7iOQ==';

void main() {
  group('CipherStorage', () {
    test('can be instantiated', () {
      expect(CipherStorage(), isNotNull);
    });

    test('first start test', () async {
      FlutterSecureStorage.setMockInitialValues({});
      final cipherStorage = CipherStorage();
      await cipherStorage.init();
      expect(cipherStorage.key.bytes, hasLength(32));
      expect(cipherStorage.iv.bytes, hasLength(16));
    });

    test('stored creds test', () async {
      FlutterSecureStorage.setMockInitialValues(
        {
          'cipher_storage_key': cipherStorageKey,
          'cipher_storage_iv': cipherStorageIv,
        },
      );
      final cipherStorage = CipherStorage();
      await cipherStorage.init();
      expect(cipherStorage.key.base64, cipherStorageKey);
      expect(cipherStorage.iv.base64, cipherStorageIv);
    });

    test('storage persistence test', () async {
      FlutterSecureStorage.setMockInitialValues({});

      final cipherStorage0 = CipherStorage();
      await cipherStorage0.init();
      expect(cipherStorage0.key.bytes, hasLength(32));
      expect(cipherStorage0.iv.bytes, hasLength(16));

      final cipherStorage1 = CipherStorage();
      await cipherStorage1.init();
      expect(cipherStorage1.key.bytes, hasLength(32));
      expect(cipherStorage1.iv.bytes, hasLength(16));

      expect(cipherStorage1.key.bytes, cipherStorage0.key.bytes);
      expect(cipherStorage1.iv.bytes, cipherStorage0.iv.bytes);
    });

    test('storage persistence test, lost key', () async {
      FlutterSecureStorage.setMockInitialValues(
        {
          'cipher_storage_iv': cipherStorageIv,
        },
      );

      final cipherStorage = CipherStorage();
      await expectLater(cipherStorage.init, throwsStateError);
    });

    test('storage persistence test, lost iv', () async {
      FlutterSecureStorage.setMockInitialValues(
        {
          'cipher_storage_key': cipherStorageKey,
        },
      );

      final cipherStorage = CipherStorage();
      await expectLater(cipherStorage.init, throwsStateError);
    });
  });
}
