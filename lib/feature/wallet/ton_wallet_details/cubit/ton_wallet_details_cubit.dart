import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'ton_wallet_details_cubit.freezed.dart';
part 'ton_wallet_details_state.dart';

/// Cubit that allows loading balance for the [TonWallet] (history loads
/// separately) in widget.
class TonWalletDetailsCubit extends Cubit<TonWalletDetailsState>
    with BlocBaseMixin {
  TonWalletDetailsCubit({
    required this.nekotonRepository,
    required this.address,
    required this.currencyConvertService,
    required this.balanceService,
  }) : super(const TonWalletDetailsState.initial()) {
    final acc = nekotonRepository.seedList.findAccountByAddress(address);
    if (acc == null) {
      emitSafe(const TonWalletDetailsState.empty());

      return;
    }

    account = acc;

    _cachedFiatBalance = currencyConvertService.convert(Fixed.zero);
    _cachedTokenBalance = Money.fromBigIntWithCurrency(
      BigInt.zero,
      Currencies()[nekotonRepository.currentTransport.nativeTokenTicker]!,
    );

    _updateState();

    _walletsSubscription = nekotonRepository.walletsStream.listen((wallets) {
      final walletState = wallets.firstWhereOrNull((w) => w.address == address);
      if (walletState != null) {
        _walletsSubscription?.cancel();

        if (walletState.hasError) {
          emitSafe(
            TonWalletDetailsState.subscribeError(
              symbol: nekotonRepository.currentTransport.nativeTokenTicker,
              account: account,
              error: walletState.error!,
              isLoading: false,
            ),
          );
        } else {
          final wallet = walletState.wallet!;

          _thisWalletSubscription = wallet.fieldUpdatesStream.listen((_) {
            _cachedTokenBalance = Money.fromBigIntWithCurrency(
              wallet.contractState.balance,
              Currencies()[
                  nekotonRepository.currentTransport.nativeTokenTicker]!,
            );

            _updateState();
          });
          _balanceSubscription =
              balanceService.tonWalletBalanceStream(address).listen((balance) {
            _cachedFiatBalance = currencyConvertService.convert(balance);

            _updateState();
          });
        }
      }
    });
  }

  final CurrencyConvertService currencyConvertService;
  final BalanceService balanceService;
  final NekotonRepository nekotonRepository;
  final Address address;
  late KeyAccount account;

  StreamSubscription<dynamic>? _walletsSubscription;
  StreamSubscription<dynamic>? _thisWalletSubscription;
  StreamSubscription<dynamic>? _balanceSubscription;

  late Money _cachedFiatBalance;
  late Money _cachedTokenBalance;

  @override
  Future<void> close() {
    _walletsSubscription?.cancel();
    _thisWalletSubscription?.cancel();
    _balanceSubscription?.cancel();

    return super.close();
  }

  Future<void> retry() async {
    final st = state;
    if (st is _SubscribeError) {
      emitSafe(st.copyWith(isLoading: true));
      await nekotonRepository.retrySubscriptions(address);
      emitSafe(st.copyWith(isLoading: false));
    }
  }

  void _updateState() {
    emitSafe(
      TonWalletDetailsState.data(
        symbol: nekotonRepository.currentTransport.nativeTokenTicker,
        account: account,
        fiatBalance: _cachedFiatBalance,
        tokenBalance: _cachedTokenBalance,
      ),
    );
  }
}
