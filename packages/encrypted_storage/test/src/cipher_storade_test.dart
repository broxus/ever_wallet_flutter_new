// ignore_for_file: prefer_const_constructors
import 'package:encrypted_storage/src/cipher_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CipherStorage', () {
    test('can be instantiated', () {
      expect(CipherStorage(), isNotNull);
    });

    test('first start test', () async {
      FlutterSecureStorage.setMockInitialValues({});
      final cipherStorage = CipherStorage();
      await cipherStorage.init();
      expect(cipherStorage.key.bytes, hasLength(64));
      expect(cipherStorage.iv.bytes, hasLength(32));
    });

    test('stored creds test', () async {
      FlutterSecureStorage.setMockInitialValues(
        {
          'key': 'a2V5IHRlc3Q=',
          'iv': 'aXYgdGVzdA==',
        },
      );
      final cipherStorage = CipherStorage();
      await cipherStorage.init();
      expect(cipherStorage.key.base64, 'a2V5IHRlc3Q=');
      expect(cipherStorage.iv.base64, 'aXYgdGVzdA==');
    });

    test('storage persistence test', () async {
      FlutterSecureStorage.setMockInitialValues({});

      final cipherStorage0 = CipherStorage();
      await cipherStorage0.init();
      expect(cipherStorage0.key.bytes, hasLength(64));
      expect(cipherStorage0.iv.bytes, hasLength(32));

      final cipherStorage1 = CipherStorage();
      await cipherStorage1.init();
      expect(cipherStorage1.key.bytes, hasLength(64));
      expect(cipherStorage1.iv.bytes, hasLength(32));

      expect(cipherStorage1.key.bytes, cipherStorage0.key.bytes);
      expect(cipherStorage1.iv.bytes, cipherStorage0.iv.bytes);
    });
  });
}
