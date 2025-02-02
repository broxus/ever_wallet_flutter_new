import 'dart:async';

import 'package:app/app/service/connection/group.dart';
import 'package:app/app/service/service.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/data/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'token_wallet_asset_cubit.freezed.dart';
part 'token_wallet_asset_state.dart';

class TokenWalletAssetCubit extends Cubit<TokenWalletAssetState>
    with BlocBaseMixin {
  TokenWalletAssetCubit({
    required this.balanceService,
    required this.asset,
    required this.owner,
    required this.currencyConvertService,
    required this.nekotonRepository,
    required this.balanceStorage,
  }) : super(const TokenWalletAssetState.data()) {
    _walletsSubscription =
        nekotonRepository.tokenWalletsStream.listen((wallets) {
      final walletState = wallets.firstWhereOrNull(
        (w) => w.owner == owner && w.rootTokenContract == asset.address,
      );

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
          _cachedTokenBalance = wallet.moneyBalance;

          _tryUpdateBalances();
          _updateState();
        });
        _balanceSubscription = balanceService
            .tokenWalletBalanceStream(
          owner: owner,
          rootTokenContract: asset.address,
        )
            .listen((balance) {
          _cachedFiatBalance = currencyConvertService.convert(balance);

          _tryUpdateBalances();
          _updateState();
        });
      } else if (walletState?.hasError ?? false) {
        emitSafe(
          TokenWalletAssetState.subscribeError(
            error: walletState!.error!,
            isLoading: false,
          ),
        );
      }
    });

    final balances = balanceStorage
        .getBalances(_networkGroup)[owner]
        ?.tokenBalance(asset.address);
    if (balances != null) {
      _cachedFiatBalance = balances.fiatBalance;
      _cachedTokenBalance = balances.tokenBalance;
      _updateState();
    }
  }

  final BalanceStorageService balanceStorage;
  final TokenContractAsset asset;
  final Address owner;
  final BalanceService balanceService;
  final CurrencyConvertService currencyConvertService;
  final NekotonRepository nekotonRepository;

  StreamSubscription<dynamic>? _walletsSubscription;
  StreamSubscription<dynamic>? _thisWalletSubscription;
  StreamSubscription<dynamic>? _balanceSubscription;

  Money? _cachedFiatBalance;
  Money? _cachedTokenBalance;

  TokenWalletState? _wallet;

  NetworkGroup get _networkGroup =>
      nekotonRepository.currentTransport.transport.group;

  @override
  Future<void> close() {
    _walletsSubscription?.cancel();
    _closeSubs();

    return super.close();
  }

  Future<void> retry() async {
    final st = state;
    if (st is _SubscribeError) {
      emitSafe(st.copyWith(isLoading: true));
      await nekotonRepository.retryTokenSubscription(owner, asset.address);
      emitSafe(st.copyWith(isLoading: false));
    }
  }

  void _closeSubs() {
    _thisWalletSubscription?.cancel();
    _balanceSubscription?.cancel();
  }

  void _tryUpdateBalances() {
    if (_cachedFiatBalance != null && _cachedTokenBalance != null) {
      balanceStorage.setBalances(
        group: _networkGroup,
        accountAddress: owner,
        balance: AccountBalanceModel(
          rootTokenContract: asset.address,
          fiatBalance: _cachedFiatBalance!,
          tokenBalance: _cachedTokenBalance!,
          isNative: false,
        ),
      );
    }
  }

  void _updateState() {
    emitSafe(
      TokenWalletAssetState.data(
        fiatBalance: _cachedFiatBalance,
        tokenBalance: _cachedTokenBalance,
      ),
    );
  }
}
