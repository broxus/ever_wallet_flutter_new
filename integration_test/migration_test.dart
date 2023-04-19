import 'dart:convert';

import 'package:app/app/service/migration_service.dart';
import 'package:app/data/models/account_interaction.dart';
import 'package:app/data/models/bookmark.dart';
import 'package:app/data/models/browser_tab.dart';
import 'package:app/data/models/currency.dart';
import 'package:app/data/models/network_type.dart';
import 'package:app/data/models/permissions.dart';
import 'package:app/data/models/search_history.dart';
import 'package:app/data/models/site_meta_data.dart';
import 'package:app/data/models/token_contract_asset.dart';
import 'package:app/data/models/wallet_contract_type.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const _metadata = SiteMetaData(
  url: 'https://octusbridge.io',
  description: 'OctusBridge',
);
final _search = SearchHistory(
  openTime: DateTime.fromMillisecondsSinceEpoch(1681819001248),
  url: 'https://octusbridge.io',
);
const _bookmark = Bookmark(id: 0, name: 'Bookmark', url: 'URL');
const _browserTab = BrowserTab(
  url: 'URL',
  image: 'IMAGE',
  title: 'TITLE',
  lastScrollPosition: 10,
);
const _everContractAsset = TokenContractAsset(
  name: 'Staked Ever',
  chainId: 1,
  symbol: 'stEVER',
  decimals: 9,
  address: '0:6d42d0bc4a6568120ea88bf642edb653d727cfbd35868c47877532de128e71f2',
  logoURI:
      'https://raw.githubusercontent.com/broxus/ton-assets/master/icons/stEVER/logo.svg',
  version: 5,
  networkType: NetworkType.ever,
);
const _venomContractAsset = TokenContractAsset(
  name: 'Tether USD',
  chainId: 1,
  symbol: 'USDT',
  decimals: 6,
  address: '0:20470e6a6e33aa696263b5702608d69e3317c23bf20c2f921b38d6588c555603',
  logoURI:
      'https://raw.githubusercontent.com/BVFDT/venom-assets/master/icons/USDT/logo.svg',
  version: 5,
  networkType: NetworkType.venom,
);
const _everCurrency = Currency(
  address: 'everAddress',
  currency: 'EVER',
  fee24h: '',
  price: '',
  priceChange: '',
  transactionsCount24h: 0,
  tvl: '',
  tvlChange: '',
  volume7d: '',
  volume24h: '',
  volumeChange24h: '',
  networkType: NetworkType.ever,
);
const _venomCurrency = Currency(
  address: 'venomAddress',
  currency: 'VENOM',
  fee24h: '',
  price: '',
  priceChange: '',
  transactionsCount24h: 0,
  tvl: '',
  tvlChange: '',
  volume7d: '',
  volume24h: '',
  volumeChange24h: '',
  networkType: NetworkType.venom,
);
const _permissions = Permissions(
  accountInteraction: AccountInteraction(
    address: _address,
    publicKey: _publicKey,
    contractType: WalletContractType.everWallet,
  ),
  basic: true,
);

const _publicKey =
    'bb9c2578a1b9d0c7a6c947c419afe61c691052ff459df65e3eb4375faf3b25c6';
const _address =
    '0:18678befa040e2d66322fcb995d81cd5981ef7aaee494bd3e6a92554c455d0c5';
const _password = 'password';

/// Put fake data inside hive storage
Future<void> _initializeHive(HiveSourceMigration migration) async {
  await migration.setCurrentKey(_publicKey);
  await migration.updateLastViewedSeeds([_publicKey]);
  await migration.toggleHiddenAccount(_address);
  await migration.setKeyPassword(publicKey: _publicKey, password: _password);
  await migration.addExternalAccount(publicKey: _publicKey, address: _address);
  await migration.setCurrentConnection('connection');
  await migration.setStorageData(
    key: '__core__accounts',
    value:
        // ignore: lines_longer_than_80_chars, unnecessary_string_escapes
        '{"assets":{"0:18678befa040e2d66322fcb995d81cd5981ef7aaee494bd3e6a92554c455d0c5":"{\"name\":\"EVER Wallet\",\"ton_wallet\":{\"address\":\"0:18678befa040e2d66322fcb995d81cd5981ef7aaee494bd3e6a92554c455d0c5\",\"public_key\":\"bb9c2578a1b9d0c7a6c947c419afe61c691052ff459df65e3eb4375faf3b25c6\",\"contract\":\"EverWallet\"},\"additional_assets\":{}}","0:91b689ad990660249eb00140577e6a98d70043ccaa7f63acfc0436336bdbd80f":"{\"name\":\"multic\",\"ton_wallet\":{\"address\":\"0:91b689ad990660249eb00140577e6a98d70043ccaa7f63acfc0436336bdbd80f\",\"public_key\":\"162ded41d97cf526082012ce1e4c4f3bc03ab678d86e8983a8104e513658396a\",\"contract\":{\"Multisig\":\"Multisig2_1\"}},\"additional_assets\":{}}"}}',
  );
  await migration.setStorageData(
    key: '__core__keystore',
    value:
        // ignore: lines_longer_than_80_chars, unnecessary_string_escapes
        '[["LedgerKeySigner","[]"],["DerivedKeySigner","{\"master_keys\":{\"42a4ed9aefcf547c47ea9f4288cd5dd9457e4b68ccfa4dddecf22d4a18cb7e41\":{\"public_key\":\"42a4ed9aefcf547c47ea9f4288cd5dd9457e4b68ccfa4dddecf22d4a18cb7e41\",\"salt\":\"4a81bc1a024f07ba4bba7767c94e2739f211ef018bf8ee31b497298520a8c69a\",\"enc_entropy\":\"2cc5644f793ac83cade296a597b6f8a413d560853ac3db7650fe0981c52452555dfee5feb7f8bfc156fae5ced34e508587f97c97d50e39adf691b02361124f10627308875db297eddcfe48fc3999b1b1\",\"entropy_nonce\":\"8d00fc917a87c5e27e5434e2\",\"enc_phrase\":\"10624805d0f8f29edc50b529e299ac71567203652df00080da895bc6aad0c35b9be857cd4780829440155d22bd56d45f29b4be155ae8e4c05b3c89d8ba8b64ab6ff3ea12dda24d2013f5231e82e14758db14d1711692726ba4fd2289bf44\",\"phrase_nonce\":\"cd629775c64e5651a96e9211\",\"accounts_map\":{}},\"bb9c2578a1b9d0c7a6c947c419afe61c691052ff459df65e3eb4375faf3b25c6\":{\"public_key\":\"bb9c2578a1b9d0c7a6c947c419afe61c691052ff459df65e3eb4375faf3b25c6\",\"salt\":\"b99d1933629c8fee54c9ee9cebb54ca4b1ba45e8a2226721af51b001502d31c9\",\"enc_entropy\":\"cd089cd9b21b98e67bb3c276af5d28d8f601c7bb40a086f8aa192b2f94883147d00be6b73f57689759088c9fefedb08012ea7e82be8f8ae35e7ee53da23f560998f0ce8f637c569eadb3000cf865f2eb\",\"entropy_nonce\":\"d858b9d324a2030c38406e22\",\"enc_phrase\":\"4a298798f566ae8f4142980f84fcc0d800afbba3e577c09febef595940d0b2fb52c3445c58c5e483fa4641b2bafa89296899b95c74b72c54b153351d7b0d1b9f9703808924fbe4f004673e6d00528a46cbf06a7275f1b62dc4a423d8\",\"phrase_nonce\":\"03f2a0f866ca5d98b34865e3\",\"accounts_map\":{\"bb9c2578a1b9d0c7a6c947c419afe61c691052ff459df65e3eb4375faf3b25c6\":{\"name\":\"MultiSeed\",\"account_id\":0}}}}}"],["EncryptedKeySigner","[]"]]',
  );
  await migration.updateEverSystemTokenContractAssets([_everContractAsset]);
  await migration.updateVenomSystemTokenContractAssets([_venomContractAsset]);
  await migration.addEverCustomTokenContractAsset(_everContractAsset);
  await migration.addVenomCustomTokenContractAsset(_venomContractAsset);
  await migration.setLocale('ru_RU');
  await migration.setIsBiometryEnabled(isEnabled: true);
  await migration.setPermissions(origin: 'origin', permissions: _permissions);
  await migration.addBookmark(_bookmark);
  await migration.addSearchHistoryEntry(_search);
  await migration.cacheSiteMetaData(url: 'URL', metaData: _metadata);
  await migration.saveEverCurrency(
    address: 'everAddress',
    currency: _everCurrency,
  );
  await migration.saveVenomCurrency(
    address: 'venomAddress',
    currency: _venomCurrency,
  );
  await migration.saveWhyNeedBrowser();
  await migration.saveWasStEverOpened();
  await migration.saveBrowserTabs([_browserTab]);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late NekotonRepository repository;
  late HiveSourceMigration migration;
  late EncryptedStorage encryptedStorage;

  setUp(() async {
    encryptedStorage = EncryptedStorage();
    await encryptedStorage.init();
    await encryptedStorage.reset();
    repository = NekotonRepository();
    migration = await HiveSourceMigration.create(migrateFileAtStart: false);
    final file = await migration.migrationFile;
    if (file.existsSync()) {
      file.deleteSync();
    }
    await repository.setupLogger(level: Level.ALL, mobileLogger: true);
    runApp(Container());
  });

  group('Testing of storage migration', () {
    testWidgets(
      'Verify migration file creates correctly',
      (tester) async {
        await _initializeHive(migration);
        await migration.saveStorageData();
        final migrationFile = await migration.migrationFile;
        expect(migrationFile.existsSync(), isTrue);
        expect(
          migration.jsonData,
          jsonDecode(await migrationFile.readAsString()),
        );
      },
    );

    testWidgets('Migrate storage', (tester) async {
      await _initializeHive(migration);
    });
  });
}
