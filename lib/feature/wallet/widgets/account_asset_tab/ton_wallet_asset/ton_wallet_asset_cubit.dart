import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'ton_wallet_asset_cubit.freezed.dart';
part 'ton_wallet_asset_state.dart';

class TonWalletAssetCubit extends Cubit<TonWalletAssetState> {
  TonWalletAssetCubit({
    required this.balanceService,
    required this.tonWallet,
    required this.currencyConvertService,
    required this.nekotonRepository,
    required this.balanceStorage,
  }) : super(
          TonWalletAssetState.data(
            tokenName: nekotonRepository.currentTransport.nativeTokenTicker,
            iconPath: nekotonRepository.currentTransport.nativeTokenIcon,
          ),
        ) {
    _walletsSubscription = nekotonRepository.walletsStream.listen((wallets) {
      final walletState =
          wallets.firstWhereOrNull((w) => w.address == tonWallet.address);

      final oldWallet = _wallet?.wallet;
      final wallet = walletState?.wallet;
      // wallet not iniaitlized or transport of wallet changed
      if (wallet != null &&
          (oldWallet == null ||
              oldWallet.transport.connectionParamsHash !=
                  wallet.transport.connectionParamsHash)) {
        _wallet = walletState;
        _closeSubs();

        _thisWalletSubscription = wallet.fieldUpdatesStream.listen((_) {
          _cachedTokenBalance = Money.fromBigIntWithCurrency(
            wallet.contractState.balance,
            Currencies()[nekotonRepository.currentTransport.nativeTokenTicker]!,
          );

          _tryUpdateBalances();
          _updateState();
        });
        _balanceSubscription = balanceService
            .tonWalletBalanceStream(tonWallet.address)
            .listen((balance) {
          _cachedFiatBalance = currencyConvertService.convert(balance);

          _tryUpdateBalances();
          _updateState();
        });
      } else if (walletState?.hasError ?? false) {
        emit(
          TonWalletAssetState.subscribeError(
            tokenName: nekotonRepository.currentTransport.nativeTokenTicker,
            iconPath: nekotonRepository.currentTransport.nativeTokenIcon,
            error: walletState!.error!,
            isLoading: false,
          ),
        );
      }
    });

    final balances = balanceStorage.balances[tonWallet.address]
        ?.tokenBalance(_nativeTokenContract, isNative: true);
    if (balances != null) {
      _cachedFiatBalance = balances.fiatBalance;
      _cachedTokenBalance = balances.tokenBalance;
      _updateState();
    }
  }

  final BalanceStorageService balanceStorage;
  final TonWalletAsset tonWallet;
  final BalanceService balanceService;
  final CurrencyConvertService currencyConvertService;
  final NekotonRepository nekotonRepository;

  StreamSubscription<dynamic>? _walletsSubscription;
  StreamSubscription<dynamic>? _thisWalletSubscription;
  StreamSubscription<dynamic>? _balanceSubscription;

  TonWalletState? _wallet;

  Money? _cachedFiatBalance;
  Money? _cachedTokenBalance;

  @override
  Future<void> close() {
    _walletsSubscription?.cancel();
    _closeSubs();

    return super.close();
  }

  Future<void> retry() async {
    final st = state;
    if (st is _SubscribeError) {
      emit(st.copyWith(isLoading: true));
      await nekotonRepository.retrySubscriptions(tonWallet.address);
      emit(st.copyWith(isLoading: false));
    }
  }

  void _closeSubs() {
    _thisWalletSubscription?.cancel();
    _balanceSubscription?.cancel();
  }

  Address get _nativeTokenContract =>
      nekotonRepository.currentTransport.nativeTokenAddress;

  void _tryUpdateBalances() {
    if (_cachedFiatBalance != null && _cachedTokenBalance != null) {
      balanceStorage.setBalances(
        accountAddress: tonWallet.address,
        balance: AccountBalanceModel(
          rootTokenContract: _nativeTokenContract,
          fiatBalance: _cachedFiatBalance!,
          tokenBalance: _cachedTokenBalance!,
          isNative: true,
        ),
      );
    }
  }

  void _updateState() {
    emit(
      TonWalletAssetState.data(
        tokenName: nekotonRepository.currentTransport.nativeTokenTicker,
        iconPath: nekotonRepository.currentTransport.nativeTokenIcon,
        fiatBalance: _cachedFiatBalance,
        tokenBalance: _cachedTokenBalance,
      ),
    );
  }
}
