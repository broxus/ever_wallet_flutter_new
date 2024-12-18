import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/account_interaction.dart';
import 'package:app/data/models/browser_bookmark_item.dart';
import 'package:app/data/models/browser_history_item.dart';
import 'package:app/data/models/browser_tab.dart';
import 'package:app/data/models/custom_currency.dart';
import 'package:app/data/models/network_type.dart';
import 'package:app/data/models/permissions.dart';
import 'package:app/data/models/site_meta_data.dart';
import 'package:app/data/models/token_contract_asset.dart';
import 'package:app/data/models/wallet_contract_type.dart';
import 'package:collection/collection.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const _metadata = SiteMetaData(
  url: 'https://octusbridge.io',
  description: 'OctusBridge',
);
final _historyItem = BrowserHistoryItem(
  visitTime: DateTime.fromMillisecondsSinceEpoch(1681819001248),
  url: Uri.parse('https://octusbridge.io'),
  title: '',
  id: '0',
);
final _bookmark = BrowserBookmarkItem(
  id: '0',
  title: 'TITLE',
  url: Uri.parse('URL'),
  sortingOrder: -1,
);
final _browserTab = BrowserTab(
  url: Uri.parse('URL'),
  imageId: null,
  title: 'TITLE',
  sortingOrder: -1,
  id: '0',
);
const _everContractAssetCustom = TokenContractAsset(
  name: 'Staked Ever',
  chainId: 1,
  symbol: 'stEVER',
  decimals: 9,
  address: Address(
    address:
        '0:6d42d0bc4a6568120ea88bf642edb653d727cfbd35868c47877532de128e71f2',
  ),
  isCustom: true,
  logoURI:
      'https://raw.githubusercontent.com/broxus/ton-assets/master/icons/stEVER/logo.svg',
  version: TokenWalletVersion.tip3,
  networkType: NetworkType.ever,
);
const _everContractAssetSystem = TokenContractAsset(
  name: 'Staked Ever',
  chainId: 1,
  symbol: 'stEVER',
  decimals: 9,
  address: Address(
    address:
        '0:6d42d0bc4a6568120ea88bf642edb653d727cfbd35868c47877532de128e71f2',
  ),
  isCustom: false,
  logoURI:
      'https://raw.githubusercontent.com/broxus/ton-assets/master/icons/stEVER/logo.svg',
  version: TokenWalletVersion.tip3,
  networkType: NetworkType.ever,
);
const _venomContractAssetCustom = TokenContractAsset(
  name: 'Tether USD',
  chainId: 1,
  symbol: 'USDT',
  decimals: 6,
  address: Address(
    address:
        '0:20470e6a6e33aa696263b5702608d69e3317c23bf20c2f921b38d6588c555603',
  ),
  isCustom: true,
  logoURI:
      'https://raw.githubusercontent.com/BVFDT/venom-assets/master/icons/USDT/logo.svg',
  version: TokenWalletVersion.tip3,
  networkType: NetworkType.venom,
);
const _venomContractAssetSystem = TokenContractAsset(
  name: 'Tether USD',
  chainId: 1,
  symbol: 'USDT',
  decimals: 6,
  address: Address(
    address:
        '0:20470e6a6e33aa696263b5702608d69e3317c23bf20c2f921b38d6588c555603',
  ),
  isCustom: false,
  logoURI:
      'https://raw.githubusercontent.com/BVFDT/venom-assets/master/icons/USDT/logo.svg',
  version: TokenWalletVersion.tip3,
  networkType: NetworkType.venom,
);
const _everCurrency = CustomCurrency(
  address: Address(address: '42:everAddress'),
  currency: 'EVER',
  price: '',
  networkType: NetworkType.ever,
);
const _venomCurrency = CustomCurrency(
  address: Address(address: '69:venomAddress'),
  currency: 'VENOM',
  price: '',
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

const _publicKey = PublicKey(
  publicKey: 'bb9c2578a1b9d0c7a6c947c419afe61c691052ff459df65e3eb4375faf3b25c6',
);
const _address = Address(
  address: '0:18678befa040e2d66322fcb995d81cd5981ef7aaee494bd3e6a92554c455d0c5',
);
const _password = 'password';
const _connection = 'Everscale';
const _locale = 'ru_RU';

const _accountsStorageData =
// ignore: lines_longer_than_80_chars, unnecessary_string_escapes
    '{"assets":{"0:18678befa040e2d66322fcb995d81cd5981ef7aaee494bd3e6a92554c455d0c5":"{\"name\":\"EVER Wallet\",\"ton_wallet\":{\"address\":\"0:18678befa040e2d66322fcb995d81cd5981ef7aaee494bd3e6a92554c455d0c5\",\"public_key\":\"bb9c2578a1b9d0c7a6c947c419afe61c691052ff459df65e3eb4375faf3b25c6\",\"contract\":\"EverWallet\"},\"additional_assets\":{}}","0:91b689ad990660249eb00140577e6a98d70043ccaa7f63acfc0436336bdbd80f":"{\"name\":\"multic\",\"ton_wallet\":{\"address\":\"0:91b689ad990660249eb00140577e6a98d70043ccaa7f63acfc0436336bdbd80f\",\"public_key\":\"162ded41d97cf526082012ce1e4c4f3bc03ab678d86e8983a8104e513658396a\",\"contract\":{\"Multisig\":\"Multisig2_1\"}},\"additional_assets\":{}}"}}';

const _keystoreStorageData =
// ignore: lines_longer_than_80_chars, unnecessary_string_escapes
    '[["LedgerKeySigner","[]"],["DerivedKeySigner","{\"master_keys\":{\"42a4ed9aefcf547c47ea9f4288cd5dd9457e4b68ccfa4dddecf22d4a18cb7e41\":{\"public_key\":\"42a4ed9aefcf547c47ea9f4288cd5dd9457e4b68ccfa4dddecf22d4a18cb7e41\",\"salt\":\"4a81bc1a024f07ba4bba7767c94e2739f211ef018bf8ee31b497298520a8c69a\",\"enc_entropy\":\"2cc5644f793ac83cade296a597b6f8a413d560853ac3db7650fe0981c52452555dfee5feb7f8bfc156fae5ced34e508587f97c97d50e39adf691b02361124f10627308875db297eddcfe48fc3999b1b1\",\"entropy_nonce\":\"8d00fc917a87c5e27e5434e2\",\"enc_phrase\":\"10624805d0f8f29edc50b529e299ac71567203652df00080da895bc6aad0c35b9be857cd4780829440155d22bd56d45f29b4be155ae8e4c05b3c89d8ba8b64ab6ff3ea12dda24d2013f5231e82e14758db14d1711692726ba4fd2289bf44\",\"phrase_nonce\":\"cd629775c64e5651a96e9211\",\"accounts_map\":{}},\"bb9c2578a1b9d0c7a6c947c419afe61c691052ff459df65e3eb4375faf3b25c6\":{\"public_key\":\"bb9c2578a1b9d0c7a6c947c419afe61c691052ff459df65e3eb4375faf3b25c6\",\"salt\":\"b99d1933629c8fee54c9ee9cebb54ca4b1ba45e8a2226721af51b001502d31c9\",\"enc_entropy\":\"cd089cd9b21b98e67bb3c276af5d28d8f601c7bb40a086f8aa192b2f94883147d00be6b73f57689759088c9fefedb08012ea7e82be8f8ae35e7ee53da23f560998f0ce8f637c569eadb3000cf865f2eb\",\"entropy_nonce\":\"d858b9d324a2030c38406e22\",\"enc_phrase\":\"4a298798f566ae8f4142980f84fcc0d800afbba3e577c09febef595940d0b2fb52c3445c58c5e483fa4641b2bafa89296899b95c74b72c54b153351d7b0d1b9f9703808924fbe4f004673e6d00528a46cbf06a7275f1b62dc4a423d8\",\"phrase_nonce\":\"03f2a0f866ca5d98b34865e3\",\"accounts_map\":{\"bb9c2578a1b9d0c7a6c947c419afe61c691052ff459df65e3eb4375faf3b25c6\":{\"name\":\"MultiSeed\",\"account_id\":0}}}}}"],["EncryptedKeySigner","[]"]]';

/// Put fake data inside hive storage
Future<void> _fillHive(HiveSourceMigration migration) async {
  await migration.setCurrentKey(_publicKey.publicKey);
  await migration.addSeedOrRename(
    masterKey: _publicKey.publicKey,
    name: 'name',
  );
  await migration.updateLastViewedSeeds([_publicKey.publicKey]);
  await migration.addHiddenAccount(_address);
  await migration.setKeyPassword(publicKey: _publicKey, password: _password);
  await migration.addExternalAccount(publicKey: _publicKey, address: _address);
  await migration.setCurrentConnection(_connection);
  await migration.setStorageData(
    key: '__core__accounts',
    value: _accountsStorageData,
  );
  await migration.setStorageData(
    key: '__core__keystore',
    value: _keystoreStorageData,
  );
  await migration
      .updateEverSystemTokenContractAssets([_everContractAssetSystem]);
  await migration
      .updateVenomSystemTokenContractAssets([_venomContractAssetSystem]);
  await migration.addEverCustomTokenContractAsset(_everContractAssetCustom);
  await migration.addVenomCustomTokenContractAsset(_venomContractAssetCustom);
  await migration.setLocale(_locale);
  await migration.setIsBiometryEnabled(isEnabled: true);
  await migration.setPermissions(origin: 'origin', permissions: _permissions);
  await migration.addBookmark(_bookmark);
  await migration.addSearchHistoryEntry(_historyItem);
  await migration.cacheSiteMetaData(url: _metadata.url, metaData: _metadata);
  await migration.saveEverCurrency(
    address: const Address(
      address: '42:everAddress',
    ),
    currency: _everCurrency,
  );
  await migration.saveVenomCurrency(
    address: const Address(
      address: '69:venomAddress',
    ),
    currency: _venomCurrency,
  );
  await migration.saveWhyNeedBrowser();
  await migration.saveWasStEverOpened();
  await migration.saveBrowserTabs([_browserTab]);
}

Future<GetStorage> _getStorage(String container) async {
  final storage = GetStorage(container);
  await storage.initStorage;
  await storage.erase();
  return storage;
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late NekotonRepository repository;
  late HiveSourceMigration hive;
  late EncryptedStorage encryptedStorage;
  late GeneralStorageService storage;
  late SecureStorageService secureStorage;
  late BrowserTabsStorageService browserTabsStorage;
  late BrowserHistoryStorageService browserHistoryStorage;
  late BrowserBookmarksStorageService browserBookmarksStorage;
  late BrowserPermissionsStorageService browserPermissionsStorage;
  late NekotonStorageService accountSeedStorage;
  late ConnectionsStorageService connectionsStorage;

  Future<void> checkMigration() async {
    /// Nekoton storage
    expect(
      await accountSeedStorage.getStorageData(keystoreStorageKey),
      _keystoreStorageData,
    );
    expect(
      await accountSeedStorage.getStorageData(accountsStorageKey),
      _accountsStorageData,
    );

    /// Seeds
    expect(
      (await accountSeedStorage.readSeedMeta())
          .map((key, value) => MapEntry(key, value.name)),
      {_publicKey: 'name'},
    );
    expect(
      accountSeedStorage.seedMeta
          .map((key, value) => MapEntry(key, value.name)),
      {_publicKey: 'name'},
    );

    /// Passwords
    expect(await secureStorage.getKeyPassword(_publicKey), _password);

    /// System contracts
    expect(
      storage.readSystemTokenContractAssets(NetworkType.ever),
      [_everContractAssetSystem],
    );
    expect(
      storage.getSystemTokenContractAssets(NetworkType.ever),
      [_everContractAssetSystem],
    );

    expect(
      storage.readSystemTokenContractAssets(NetworkType.venom),
      [_venomContractAssetSystem],
    );
    expect(
      storage.getSystemTokenContractAssets(NetworkType.venom),
      [_venomContractAssetSystem],
    );

    /// Custom contracts
    expect(
      storage.readCustomTokenContractAssets(NetworkType.ever),
      [_everContractAssetCustom],
    );
    expect(
      storage.getCustomTokenContractAssets(NetworkType.ever),
      [_everContractAssetCustom],
    );

    expect(
      storage.readCustomTokenContractAssets(NetworkType.venom),
      [_venomContractAssetCustom],
    );
    expect(
      storage.getCustomTokenContractAssets(NetworkType.venom),
      [_venomContractAssetCustom],
    );

    /// Currencies
    expect(storage.readCurrencies(NetworkType.ever), [_everCurrency]);
    expect(storage.getCurrencies(NetworkType.ever), [_everCurrency]);

    expect(storage.readCurrencies(NetworkType.venom), [_venomCurrency]);
    expect(storage.getCurrencies(NetworkType.venom), [_venomCurrency]);

    /// Permissions
    expect(
      browserPermissionsStorage.readPermissions(),
      {'origin': _permissions},
    );

    /// Bookmarks
    expect(browserBookmarksStorage.readBrowserBookmarks(), [_bookmark]);
    expect(browserBookmarksStorage.browserBookmarks, [_bookmark]);

    /// Browser history, we need to change id because it's generated on fly
    expect(
      browserHistoryStorage.readBrowserHistory().map(
            (item) => item.copyWith(id: '0'),
          ),
      [_historyItem],
    );
    expect(
      browserHistoryStorage.browserHistory.map(
        (item) => item.copyWith(id: '0'),
      ),
      [_historyItem],
    );

    /// Preferences
    expect(storage.readIsBiometryEnabled(), true);
    expect(storage.getWasStEverOpened, true);
    expect(storage.readLastViewedSeeds(), [_publicKey]);
    expect(storage.lastViewedSeeds, [_publicKey]);
    expect(await accountSeedStorage.readHiddenAccounts(), [_address]);
    expect(accountSeedStorage.hiddenAccounts, [_address]);
    expect(
      await accountSeedStorage.readExternalAccounts(),
      {
        _publicKey: [_address],
      },
    );
    expect(
      accountSeedStorage.externalAccounts,
      {
        _publicKey: [_address],
      },
    );
    expect(storage.readCurrentKey(), _publicKey);
    expect(storage.currentKey, _publicKey);

    /// Browser
    expect(browserTabsStorage.readBrowserTabs(), [_browserTab]);
    expect(browserTabsStorage.browserTabs, [_browserTab]);
    expect(browserTabsStorage.readBrowserActiveTabId(), null);
  }

  setUp(() async {
    encryptedStorage = EncryptedStorage();
    FlutterSecureStorage.setMockInitialValues({});
    await encryptedStorage.init();
    await encryptedStorage.clearAll();
    storage = GeneralStorageService(
      await _getStorage(GeneralStorageService.prefContainer),
      await _getStorage(GeneralStorageService.currenciesContainer),
      await _getStorage(GeneralStorageService.systemContractAssetsContainer),
      await _getStorage(GeneralStorageService.customContractAssetsContainer),
    );
    secureStorage = SecureStorageService(encryptedStorage);
    browserTabsStorage = BrowserTabsStorageService(
      await _getStorage(BrowserTabsStorageService.container),
    );
    browserHistoryStorage = BrowserHistoryStorageService(
      await _getStorage(BrowserHistoryStorageService.container),
    );
    browserBookmarksStorage = BrowserBookmarksStorageService(
      await _getStorage(BrowserBookmarksStorageService.container),
    );
    browserPermissionsStorage = BrowserPermissionsStorageService(
      await _getStorage(BrowserPermissionsStorageService.container),
    );
    accountSeedStorage = NekotonStorageService(encryptedStorage);
    connectionsStorage = ConnectionsStorageService(
      await _getStorage(ConnectionsStorageService.container),
    );
    repository = NekotonRepository();
    await Hive.deleteFromDisk();
    hive = await HiveSourceMigration.create();
    final file = await hive.migrationFile;
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
        await tester.pumpAndSettle();

        await _fillHive(hive);
        final migrationFile = await hive.migrationFile;
        expect(migrationFile.existsSync(), isFalse);

        await hive.saveStorageData();
        expect(migrationFile.existsSync(), isTrue);
        expect(
          hive.jsonData,
          jsonDecode(await migrationFile.readAsString()),
        );
      },
    );

    testWidgets('Migrate storage needMigration', (tester) async {
      await tester.pumpAndSettle();

      await _fillHive(hive);
      final migration = MigrationService(
        storage,
        secureStorage,
        browserTabsStorage,
        browserHistoryStorage,
        browserBookmarksStorage,
        browserPermissionsStorage,
        accountSeedStorage,
        connectionsStorage,
        hive,
      );
      expect(storage.isStorageMigrated, isFalse);
      expect(await migration.needMigration(), isTrue);
    });

    testWidgets('Migrate storage no need migration 1', (tester) async {
      await tester.pumpAndSettle();

      final migration = MigrationService(
        storage,
        secureStorage,
        browserTabsStorage,
        browserHistoryStorage,
        browserBookmarksStorage,
        browserPermissionsStorage,
        accountSeedStorage,
        connectionsStorage,
        hive,
      );
      expect(storage.isStorageMigrated, isFalse);
      expect(await migration.needMigration(), isFalse);
    });

    testWidgets('Migrate storage no need migration 2', (tester) async {
      await tester.pumpAndSettle();

      final migration = MigrationService(
        storage,
        secureStorage,
        browserTabsStorage,
        browserHistoryStorage,
        browserBookmarksStorage,
        browserPermissionsStorage,
        accountSeedStorage,
        connectionsStorage,
        hive,
      );
      storage.completeStorageMigration();
      expect(storage.isStorageMigrated, isTrue);
      expect(await migration.needMigration(), isFalse);
    });

    testWidgets('Migrate storage verify migrationFile exists', (tester) async {
      await tester.pumpAndSettle();

      final migration = MigrationService(
        storage,
        secureStorage,
        browserTabsStorage,
        browserHistoryStorage,
        browserBookmarksStorage,
        browserPermissionsStorage,
        accountSeedStorage,
        connectionsStorage,
        hive,
      );
      final migrationFile = await hive.migrationFile;
      expect(migrationFile.existsSync(), isFalse);

      await migration.verifyMigrationFileExists();
      expect(migrationFile.existsSync(), isTrue);
    });

    testWidgets('Migrate storage apply migration', (tester) async {
      await tester.pumpAndSettle();

      await _fillHive(hive);
      final migration = MigrationService(
        storage,
        secureStorage,
        browserTabsStorage,
        browserHistoryStorage,
        browserBookmarksStorage,
        browserPermissionsStorage,
        accountSeedStorage,
        connectionsStorage,
        hive,
      );
      await migration.applyMigration();

      /// Nekoton storage
      expect(
        await accountSeedStorage.getStorageData(keystoreStorageKey),
        await hive.getStorageData(keystoreStorageKey),
      );
      expect(
        await accountSeedStorage.getStorageData(accountsStorageKey),
        await hive.getStorageData(accountsStorageKey),
      );

      /// Seeds
      expect(
        (await accountSeedStorage.readSeedMeta())
            .map((key, value) => MapEntry(key.publicKey, value.name)),
        hive.seeds,
      );
      expect(
        accountSeedStorage.seedMeta
            .map((key, value) => MapEntry(key.publicKey, value.name)),
        hive.seeds,
      );

      /// Passwords
      expect(
        await secureStorage.getKeyPassword(_publicKey),
        hive.getKeyPassword(_publicKey),
      );

      /// System contracts
      expect(
        storage.readSystemTokenContractAssets(NetworkType.ever),
        hive.everSystemTokenContractAssets,
      );
      expect(
        storage.getSystemTokenContractAssets(NetworkType.ever),
        hive.everSystemTokenContractAssets,
      );

      expect(
        storage.readSystemTokenContractAssets(NetworkType.venom),
        hive.venomSystemTokenContractAssets,
      );
      expect(
        storage.getSystemTokenContractAssets(NetworkType.venom),
        hive.venomSystemTokenContractAssets,
      );

      /// Custom contracts
      expect(
        storage.readCustomTokenContractAssets(NetworkType.ever),
        hive.everCustomTokenContractAssets,
      );
      expect(
        storage.getCustomTokenContractAssets(NetworkType.ever),
        hive.everCustomTokenContractAssets,
      );

      expect(
        storage.readCustomTokenContractAssets(NetworkType.venom),
        hive.venomCustomTokenContractAssets,
      );
      expect(
        storage.getCustomTokenContractAssets(NetworkType.venom),
        hive.venomCustomTokenContractAssets,
      );

      /// Currencies
      expect(
        storage.readCurrencies(NetworkType.ever),
        hive.everCurrencies,
      );
      expect(
        storage.getCurrencies(NetworkType.ever),
        hive.everCurrencies,
      );

      expect(
        storage.readCurrencies(NetworkType.venom),
        hive.venomCurrencies,
      );
      expect(
        storage.getCurrencies(NetworkType.venom),
        hive.venomCurrencies,
      );

      /// Permissions
      expect(
        browserPermissionsStorage.readPermissions(),
        hive.permissions,
      );

      /// Bookmarks
      expect(
        browserBookmarksStorage.readBrowserBookmarks(),
        hive.bookmarks,
      );
      expect(browserBookmarksStorage.browserBookmarks, hive.bookmarks);

      /// Search history
      expect(
        browserHistoryStorage.readBrowserHistory(),
        hive.searchHistory,
      );
      expect(
        browserHistoryStorage.browserHistory,
        hive.searchHistory,
      );

      /// Preferences
      expect(storage.readIsBiometryEnabled(), hive.isBiometryEnabled);
      expect(storage.getWasStEverOpened, hive.wasStEverOpened);
      expect(
        storage.readLastViewedSeeds().map((key) => key.publicKey),
        hive.lastViewedSeeds(),
      );
      expect(
        storage.lastViewedSeeds.map((key) => key.publicKey),
        hive.lastViewedSeeds(),
      );
      expect(
        (await accountSeedStorage.readHiddenAccounts())
            .map((addr) => addr.address),
        hive.hiddenAccounts,
      );
      expect(
        accountSeedStorage.hiddenAccounts.map((addr) => addr.address),
        hive.hiddenAccounts,
      );
      expect(
        (await accountSeedStorage.readExternalAccounts()).map(
          (key, value) => MapEntry(
            key.publicKey,
            value.map((addr) => addr.address),
          ),
        ),
        hive.externalAccounts,
      );
      expect(
        accountSeedStorage.externalAccounts.map(
          (key, value) =>
              MapEntry(key.publicKey, value.map((addr) => addr.address)),
        ),
        hive.externalAccounts,
      );
      final connections = connectionsStorage.readConnections();
      final currentConnectionId = connectionsStorage.readCurrentConnectionId();
      final currentConnection = connections.firstWhereOrNull(
        (connection) => connection.id == currentConnectionId,
      );
      expect(currentConnection!.name, hive.currentConnection);
      expect(storage.readCurrentKey()?.publicKey, hive.currentKey);
      expect(storage.currentKey?.publicKey, hive.currentKey);

      /// Browser
      expect(browserTabsStorage.readBrowserTabs(), hive.browserTabs);
      expect(browserTabsStorage.browserTabs, hive.browserTabs);
      expect(
        browserTabsStorage.readBrowserActiveTabId(),
        null,
      );
      expect(hive.checkIfSensitiveBoxesOpened(), isTrue);
    });

    testWidgets('Migrate storage full migration', (tester) async {
      await tester.pumpAndSettle();

      await _fillHive(hive);

      expect(storage.isStorageMigrated, isFalse);

      final migration = MigrationService(
        storage,
        secureStorage,
        browserTabsStorage,
        browserHistoryStorage,
        browserBookmarksStorage,
        browserPermissionsStorage,
        accountSeedStorage,
        connectionsStorage,
        hive,
      );
      await migration.migrate();

      final migrationFile = await hive.migrationFile;
      expect(migrationFile.existsSync(), isFalse);
      expect(hive.checkIfSensitiveBoxesOpened(), isFalse);
      expect(storage.isStorageMigrated, isTrue);

      await checkMigration();
    });

    testWidgets('Migrate storage without init hive', (tester) async {
      await tester.pumpAndSettle();

      await _fillHive(hive);
      await hive.dispose();

      expect(storage.isStorageMigrated, isFalse);

      await MigrationService.migrateWithHiveInit(
        storage,
        secureStorage,
        browserTabsStorage,
        browserHistoryStorage,
        browserBookmarksStorage,
        browserPermissionsStorage,
        accountSeedStorage,
        connectionsStorage,
      );

      final migrationFile = await hive.migrationFile;
      expect(migrationFile.existsSync(), isFalse);
      expect(hive.checkIfSensitiveBoxesOpened(), isFalse);
      expect(storage.isStorageMigrated, isTrue);

      await checkMigration();
    });
  });
}
