import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'ton_wallet_asset_state.dart';

part 'ton_wallet_asset_cubit.freezed.dart';

class TonWalletAssetCubit extends Cubit<TonWalletAssetState> {
  TonWalletAssetCubit({
    required this.balanceService,
    required this.tonWallet,
    required this.currencyConvertService,
    required this.nekotonRepository,
  }) : super(
          TonWalletAssetState.data(
            iconPath: nekotonRepository.currentTransport.nativeTokenIcon,
          ),
        ) {
    _walletsSubscription = nekotonRepository.walletsStream.listen((wallets) {
      final wallet =
          wallets.firstWhereOrNull((w) => w.address == tonWallet.address);
      if (wallet != null) {
        _walletsSubscription?.cancel();

        _thisWalletSubscription =
            wallet.fieldUpdatesStream.startWith(null).listen((_) {
          _cachedTokenBalance = Money.fromBigIntWithCurrency(
            wallet.contractState.balance,
            Currencies()[nekotonRepository.currentTransport.nativeTokenTicker]!,
          );

          _updateState();
        });
        _balanceSubscription = balanceService
            .tonWalletBalanceStream(tonWallet.address)
            .listen((balance) {
          _cachedFiatBalance = currencyConvertService.convert(balance);

          _updateState();
        });
      }
    });
  }

  final TonWalletAsset tonWallet;
  final BalanceService balanceService;
  final CurrencyConvertService currencyConvertService;
  final NekotonRepository nekotonRepository;

  StreamSubscription<dynamic>? _walletsSubscription;
  StreamSubscription<dynamic>? _thisWalletSubscription;
  StreamSubscription<dynamic>? _balanceSubscription;

  Money? _cachedFiatBalance;
  Money? _cachedTokenBalance;

  @override
  Future<void> close() {
    _walletsSubscription?.cancel();
    _thisWalletSubscription?.cancel();
    _balanceSubscription?.cancel();

    return super.close();
  }

  void _updateState() {
    emit(
      TonWalletAssetState.data(
        iconPath: nekotonRepository.currentTransport.nativeTokenIcon,
        fiatBalance: _cachedFiatBalance,
        tokenBalance: _cachedTokenBalance,
      ),
    );
  }
}