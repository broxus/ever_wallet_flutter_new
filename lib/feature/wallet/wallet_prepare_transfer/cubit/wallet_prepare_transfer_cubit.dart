import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/cubit/cubit.dart';
import 'package:app/generated/generated.dart';
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
    required this.nekotonRepository,
    required this.balanceService,
    required this.assetsService,
    required this.address,
    required this.rootTokenContract,
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
      // if default contract is specified, then lock it
      if (root == nekotonRepository.currentTransport.nativeTokenAddress) {
        _createNativeContract();
      } else {
        _findSpecifiedContract(root);
      }
    }

    // Get local custodians async because TonWallet can be missed if
    // <rootTokenContract> is not null
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
  /// Key - rootTokenContract
  final _assets = <Address, WalletPrepareTransferAsset>{};

  @override
  Future<void> close() {
    _closeBalanceSubs();
    _contractSubscription?.cancel();

    return super.close();
  }

  void changeAsset(Address rootTokenContract) {
    final asset = _assets[rootTokenContract];
    if (selectedAsset.rootTokenContract == rootTokenContract || asset == null) {
      return;
    }

    selectedAsset = asset;
    _updateState();
    _startListeningBalance(rootTokenContract);
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
  }

  void _updateState() {
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
            e.address,
            WalletPrepareTransferAsset(
              rootTokenContract: e.address,
              isNative: false,
              balance: _zeroBalance(e.symbol),
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
      title: contract.name,
      version: contract.version,
    );
    _assets[root] = selectedAsset;
    _updateState();

    _startListeningBalance(root);
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
  void _startListeningBalance(Address rootTokenContract) {
    final contract = _assets[rootTokenContract];

    _closeBalanceSubs();
    if (contract == null) {
      return;
    }

    if (contract.isNative) {
      _subscribeNativeBalance(rootTokenContract);
    } else {
      _subscribeTokenBalance(rootTokenContract);
    }
  }

  /// Subscription for native token to find balance
  void _subscribeNativeBalance(Address root) {
    _walletsSubscription = nekotonRepository.walletsStream.listen((wallets) {
      final wallet = wallets.firstWhereOrNull((w) => w.address == address);
      if (wallet != null) {
        _walletsSubscription?.cancel();

        _currentWalletSubscription = wallet.fieldUpdatesStream.listen((_) {
          final updated = _assets[root]?.copyWith(
            Money.fromBigIntWithCurrency(
              wallet.contractState.balance,
              Currencies()[
                  nekotonRepository.currentTransport.nativeTokenTicker]!,
            ),
          );
          if (updated != null) {
            _assets[root] = updated;
            if (selectedAsset.rootTokenContract == root) {
              selectedAsset = updated;
            }
          }

          _updateState();
        });
      }
    });
  }

  /// Subscription for token wallet to find balance
  void _subscribeTokenBalance(Address root) {
    _walletsSubscription =
        nekotonRepository.tokenWalletsStream.listen((wallets) {
      final wallet = wallets.firstWhereOrNull(
        (w) => w.owner == address && w.rootTokenContract == root,
      );
      if (wallet != null) {
        _walletsSubscription?.cancel();
        _currentWalletSubscription = wallet.fieldUpdatesStream.listen((_) {
          final updated = _assets[root]?.copyWith(wallet.moneyBalance);
          if (updated != null) {
            _assets[root] = updated;
            if (selectedAsset.rootTokenContract == root) {
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

    selectedAsset = WalletPrepareTransferAsset(
      rootTokenContract: root,
      isNative: true,
      balance: _zeroBalance(transport.nativeTokenTicker),
      logoURI: transport.nativeTokenIcon,
      title: transport.nativeTokenTicker,
    );
    _assets[root] = selectedAsset;
    _updateState();

    _startListeningBalance(root);
  }
}