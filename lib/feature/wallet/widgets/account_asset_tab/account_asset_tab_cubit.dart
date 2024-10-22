import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'account_asset_tab_cubit.freezed.dart';

part 'account_asset_tab_state.dart';

/// Cubit to assets tab from wallet bottom panel.
/// This cubit allows tracking contracts for account with [tonWallet]
/// information.
class AccountAssetTabCubit extends Cubit<AccountAssetTabState> {
  AccountAssetTabCubit(
    KeyAccount account,
    this.isFirstEntering,
    this.assetsService,
    this.balanceStorage,
  )   : tonWallet = account.account.tonWallet,
        super(
          AccountAssetTabState.accounts(account.account.tonWallet, null, 0),
        ) {
    _contractsSubscription = assetsService
        .contractsForAccount(tonWallet.address)
        .listen((contracts) {
      _contracts = contracts;
      emit(
        AccountAssetTabState.accounts(tonWallet, _contracts, _contractCount),
      );
    });
    if (isFirstEntering) {
      _allContractsSubscription = assetsService
          .allAvailableContractsForAccount(account.address)
          .listen((value) {
        value.$1.removeWhere((e) {
          final tokenBalance = balanceStorage.balances[account.address]
              ?.tokenBalance(e.address)
              ?.tokenBalance;
          return tokenBalance == null || tokenBalance.amount == Fixed.zero;
        });
        _contractCount = value.$1.length;
        emit(
          AccountAssetTabState.accounts(tonWallet, _contracts, _contractCount),
        );
      });
    }
  }

  final AssetsService assetsService;
  final BalanceStorageService balanceStorage;
  final TonWalletAsset tonWallet;
  final bool isFirstEntering;

  late List<TokenContractAsset>? _contracts;
  late int _contractCount = 0;
  late StreamSubscription<List<TokenContractAsset>> _contractsSubscription;
  StreamSubscription<(List<TokenContractAsset>, List<TokenContractAsset>)>?
      _allContractsSubscription;

  @override
  Future<void> close() {
    _contractsSubscription.cancel();
    _allContractsSubscription?.cancel();

    return super.close();
  }
}
