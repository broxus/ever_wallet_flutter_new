import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/widgets/select_account/select_account_data.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class RequestPermissionsModel extends ElementaryModel {
  RequestPermissionsModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._permissionsService,
    this._currentAccountsService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final PermissionsService _permissionsService;
  final CurrentAccountsService _currentAccountsService;

  String get symbol => currentTransport.nativeTokenTicker;

  Stream<KeyAccount?> get currentAccount =>
      _currentAccountsService.currentActiveAccountStream;

  Stream<List<SelectAccountData>> get seedWithAccounts =>
      _nekotonRepository.seedListStream.map(
        (seedList) {
          final seeds = seedList.seeds
            ..sort((a, b) => a.name.compareTo(b.name));
          return seeds.map((seed) {
            final privateKeys = seed.allKeys.map((key) {
              final accounts = key.accountList.allAccounts
                  .where((account) => !account.isHidden)
                  .toList();
              return SeedWithInfo(
                keyName: key.name,
                key: key.publicKey.toEllipseString(),
                accounts: accounts,
              );
            }).toList();
            return SelectAccountData(
              name: seed.name,
              privateKeys: privateKeys,
            );
          }).toList();
        },
      );

  TransportStrategy get currentTransport => _nekotonRepository.currentTransport;

  void setPermissions(Uri origin, Permissions permissions) =>
      _permissionsService.setPermissions(url: origin, permissions: permissions);

  Future<Money?> getBalance(KeyAccount account) async {
    final wallet = _nekotonRepository.walletsMap[account.address]?.wallet ??
        await _getWallet(account);

    return Money.fromBigIntWithCurrency(
      wallet.contractState.balance,
      Currencies()[currentTransport.nativeTokenTicker]!,
    );
  }

  Future<TonWallet> _getWallet(KeyAccount account) async {
    TonWallet? wallet;
    try {
      wallet = await TonWallet.subscribe(
        transport: currentTransport.transport,
        workchainId: account.workchain,
        publicKey: account.publicKey,
        walletType: account.account.tonWallet.contract,
      );
    } finally {
      wallet?.dispose();
    }
    return wallet;
  }
}
