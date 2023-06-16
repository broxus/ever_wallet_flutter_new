import 'package:flutter_test/flutter_test.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class AllWalletTypeSupports extends Fake implements TransportStrategy {
  @override
  List<WalletType> get availableWalletTypes => const [
        WalletType.everWallet(),
        WalletType.walletV3(),
        WalletType.multisig(MultisigType.multisig2_1),
      ];
}

class OnlyV3WalletTypeSupports extends Fake implements TransportStrategy {
  @override
  List<WalletType> get availableWalletTypes => const [WalletType.walletV3()];
}

void main() {
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

  final account1Pure = KeyAccount(
    account: AssetsList(
      name: 'Account1',
      additionalAssets: {},
      tonWallet: TonWalletAsset(
        publicKey: masterKey.publicKey,
        address: '0:address1',
        contract: const WalletType.everWallet(),
      ),
    ),
    publicKey: masterKey.publicKey,
    isExternal: false,
    isHidden: false,
  );
  final account1ExternalHidden = KeyAccount(
    account: const AssetsList(
      name: 'Account1Ex',
      additionalAssets: {},
      tonWallet: TonWalletAsset(
        publicKey: 'RandomExernalKey',
        address: '0:address1ex',
        contract: WalletType.everWallet(),
      ),
    ),
    publicKey: masterKey.publicKey,
    isExternal: true,
    isHidden: true,
  );

  final accountSub1Pure = KeyAccount(
    account: AssetsList(
      name: 'AccountSub1',
      additionalAssets: {},
      tonWallet: TonWalletAsset(
        publicKey: subKey1.publicKey,
        address: '0:addressSub1',
        contract: const WalletType.everWallet(),
      ),
    ),
    publicKey: subKey1.publicKey,
    isExternal: false,
    isHidden: false,
  );

  final accountSub2Hidden = KeyAccount(
    account: AssetsList(
      name: 'AccountSub2',
      additionalAssets: {},
      tonWallet: TonWalletAsset(
        publicKey: subKey2.publicKey,
        address: '0:addressSub2',
        contract: const WalletType.walletV3(),
      ),
    ),
    publicKey: subKey2.publicKey,
    isExternal: false,
    isHidden: true,
  );

  final account2External = KeyAccount(
    account: const AssetsList(
      name: 'AccountSub2',
      additionalAssets: {},
      tonWallet: TonWalletAsset(
        publicKey: 'RandomExernalKey2',
        address: '0:addressSub2Ex',
        contract: WalletType.multisig(MultisigType.multisig2_1),
      ),
    ),
    publicKey: masterKey2.publicKey,
    isExternal: true,
    isHidden: false,
  );

  final accounts1 = AccountList(
    allAccounts: [account1Pure, account1ExternalHidden],
    publicKey: masterKey.publicKey,
  );
  final accounts2 = AccountList(
    allAccounts: [account2External],
    publicKey: masterKey2.publicKey,
  );
  final accountsSub1 = AccountList(
    allAccounts: [accountSub1Pure],
    publicKey: subKey1.publicKey,
  );
  final accountsSub2 = AccountList(
    allAccounts: [accountSub2Hidden],
    publicKey: subKey2.publicKey,
  );

  group('SeedList test', () {
    test('SeedList only keys creation', () {
      final seedsList = SeedList(
        allKeys: [masterKey, subKey1, subKey2, masterKey2],
        mappedAccounts: const {},
      );

      expect(seedsList.seeds.length, 2);
      final seed1 = seedsList.findSeed('key1')!;
      expect(
        seed1.masterKey,
        SeedKey(
          key: masterKey,
          accountList: AccountList.empty(masterKey.publicKey),
        ),
      );
      expect(
        seed1.subKeys,
        equals([
          SeedKey(
            key: subKey1,
            accountList: AccountList.empty(subKey1.publicKey),
          ),
          SeedKey(
            key: subKey2,
            accountList: AccountList.empty(subKey2.publicKey),
          ),
        ]),
      );
      final seed2 = seedsList.findSeed('key4')!;
      expect(
        seed2.masterKey,
        SeedKey(
          key: masterKey2,
          accountList: AccountList.empty(masterKey2.publicKey),
        ),
      );
      expect(seed2.subKeys, equals([]));
    });

    test('SeedsList creation keys with accounts', () {
      final seedsList = SeedList(
        allKeys: [masterKey, subKey1, subKey2, masterKey2],
        mappedAccounts: {
          masterKey.publicKey: accounts1,
          masterKey2.publicKey: accounts2,
          subKey1.publicKey: accountsSub1,
          subKey2.publicKey: accountsSub2,
        },
      );

      expect(seedsList.seeds.length, 2);
      final seed1 = seedsList.findSeed('key1')!;
      expect(
        seed1.masterKey,
        SeedKey(key: masterKey, accountList: accounts1),
      );
      expect(seed1.masterKey.accountList.allAccounts.length, 2);
      expect(
        seed1.masterKey.accountList.externalAccounts,
        [account1ExternalHidden],
      );
      expect(
        seed1.masterKey.accountList.displayAccounts,
        [account1Pure],
      );
      expect(
        seed1.masterKey.accountList.localAccounts,
        [account1Pure],
      );
      expect(
        seed1.subKeys,
        equals([
          SeedKey(key: subKey1, accountList: accountsSub1),
          SeedKey(key: subKey2, accountList: accountsSub2),
        ]),
      );
      final seed2 = seedsList.findSeed('key4')!;
      expect(
        seed2.masterKey,
        SeedKey(key: masterKey2, accountList: accounts2),
      );
      expect(seed2.subKeys, equals([]));
    });
  });

  group('NekotonRepository.buildSeeds', () {
    test('All accounts available by transport', () {
      final strategy = AllWalletTypeSupports();
      final seedsList = NekotonRepository().buildSeeds(
        allKeys: [masterKey, subKey1, subKey2, masterKey2],
        allAccounts: [
          account1Pure.account,
          account1ExternalHidden.account,
          accountSub1Pure.account,
          accountSub2Hidden.account,
          account2External.account,
        ],
        hiddenAccounts: [
          account1ExternalHidden.account.address,
          accountSub2Hidden.account.address,
        ],
        externalAccounts: {
          masterKey.publicKey: [account1ExternalHidden.account.address],
          masterKey2.publicKey: [account2External.account.address],
        },
        transport: strategy,
      );

      expect(seedsList.seeds.length, 2);
      final seed1 = seedsList.findSeed('key1')!;
      expect(
        seed1.masterKey,
        SeedKey(key: masterKey, accountList: accounts1),
      );
      expect(seed1.masterKey.accountList.allAccounts.length, 2);
      expect(
        seed1.masterKey.accountList.externalAccounts,
        [account1ExternalHidden],
      );
      expect(
        seed1.masterKey.accountList.displayAccounts,
        [account1Pure],
      );
      expect(
        seed1.masterKey.accountList.localAccounts,
        [account1Pure],
      );
      expect(
        seed1.subKeys,
        equals([
          SeedKey(key: subKey1, accountList: accountsSub1),
          SeedKey(key: subKey2, accountList: accountsSub2),
        ]),
      );
      final seed2 = seedsList.findSeed('key4')!;
      expect(
        seed2.masterKey,
        SeedKey(key: masterKey2, accountList: accounts2),
      );
      expect(seed2.subKeys, equals([]));
    });

    test('Only WalletType.v3 available by transport', () {
      final strategy = OnlyV3WalletTypeSupports();
      final seedsList = NekotonRepository().buildSeeds(
        allKeys: [masterKey, subKey1, subKey2, masterKey2],
        allAccounts: [
          account1Pure.account,
          account1ExternalHidden.account,
          accountSub1Pure.account,
          accountSub2Hidden.account,
          account2External.account,
        ],
        hiddenAccounts: [
          account1ExternalHidden.account.address,
          accountSub2Hidden.account.address,
        ],
        externalAccounts: {
          masterKey.publicKey: [account1ExternalHidden.account.address],
          masterKey2.publicKey: [account2External.account.address],
        },
        transport: strategy,
      );

      expect(seedsList.seeds.length, 2);
      final seed1 = seedsList.findSeed('key1')!;
      expect(
        seed1.masterKey,
        SeedKey(
          key: masterKey,
          accountList: AccountList.empty(masterKey.publicKey),
        ),
      );
      expect(seed1.masterKey.accountList.allAccounts.length, 0);
      expect(
        seed1.subKeys,
        equals([
          SeedKey(
            key: subKey1,
            accountList: AccountList.empty(subKey1.publicKey),
          ),
          SeedKey(key: subKey2, accountList: accountsSub2),
        ]),
      );
      final seed2 = seedsList.findSeed('key4')!;
      expect(
        seed2.masterKey,
        SeedKey(
          key: masterKey2,
          accountList: AccountList.empty(masterKey2.publicKey),
        ),
      );
      expect(seed2.subKeys, equals([]));
    });
  });
}
