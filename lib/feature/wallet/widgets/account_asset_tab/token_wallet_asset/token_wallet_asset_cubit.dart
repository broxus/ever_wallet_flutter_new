import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'token_wallet_asset_state.dart';

part 'token_wallet_asset_cubit.freezed.dart';

class TokenWalletAssetCubit extends Cubit<TokenWalletAssetState> {
  TokenWalletAssetCubit({
    required this.balanceService,
    required this.asset,
    required this.owner,
    required this.currencyConvertService,
    required this.nekotonRepository,
  }) : super(const TokenWalletAssetState.data()) {
    _walletsSubscription =
        nekotonRepository.tokenWalletsStream.listen((wallets) {
      final wallet = wallets.firstWhereOrNull(
        (w) => w.owner == owner && w.address == asset.address,
      );
      if (wallet != null) {
        _walletsSubscription?.cancel();

        _thisWalletSubscription =
            wallet.fieldUpdatesStream.startWith(null).listen((_) {
          _cachedTokenBalance = wallet.moneyBalance;

          _updateState();
        });
        _balanceSubscription = balanceService
            .tokenWalletBalanceStream(
          owner: owner,
          rootTokenContract: asset.address,
        )
            .listen((balance) {
          _cachedFiatBalance = currencyConvertService.convert(balance);

          _updateState();
        });
      }
    });
  }

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

  @override
  Future<void> close() {
    _walletsSubscription?.cancel();
    _thisWalletSubscription?.cancel();
    _balanceSubscription?.cancel();

    return super.close();
  }

  void _updateState() {
    emit(
      TokenWalletAssetState.data(
        fiatBalance: _cachedFiatBalance,
        tokenBalance: _cachedTokenBalance,
      ),
    );
  }
}
