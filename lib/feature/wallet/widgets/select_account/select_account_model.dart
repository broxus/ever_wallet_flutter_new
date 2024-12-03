import 'package:app/app/service/service.dart';
import 'package:app/feature/wallet/widgets/select_account/select_account_data.dart';
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

  Stream<List<SelectAccountData>> get seedWithAccounts =>
      _nekotonRepository.seedListStream.map(
        (seedList) {
          return seedList.seeds.map((seed) {
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

  Stream<KeyAccount?> get currentAccount =>
      _currentAccountsService.currentActiveAccountStream;

  String get symbol => currentTransport.nativeTokenTicker;

  TransportStrategy get currentTransport => _nekotonRepository.currentTransport;

  void changeCurrentAccount(KeyAccount account) {
    _currentAccountsService.updateCurrentActiveAccount(account.address);
    _currentKeyService.changeCurrentKey(account.publicKey);
  }

  Future<Money?> getBalance(KeyAccount account) async {
    try {
      final wallet = _nekotonRepository.walletsMap[account.address]?.wallet ??
          await _getWallet(account);

      if (wallet == null) return null;

      return Money.fromBigIntWithCurrency(
        wallet.contractState.balance,
        Currencies()[currentTransport.nativeTokenTicker]!,
      );
    } catch (_) {
      return null;
    }
  }

  Future<TonWallet?> _getWallet(KeyAccount account) async {
    if (currentTransport.transport.disposed) return null;

    TonWallet? wallet;
    try {
      wallet = await TonWallet.subscribe(
        transport: currentTransport.transport,
        workchainId: account.workchain,
        publicKey: account.publicKey,
        walletType: account.account.tonWallet.contract,
      );
    } catch (_) {
    } finally {
      wallet?.dispose();
    }
    return wallet;
  }
}
