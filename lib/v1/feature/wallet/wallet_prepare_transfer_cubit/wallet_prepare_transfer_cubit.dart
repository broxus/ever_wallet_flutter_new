import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:app/v1/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/data/wallet_prepare_transfer_asset.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

part 'wallet_prepare_transfer_cubit.freezed.dart';
part 'wallet_prepare_transfer_state.dart';

/// Cubit that allows prepare sending native token for TonWallet with [address].
///
/// If [rootTokenContract] is specified, then only this token will be available
/// for selection.
class WalletPrepareTransferCubit extends Cubit<WalletPrepareTransferState> {
  WalletPrepareTransferCubit({
    required this.address,
    required this.rootTokenContract,
    required this.tokenSymbol,
    required this.nekotonRepository,
    required this.balanceService,
    required this.assetsService,
  }) : super(const WalletPrepareTransferState.loading()) {
    final acc = nekotonRepository.seedList.findAccountByAddress(address);
    if (acc == null) {
      emit(const WalletPrepareTransferState.empty());

      return;
    }

    account = acc;
    _cachedLocalCustodians = [account.publicKey];
    _selectedCustodian = account.publicKey;

    // If default contract not specified, then native is default and load
    // all existed assets
    final root = rootTokenContract;
    if (root == null) {
      _createNativeContract();
      _findExistedContracts();
    } else {
      final transport = nekotonRepository.currentTransport;
      // if default contract is specified, then lock it
      if (root == transport.nativeTokenAddress &&
          tokenSymbol == transport.nativeTokenTicker) {
        _createNativeContract();
      } else {
        _findSpecifiedContract(root);
      }
    }

    // Get local custodians async because TonWallet can be missed if
    // <rootTokenContract> is not null
    // ignore: prefer-async-await
    nekotonRepository.getLocalCustodiansAsync(address).then((custodians) {
      if (custodians != null) _cachedLocalCustodians = custodians;

      _updateState();
    }).catchError((Object? e, StackTrace t) {
      _logger.severe('getLocalCustodiansAsync', e, t);
    });
  }

  final _logger = Logger('WalletPrepareTransferCubit');

  /// Contract of token (native or not) that will be locked to send funds
  final Address? rootTokenContract;

  /// Symbol of contract that should be locked
  final String? tokenSymbol;

  /// Address of account that will be used to send funds (owner for TokenWallet,
  /// or address for TonWallet)
  final Address address;

  final NekotonRepository nekotonRepository;
  final BalanceService balanceService;
  final AssetsService assetsService;

  late KeyAccount account;
  late List<PublicKey> _cachedLocalCustodians;
  late PublicKey _selectedCustodian;

  /// Last selected asset that will be used for sending funds.
  ///
  /// If [rootTokenContract] is null, then native token will be used by default.
  ///
  /// This field will be always not null for data state.
  late WalletPrepareTransferAsset selectedAsset;

  /// Map of all assets, that exists for current account
  /// Key - rootTokenContract + ticker
  final _assets = <(Address, String), WalletPrepareTransferAsset>{};

  @override
  Future<void> close() {
    _closeBalanceSubs();
    _contractSubscription?.cancel();

    return super.close();
  }

  void changeAsset(Address rootTokenContract, String tokenSymbol) {
    final asset = _assets[(rootTokenContract, tokenSymbol)];
    if (selectedAsset.rootTokenContract == rootTokenContract &&
            selectedAsset.tokenSymbol == tokenSymbol ||
        asset == null) {
      return;
    }

    selectedAsset = asset;
    _updateState();
    _startListeningBalance(rootTokenContract, tokenSymbol);
  }

  void changeCustodian(PublicKey custodian) {
    if (_selectedCustodian == custodian) return;

    _selectedCustodian = custodian;
    _updateState();
  }

  Future<void> nextAction({
    required String receiverAddress,
    required String amount,
    required String comment,
  }) async {
    final addr = Address(address: receiverAddress);
    if (!await validateAddress(addr)) {
      inject<MessengerService>()
          .show(Message.error(message: LocaleKeys.addressIsWrong.tr()));

      return;
    }

    final amnt = Fixed.parse(amount, scale: selectedAsset.balance.scale);

    // Temp fix
    // To work around the lack of state change
    // from Go to Data when there is no network
    _updateState();
    emit(
      WalletPrepareTransferState.goNext(
        walletName: _walletName(nekotonRepository, account),
        account: account,
        localCustodians: _cachedLocalCustodians,
        selectedCustodian: _selectedCustodian,
        assets: _assets.values.toList(),
        selectedAsset: selectedAsset,
        receiveAddress: addr,
        amount: amnt,
        comment: comment.isEmpty ? null : comment,
      ),
    );
    _updateState();
  }

  void _updateState() {
    if (isClosed) return;

    emit(
      WalletPrepareTransferState.data(
        walletName: _walletName(nekotonRepository, account),
        account: account,
        localCustodians: _cachedLocalCustodians,
        selectedCustodian: _selectedCustodian,
        assets: _assets.values.toList(),
        selectedAsset: selectedAsset,
      ),
    );
  }

  /// Subscription for founding list of contracts for [address].
  /// This subscriptions closes immediately after founding contracts.
  StreamSubscription<dynamic>? _contractSubscription;

  /// Find all existed contracts for account with [address] and add them
  /// to [_assets].
  /// If this method was called, then native token is available at time.
  void _findExistedContracts() {
    _contractSubscription =
        assetsService.contractsForAccount(address).listen((contracts) {
      _assets.addEntries(
        contracts.map(
          (e) => MapEntry(
            (e.address, e.symbol),
            WalletPrepareTransferAsset(
              rootTokenContract: e.address,
              isNative: false,
              balance: _zeroBalance(e.symbol),
              tokenSymbol: e.symbol,
              logoURI: e.logoURI,
              title: e.name,
              version: e.version,
            ),
          ),
        ),
      );
      _updateState();

      _contractSubscription?.cancel();
    });
  }

  /// Find contract for specified address and start listening it.
  /// Means, that if this method was called, then only one token available when
  /// [rootTokenContract] is not null.
  Future<void> _findSpecifiedContract(Address root) async {
    final contract = await assetsService.getTokenContractAsset(
      root,
      nekotonRepository.currentTransport,
    );

    if (contract == null) {
      emit(const WalletPrepareTransferState.empty());

      return;
    }

    selectedAsset = WalletPrepareTransferAsset(
      rootTokenContract: contract.address,
      isNative: false,
      balance: _zeroBalance(contract.symbol),
      logoURI: contract.logoURI,
      tokenSymbol: contract.symbol,
      title: contract.name,
      version: contract.version,
    );
    _assets[(root, contract.symbol)] = selectedAsset;
    _updateState();

    _startListeningBalance(root, contract.symbol);
  }

  /// Subscription for list of wallets (Ton/Token)
  StreamSubscription<dynamic>? _walletsSubscription;

  /// Subscription for selected asset (Ton/Token)
  StreamSubscription<dynamic>? _currentWalletSubscription;

  void _closeBalanceSubs() {
    _walletsSubscription?.cancel();
    _currentWalletSubscription?.cancel();
  }

  /// Start listening balance for Ton/Token wallets.
  /// If method was called, then [rootTokenContract] must be presented in
  /// [_assets].
  /// For Ton/Token wallets behavior is different.
  void _startListeningBalance(Address rootTokenContract, String tokenSymbol) {
    final contract = _assets[(rootTokenContract, tokenSymbol)];

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

  /// Subscription for native token to find balance
  void _subscribeNativeBalance(WalletPrepareTransferAsset contract) {
    final root = contract.rootTokenContract;
    _walletsSubscription = nekotonRepository.walletsStream.listen((wallets) {
      final walletState = wallets.firstWhereOrNull((w) => w.address == address);

      if (walletState == null) return;

      if (walletState.hasError) {
        emit(WalletPrepareTransferState.subscribeError(walletState.error!));

        return;
      }

      final wallet = walletState.wallet;

      if (wallet != null) {
        _walletsSubscription?.cancel();
        final symbol = nekotonRepository.currentTransport.nativeTokenTicker;

        _currentWalletSubscription = wallet.fieldUpdatesStream.listen((_) {
          final updated = _assets[(root, symbol)]?.copyWith(
            Money.fromBigIntWithCurrency(
              wallet.contractState.balance,
              Currencies()[symbol]!,
            ),
          );
          if (updated != null) {
            _assets[(root, symbol)] = updated;
            if (selectedAsset.rootTokenContract == root &&
                selectedAsset.tokenSymbol == symbol) {
              selectedAsset = updated;
            }
          }

          _updateState();
        });
      }
    });
  }

  /// Subscription for token wallet to find balance
  void _subscribeTokenBalance(WalletPrepareTransferAsset contract) {
    final root = contract.rootTokenContract;
    final symbol = contract.tokenSymbol;
    _walletsSubscription =
        nekotonRepository.tokenWalletsStream.listen((wallets) {
      final walletState = wallets.firstWhereOrNull(
        (w) => w.owner == address && w.rootTokenContract == root,
      );

      if (walletState == null) return;

      if (walletState.hasError) {
        emit(WalletPrepareTransferState.subscribeError(walletState.error!));

        return;
      }

      final wallet = walletState.wallet;

      if (wallet != null) {
        _walletsSubscription?.cancel();
        _currentWalletSubscription = wallet.fieldUpdatesStream.listen((_) {
          final updated =
              _assets[(root, symbol)]?.copyWith(wallet.moneyBalance);
          if (updated != null) {
            _assets[(root, symbol)] = updated;
            if (selectedAsset.rootTokenContract == root &&
                selectedAsset.tokenSymbol == symbol) {
              selectedAsset = updated;
            }
          }

          _updateState();
        });
      }
    });
  }

  String _walletName(NekotonRepository repo, KeyAccount account) {
    return repo.currentTransport
        .defaultAccountName(account.account.tonWallet.contract)
        .toLowerCase();
  }

  Money _zeroBalance(String symbol) {
    return Money.fromBigIntWithCurrency(
      BigInt.zero,
      Currencies()[symbol] ??
          Currency.create(
            symbol,
            0,
            pattern: moneyPattern(0),
          ),
    );
  }

  void _createNativeContract() {
    final transport = nekotonRepository.currentTransport;
    final root = transport.nativeTokenAddress;
    final symbol = transport.nativeTokenTicker;

    selectedAsset = WalletPrepareTransferAsset(
      rootTokenContract: root,
      isNative: true,
      balance: _zeroBalance(transport.nativeTokenTicker),
      tokenSymbol: transport.nativeTokenTicker,
      logoURI: transport.nativeTokenIcon,
      title: transport.nativeTokenTicker,
    );
    _assets[(root, symbol)] = selectedAsset;
    _updateState();

    _startListeningBalance(root, symbol);
  }
}
