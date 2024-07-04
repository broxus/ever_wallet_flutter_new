import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/token_contract_asset.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/data/wallet_prepare_transfer_asset.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/wallet_prepare_transfer_page.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
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
    this._address,
    this._rootTokenContract,
    this._assetsService,
    this._balanceService,
    this._nekotonRepository,
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  /// Address of account that will be used to send funds (owner for TokenWallet,
  /// or address for TonWallet)
  final Address _address;
  final Address? _rootTokenContract;

  /// Subscription for list of wallets (Ton/Token)
  StreamSubscription<dynamic>? _walletsSubscription;

  /// Subscription for selected asset (Ton/Token)
  StreamSubscription<dynamic>? _currentWalletSubscription;

  StreamSubscription<dynamic>? _contractSubscription;

  TransportStrategy get currentTransport => _nekotonRepository.currentTransport;

  Stream<List<TonWalletState>> get _walletsStream =>
      _nekotonRepository.walletsStream;

  Stream<List<TokenWalletState>> get _tokenWalletsStream =>
      _nekotonRepository.tokenWalletsStream;

  final _logger = Logger('WalletPrepareTransferCubit');

  final AssetsService _assetsService;
  final BalanceService _balanceService;
  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;

  @override
  void dispose() {
    _closeBalanceSubs();
    _contractSubscription?.cancel();
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
    if (_rootTokenContract == null) {
      return null;
    }
    return _assetsService.getTokenContractAsset(
      _rootTokenContract!,
      currentTransport,
    );
  }

  void showError(String text) {
    _messengerService.show(
      Message.error(message: text),
    );
  }

  void startListeningBalance(
    WalletPrepareTransferAsset? contract,
    NativeUpdateCallback onNativeUpdate,
    TokenUpdateCallback onTokenUpdate,
    ValueChanged<Exception?> onError,
  ) {
    _closeBalanceSubs();
    if (contract == null) {
      return;
    }

    if (contract.isNative) {
      _subscribeNativeBalance(contract, onNativeUpdate, onError);
    } else {
      _subscribeTokenBalance(contract, onTokenUpdate, onError);
    }
  }

  void findExistedContracts(TokenContractsUpdateCallback onUpdate) {
    _contractSubscription =
        _assetsService.contractsForAccount(_address).listen((contracts) {
      onUpdate(contracts);

      _contractSubscription?.cancel();
    });
  }

  /// Subscription for native token to find balance
  void _subscribeNativeBalance(
    WalletPrepareTransferAsset contract,
    NativeUpdateCallback onNativeUpdate,
    ValueChanged<Exception?> onError,
  ) {
    final root = contract.rootTokenContract;
    _walletsSubscription = _walletsStream.listen(
      (wallets) {
        final walletState =
            wallets.firstWhereOrNull((w) => w.address == _address);

        if (walletState == null) {
          return;
        }

        if (walletState.hasError) {
          final error = walletState.error;
          if (error is Exception) {
            onError(error);
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
          onNativeUpdate(root, symbol, wallet.contractState.balance);
        });
      },
    );
  }

  /// Subscription for token wallet to find balance
  void _subscribeTokenBalance(
    WalletPrepareTransferAsset contract,
    TokenUpdateCallback onTokenUpdate,
    ValueChanged<Exception?> onError,
  ) {
    final root = contract.rootTokenContract;
    final symbol = contract.tokenSymbol;
    _walletsSubscription = _tokenWalletsStream.listen((wallets) {
      final walletState = wallets.firstWhereOrNull(
        (w) => w.owner == _address && w.rootTokenContract == root,
      );

      if (walletState == null) {
        return;
      }

      if (walletState.hasError) {
        final error = walletState.error;
        if (error is Exception) {
          onError(error);
        }

        return;
      }

      final wallet = walletState.wallet;

      if (wallet != null) {
        _walletsSubscription?.cancel();
        _currentWalletSubscription = wallet.fieldUpdatesStream.listen((_) {
          onTokenUpdate(root, symbol, wallet.moneyBalance);
        });
      }
    });
  }

  void _closeBalanceSubs() {
    _walletsSubscription?.cancel();
    _currentWalletSubscription?.cancel();
  }
}