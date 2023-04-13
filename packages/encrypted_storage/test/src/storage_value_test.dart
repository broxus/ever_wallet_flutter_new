// ignore_for_file: prefer_const_constructors
import 'package:encrypted_storage/src/storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StorageValue', () {
    test('can be instantiated', () async {
      expect(StorageValue('', ''), isNotNull);
    });

    test('comparable test', () async {
      expect(StorageValue('', ''), equals(StorageValue('', '')));
      expect(StorageValue('a', 'b'), equals(StorageValue('a', 'b')));
      expect(StorageValue('a', 'b'), isNot(StorageValue('a', 'c')));
      expect(StorageValue('a', 'b'), isNot(StorageValue('c', 'b')));
    });
  });
}
