import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
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

  KeyAccount? get currentAccount =>
      _currentAccountsService.currentActiveAccount;

  List<KeyAccount> get accounts => _nekotonRepository.seedList.seeds
      .expand(
        (seed) => seed.allKeys.expand(
          (key) => key.accountList.allAccounts,
        ),
      )
      .where((account) => !account.isHidden)
      .toList();

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
