import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/data/wallet_prepare_balance_data.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/data/wallet_prepare_transfer_asset.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/wallet_prepare_transfer_page.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

typedef NativeUpdateCallback = void Function(
  Address root,
  String symbol,
  BigInt balance,
);
typedef TokenUpdateCallback = void Function(
  Address root,
  String symbol,
  Money money,
);

typedef TokenContractsUpdateCallback = void Function(
  List<TokenContractAsset> contracts,
);

/// [ElementaryModel] for [WalletPrepareTransferPage]
class WalletPrepareTransferPageModel extends ElementaryModel {
  WalletPrepareTransferPageModel(
    ErrorHandler errorHandler,
    this.address,
    this.rootTokenContract,
    this.tokenSymbol,
    this._assetsService,
    this._nekotonRepository,
    this._messengerService,
    this._currenciesService,
  ) : super(errorHandler: errorHandler);

  /// Address of account that will be used to send funds (owner for TokenWallet,
  /// or address for TonWallet)
  final Address address;
  final Address? rootTokenContract;
  final String? tokenSymbol;
  final AssetsService _assetsService;
  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
  final CurrenciesService _currenciesService;

  final _balanceDataSc = StreamController<WalletPrepareBalanceData>();

  /// Subscription for list of wallets (Ton/Token)
  StreamSubscription<dynamic>? _walletsSubscription;

  /// Subscription for selected asset (Ton/Token)
  StreamSubscription<dynamic>? _currentWalletSubscription;

  StreamSubscription<dynamic>? _contractSubscription;

  Stream<WalletPrepareBalanceData> get balanceDataStream =>
      _balanceDataSc.stream;

  TransportStrategy get currentTransport => _nekotonRepository.currentTransport;

  Stream<List<TonWalletState>> get _walletsStream =>
      _nekotonRepository.walletsStream;

  Stream<List<TokenWalletState>> get _tokenWalletsStream =>
      _nekotonRepository.tokenWalletsStream;

  final _logger = Logger('WalletPrepareTransferCubit');

  @override
  void dispose() {
    _closeBalanceSubs();
    _contractSubscription?.cancel();
    _balanceDataSc.close();
    super.dispose();
  }

  KeyAccount? findAccountByAddress(Address address) {
    return _nekotonRepository.seedList.findAccountByAddress(address);
  }

  Future<List<PublicKey>?> getLocalCustodiansAsync(Address address) async {
    try {
      return await _nekotonRepository.getLocalCustodiansAsync(address);
    } on Object catch (e, t) {
      _logger.severe('getLocalCustodiansAsync', e, t);
    }

    return null;
  }

  String getWalletName(KeyAccount account) {
    return _nekotonRepository.currentTransport
        .defaultAccountName(account.account.tonWallet.contract)
        .toLowerCase();
  }

  String? getSeedName(PublicKey custodian) {
    return _nekotonRepository.seedList.findSeedKey(custodian)?.name;
  }

  Future<TokenContractAsset?> getTokenContractAsset(Address root) async {
    if (rootTokenContract == null) {
      return null;
    }
    return _assetsService.getTokenContractAsset(
      rootTokenContract!,
      currentTransport,
    );
  }

  void showError(String text) {
    _messengerService.show(
      Message.error(message: text),
    );
  }

  void startListeningBalance(WalletPrepareTransferAsset? contract) {
    _closeBalanceSubs();
    if (contract == null) {
      return;
    }

    if (contract.isNative) {
      _subscribeNativeBalance(contract);
    } else {
      _subscribeTokenBalance(contract);
    }
  }

  void findExistedContracts(TokenContractsUpdateCallback onUpdate) {
    _contractSubscription =
        _assetsService.contractsForAccount(address).listen((contracts) {
      onUpdate(contracts);

      _contractSubscription?.cancel();
    });
  }

  Future<CustomCurrency?> getCurrencyForContract(
    Address rootTokenContract,
  ) async {
    final currency = _currenciesService
        .currencies(currentTransport.networkType)
        .firstWhereOrNull((currency) => currency.address == rootTokenContract);

    return currency ??
        await _currenciesService.getCurrencyForContract(
          currentTransport,
          rootTokenContract,
        );
  }

  /// Subscription for native token to find balance
  void _subscribeNativeBalance(WalletPrepareTransferAsset contract) {
    final root = contract.rootTokenContract;
    _walletsSubscription = _walletsStream.listen(
      (wallets) {
        final walletState =
            wallets.firstWhereOrNull((w) => w.address == address);

        if (walletState == null) {
          return;
        }

        if (walletState.hasError) {
          final error = walletState.error;
          if (error is Exception) {
            _balanceDataSc.add(WalletPrepareErrorBalanceData(error));
          }

          return;
        }

        final wallet = walletState.wallet;

        if (wallet == null) {
          return;
        }

        _walletsSubscription?.cancel();
        final symbol = currentTransport.nativeTokenTicker;

        _currentWalletSubscription = wallet.fieldUpdatesStream.listen((_) {
          _balanceDataSc.add(
            WalletPrepareNativeBalanceData(
              root: root,
              symbol: symbol,
              balance: wallet.contractState.balance,
            ),
          );
        });
      },
    );
  }

  /// Subscription for token wallet to find balance
  void _subscribeTokenBalance(WalletPrepareTransferAsset contract) {
    final root = contract.rootTokenContract;
    final symbol = contract.tokenSymbol;
    _walletsSubscription = _tokenWalletsStream.listen((wallets) {
      final walletState = wallets.firstWhereOrNull(
        (w) => w.owner == address && w.rootTokenContract == root,
      );

      if (walletState == null) {
        return;
      }

      if (walletState.hasError) {
        final error = walletState.error;
        if (error is Exception) {
          _balanceDataSc.add(WalletPrepareErrorBalanceData(error));
        }

        return;
      }

      final wallet = walletState.wallet;

      if (wallet != null) {
        _walletsSubscription?.cancel();
        _currentWalletSubscription = wallet.fieldUpdatesStream.listen((_) {
          _balanceDataSc.add(
            WalletPrepareTokenBalanceData(
              root: root,
              symbol: symbol,
              money: wallet.moneyBalance,
            ),
          );
        });
      }
    });
  }

  void _closeBalanceSubs() {
    _walletsSubscription?.cancel();
    _currentWalletSubscription?.cancel();
  }
}
