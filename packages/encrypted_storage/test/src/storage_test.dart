// ignore_for_file: prefer_const_constructors, unnecessary_import

import 'package:encrypted_storage/src/storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

const String testDomainName0 = 'test domain name 0';
final Map<String, StorageValue> testKeyValuePairs0 = {
  for (var id in List<int>.generate(256, (index) => index))
    'key 0: $id': StorageValue('value: 0: $id', 'iv: 0: $id')
};

final Map<String, StorageValue> testKeyValuePairs0Update = {
  for (var id in List<int>.generate(256, (index) => index))
    'key 0: $id': StorageValue('value: 0: $id update', 'iv: 0: $id update')
};

final Map<String, StorageValue> testKeyValuePairs1 = {
  for (var id in List<int>.generate(128, (index) => index))
    'key 1: $id': StorageValue('value: 1: $id', 'iv: 1: $id')
};

final Map<String, StorageValue> testKeyValuePairs2 = {
  for (var id in List<int>.generate(2048, (index) => index))
    'key 2: $id': StorageValue('value: 2: $id', 'iv: 2: $id')
};

void main() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory, do not use isolate here
  databaseFactory = databaseFactoryFfiNoIsolate;

  group('Storage can be instantiated', () {
    test('can be instantiated', () {
      expect(Storage(), isNotNull);
    });
  });

  group('Storage db tests', () {
    setUp(() {
      Storage().reset();
    });
    test('init and check empty', () async {
      final storage = Storage();
      await storage.init();
      await storage.clearAll();
      expect(await storage.getDomain(), isEmpty);
      expect(await storage.getDomain(domain: testDomainName0), isEmpty);
    });

    test('signle pair set and check in default domain', () async {
      final storage = Storage();
      await storage.init();
      await storage.clearAll();
      expect(await storage.getDomain(), isEmpty);

      await storage.set('testKey', StorageValue('testValue', 'testIv'));
      expect(await storage.get('testKey'), StorageValue('testValue', 'testIv'));
    });

    test('signle pair set, update and check in default domain', () async {
      final storage = Storage();
      await storage.init();
      await storage.clearAll();
      expect(await storage.getDomain(), isEmpty);

      await storage.set(
        'testKey',
        StorageValue('testValue', 'testIv'),
      );
      await storage.set(
        'testKey',
        StorageValue('testValue updated', 'testIv updated'),
      );
      expect(
        await storage.get('testKey'),
        StorageValue('testValue updated', 'testIv updated'),
      );
      expect(await storage.getDomain(), hasLength(1));
    });

    test('signle pair set and delete in default domain', () async {
      final storage = Storage();
      await storage.init();
      await storage.clearAll();
      expect(await storage.getDomain(), isEmpty);

      await storage.set('testKey0', StorageValue('testValue0', 'testIv0'));
      await storage.set('testKey1', StorageValue('testValue1', 'testIv1'));
      await storage.set('testKey2', StorageValue('testValue2', 'testIv2'));
      expect(await storage.getDomain(), hasLength(3));

      await storage.delete('testKey1');
      expect(await storage.getDomain(), hasLength(2));
      expect(
        await storage.get('testKey0'),
        StorageValue('testValue0', 'testIv0'),
      );
      expect(await storage.get('testKey1'), isNull);
      expect(
        await storage.get('testKey2'),
        StorageValue('testValue2', 'testIv2'),
      );
    });

    test('signle pair set, NOT update and check in default domain', () async {
      final storage = Storage();
      await storage.init();
      await storage.clearAll();
      expect(await storage.getDomain(), isEmpty);

      await storage.set('testKey', StorageValue('testValue', 'testIv'));
      await storage.set(
        'testKey',
        StorageValue('testValue0 updated', 'testIv0updated'),
        overwrite: false,
      );
      expect(await storage.get('testKey'), StorageValue('testValue', 'testIv'));
      expect(await storage.getDomain(), hasLength(1));
    });

    test('signle check default value in default domain', () async {
      final storage = Storage();
      await storage.init();
      await storage.clearAll();
      expect(await storage.getDomain(), isEmpty);

      expect(await storage.get('testKey'), isNull);
      expect(
        await storage.get(
          'testKey',
          defaultValue: StorageValue('default value', 'default iv'),
        ),
        StorageValue('default value', 'default iv'),
      );
    });

    test('signle pair set and check in custom domain', () async {
      final storage = Storage();
      await storage.init();
      await storage.clearAll();
      expect(await storage.getDomain(), isEmpty);
      expect(await storage.getDomain(domain: testDomainName0), isEmpty);

      await storage.set(
        'testKey',
        StorageValue('testValue', 'testIv'),
        domain: testDomainName0,
      );
      expect(await storage.get('testKey'), isNull);
      expect(
        await storage.get('testKey', domain: testDomainName0),
        StorageValue('testValue', 'testIv'),
      );
    });

    test('signle check default value in custom domain', () async {
      final storage = Storage();
      await storage.init();
      await storage.clearAll();
      expect(await storage.getDomain(), isEmpty);
      expect(await storage.getDomain(domain: testDomainName0), isEmpty);

      expect(await storage.get('testKey', domain: testDomainName0), isNull);
      expect(
        await storage.get(
          'testKey',
          domain: testDomainName0,
          defaultValue: StorageValue('default value', 'default iv'),
        ),
        StorageValue('default value', 'default iv'),
      );
    });

    test('separated domain cleaning', () async {
      final storage = Storage();
      await storage.init();
      await storage.clearAll();
      expect(await storage.getDomain(), isEmpty);
      expect(await storage.getDomain(domain: testDomainName0), isEmpty);

      await storage.set(
        'testKey',
        StorageValue('testValue', 'testIv'),
      );
      await storage.set(
        'testKey',
        StorageValue('testValue', 'testIv'),
        domain: testDomainName0,
      );

      expect(await storage.getDomain(), hasLength(1));
      expect(await storage.getDomain(domain: testDomainName0), hasLength(1));

      await storage.clearDomain(testDomainName0);
      expect(await storage.getDomain(), hasLength(1));
      expect(await storage.getDomain(domain: testDomainName0), hasLength(0));

      await storage.clearDomain();
      expect(await storage.getDomain(), isEmpty);
      expect(await storage.getDomain(domain: testDomainName0), isEmpty);
    });

    test('multiple pairs set and check in default domain', () async {
      final storage = Storage();
      await storage.init();
      await storage.clearAll();
      expect(await storage.getDomain(), isEmpty);
      expect(await storage.getDomainKeys(), isEmpty);

      await storage.setDomain(testKeyValuePairs0);
      expect(
        await storage.getDomain(),
        hasLength(testKeyValuePairs0.length),
      );
      expect(
        await storage.getDomainKeys(),
        hasLength(testKeyValuePairs0.length),
      );
      expect(await storage.getDomain(), testKeyValuePairs0);
      expect(
        (await storage.getDomainKeys())..sort(),
        testKeyValuePairs0.keys.toList()..sort(),
      );
      for (final pair in testKeyValuePairs0.entries) {
        expect(await storage.get(pair.key), pair.value);
      }
    });

    test('multiple pairs set, update and check in default domain', () async {
      final storage = Storage();
      await storage.init();
      await storage.clearAll();
      expect(await storage.getDomain(), isEmpty);

      await storage.setDomain(testKeyValuePairs0);
      await storage.setDomain(testKeyValuePairs0Update);
      expect(await storage.getDomain(), hasLength(testKeyValuePairs0.length));
      expect(await storage.getDomain(), testKeyValuePairs0Update);
    });

    test('multiple pairs set, NOT update and check in default domain',
        () async {
      final storage = Storage();
      await storage.init();
      await storage.clearAll();
      expect(await storage.getDomain(), isEmpty);

      await storage.setDomain(testKeyValuePairs0);
      await storage.setDomain(testKeyValuePairs0Update, overwrite: false);
      expect(await storage.getDomain(), hasLength(testKeyValuePairs0.length));
      expect(await storage.getDomain(), testKeyValuePairs0);
    });

    test('multiple pairs set, update, append and check in default domain',
        () async {
      final storage = Storage();
      await storage.init();
      await storage.clearAll();
      expect(await storage.getDomain(), isEmpty);

      await storage.setDomain(testKeyValuePairs0);
      await storage.setDomain(testKeyValuePairs0Update);
      await storage.setDomain(testKeyValuePairs1);
      expect(
        await storage.getDomain(),
        hasLength(
          testKeyValuePairs0.length + testKeyValuePairs1.length,
        ),
      );
      expect(
        await storage.getDomain(),
        {
          ...testKeyValuePairs0Update,
          ...testKeyValuePairs1,
        },
      );
    });

    test('multiple pairs set, append and partially delete in default domain',
        () async {
      final storage = Storage();
      await storage.init();
      await storage.clearAll();
      expect(await storage.getDomain(), isEmpty);

      await storage.setDomain(testKeyValuePairs0);
      await storage.setDomain(testKeyValuePairs1);
      expect(
        await storage.getDomain(),
        hasLength(
          testKeyValuePairs0.length + testKeyValuePairs1.length,
        ),
      );
      await storage.deleteDomain(List.from(testKeyValuePairs0.keys));
      expect(
        await storage.getDomain(),
        hasLength(
          testKeyValuePairs1.length,
        ),
      );
      expect(
        await storage.getDomain(),
        {
          ...testKeyValuePairs1,
        },
      );
    });

    test('huge pair list delete test (query splitting) in default domain',
        () async {
      final storage = Storage();
      await storage.init();
      await storage.clearAll();
      expect(await storage.getDomain(), isEmpty);

      await storage.setDomain(testKeyValuePairs2);
      expect(
        await storage.getDomain(),
        hasLength(testKeyValuePairs2.length),
      );
      await storage.deleteDomain(List.from(testKeyValuePairs2.keys));
      expect(await storage.getDomain(), isEmpty);
    });
  });
}
