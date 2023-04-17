import 'package:app/app/service/migration_service.dart';
import 'package:app/data/models/account_interaction.dart';
import 'package:app/data/models/bookmark.dart';
import 'package:app/data/models/browser_tabs_dto.dart';
import 'package:app/data/models/currency.dart';
import 'package:app/data/models/permissions.dart';
import 'package:app/data/models/search_history_dto.dart';
import 'package:app/data/models/site_meta_data.dart';
import 'package:app/data/models/token_contract_asset.dart';
import 'package:app/data/models/wallet_contract_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const _metadata = SiteMetaData(url: 'URL', description: 'DESCRIPTION');
final _search = SearchHistoryDto(
  openTime: DateTime(2022, 10, 15, 5, 6, 10),
  url: 'URL',
);
const _bookmark = Bookmark(id: 0, name: 'Bookmark', url: 'URL');
const _browserTab = BrowserTab(
  url: 'URL',
  image: 'IMAGE',
  title: 'TITLE',
  lastScrollPosition: 10,
);
const _everContractAsset = TokenContractAsset(
  name: 'name',
  address: _address,
  decimals: 9,
  symbol: 'EVER',
  version: 1,
);
const _venomContractAsset = TokenContractAsset(
  name: 'name',
  address: _address,
  decimals: 9,
  symbol: 'VENOM',
  version: 1,
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
);
const _permissions = Permissions(
  accountInteraction: AccountInteraction(
    address: _address,
    publicKey: _publicKey,
    contractType: WalletContractType.everWallet,
  ),
  basic: true,
);

const _publicKey = '';
const _address = '';
const _password = 'password';

/// Put fake data inside hive storage
Future<void> _initializeHive(HiveSourceMigration migration) async {
  await migration.setCurrentKey(_publicKey);
  await migration.updateLastViewedSeeds([_publicKey]);
  await migration.toggleHiddenAccount(_address);
  await migration.setKeyPassword(publicKey: _publicKey, password: _password);
  await migration.addExternalAccount(publicKey: _publicKey, address: _address);
  await migration.setCurrentConnection('connection');
  // await migration.setStorageData(key: key, value: value);
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

  setUp(() async {
    repository = NekotonRepository();
    migration = await HiveSourceMigration.create();
    await repository.setupLogger(level: Level.ALL, mobileLogger: true);
    runApp(Container());
  });

  group('Testing of storage migration', () {
    testWidgets('Migrate storage if data exists', (tester) async {
      await _initializeHive(migration);
    });

    testWidgets('Migrate if no old storage', (tester) async {
      ;
    });
  });
}
