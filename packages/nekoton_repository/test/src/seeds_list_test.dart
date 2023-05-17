import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class MockSeedKeyRepository extends Mock implements SeedKeyRepository {}

void main() {
  final mockedRepo = MockSeedKeyRepository();

  group('SeedsList test', () {
    test('SeedsList creation', () {
      final masterKey = KeyStoreEntry(
        name: 'MasterKey',
        masterKey: 'key1',
        accountId: 0,
        publicKey: 'key1',
        signerName: const KeySigner.derived().name,
      );
      final subKey1 = KeyStoreEntry(
        name: 'SubKey',
        masterKey: 'key1',
        accountId: 1,
        publicKey: 'key2',
        signerName: const KeySigner.derived().name,
      );
      final subKey2 = KeyStoreEntry(
        name: 'SubKey',
        masterKey: 'key1',
        accountId: 2,
        publicKey: 'key3',
        signerName: const KeySigner.derived().name,
      );

      final masterKey2 = KeyStoreEntry(
        name: 'MasterKey2',
        masterKey: 'key4',
        accountId: 10,
        publicKey: 'key4',
        signerName: const KeySigner.encrypted().name,
      );

      final seedsList = SeedsList(
        allKeys: [masterKey, subKey1, subKey2, masterKey2],
        seedKeyRepository: mockedRepo,
      );

      expect(seedsList.seeds.length, 2);
      final seed1 = seedsList.getSeed('key1')!;
      expect(seed1.masterKey, masterKey);
      expect(seed1.subKeys, equals([subKey1, subKey2]));
      final seed2 = seedsList.getSeed('key4')!;
      expect(seed2.masterKey, masterKey2);
      expect(seed2.subKeys, equals([]));
    });
  });
}
