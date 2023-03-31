// ignore_for_file: prefer_const_constructors
import 'package:encrypted_storage/src/cipher_storage.dart';
import 'package:encrypted_storage/src/encrypt_helper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

import 'cipher_storade_test.dart';

final testString = String.fromCharCodes(
  List<int>.generate(
    1024,
    (i) => 1024 + i,
  ),
);

void main() {
  group('EncryptHelper', () {
    test('can be instantiated', () async {
      FlutterSecureStorage.setMockInitialValues({});
      final cipherStorage = CipherStorage();
      await cipherStorage.init();
      expect(EncryptHelper(cipherStorage), isNotNull);
    });

    test('encrypt and decrypt test, same instance', () async {
      FlutterSecureStorage.setMockInitialValues({});
      final cipherStorage = CipherStorage();
      await cipherStorage.init();
      final encryptHelper = EncryptHelper(cipherStorage);

      expect(
        encryptHelper.decrypt(encryptHelper.encrypt(testString)),
        testString,
      );
    });

    test('encrypt and decrypt test, different instances', () async {
      FlutterSecureStorage.setMockInitialValues({});
      final cipherStorage0 = CipherStorage();
      await cipherStorage0.init();
      final encryptHelper0 = EncryptHelper(cipherStorage0);

      final encrypted = encryptHelper0.encrypt(testString);

      final cipherStorage1 = CipherStorage();
      await cipherStorage1.init();
      final encryptHelper1 = EncryptHelper(cipherStorage1);

      expect(
        encryptHelper1.decrypt(encrypted),
        testString,
      );
    });

    test('encrypt and decrypt test, different instances, lost key and iv',
        () async {
      FlutterSecureStorage.setMockInitialValues({});
      final cipherStorage0 = CipherStorage();
      await cipherStorage0.init();
      final encryptHelper0 = EncryptHelper(cipherStorage0);

      final encrypted = encryptHelper0.encrypt(testString);

      FlutterSecureStorage.setMockInitialValues({});

      final cipherStorage1 = CipherStorage();
      await cipherStorage1.init();
      final encryptHelper1 = EncryptHelper(cipherStorage1);

      expect(() => encryptHelper1.decrypt(encrypted), throwsArgumentError);
    });

    test('encrypt and decrypt test, different instances, lost key', () async {
      FlutterSecureStorage.setMockInitialValues(
        {
          'cipher_storage_iv': cipherStorageIv,
        },
      );

      final cipherStorage1 = CipherStorage();
      await expectLater(cipherStorage1.init, throwsStateError);
    });
  });
}
