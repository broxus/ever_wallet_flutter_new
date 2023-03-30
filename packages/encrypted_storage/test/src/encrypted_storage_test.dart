// ignore_for_file: prefer_const_constructors

import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EncryptedStorage', () {
    test('can be instantiated', () {
      expect(EncryptedStorage(), isNotNull);
    });
  });
}
