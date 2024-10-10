import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class SelectAccountModel extends ElementaryModel {
  SelectAccountModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currentKeyService,
    this._currentAccountsService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final CurrentKeyService _currentKeyService;
  final CurrentAccountsService _currentAccountsService;

  Stream<List<KeyAccount>> get accounts =>
      _nekotonRepository.seedListStream.map(
        (seedList) => seedList.seeds
            .expand(
              (seed) => seed.allKeys.expand(
                (key) => key.accountList.allAccounts,
              ),
            )
            .where((account) => !account.isHidden)
            .toList(),
      );

  Stream<KeyAccount?> get currentAccount =>
      _currentAccountsService.currentActiveAccountStream;

  String get symbol => currentTransport.nativeTokenTicker;

  TransportStrategy get currentTransport => _nekotonRepository.currentTransport;

  Future<void> changeCurrentAccount(KeyAccount account) async {
    await _currentAccountsService.updateCurrentActiveAccount(account.address);
    await _currentKeyService.changeCurrentKey(account.publicKey);
  }

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
