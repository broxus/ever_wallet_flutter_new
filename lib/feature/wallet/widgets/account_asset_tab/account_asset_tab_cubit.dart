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
    this.assetsService,
  )   : tonWallet = account.account.tonWallet,
        super(AccountAssetTabState.accounts(account.account.tonWallet, null)) {
    _contractsSubscription = assetsService
        .contractsForAccount(tonWallet.address)
        .listen((contracts) {
      emit(AccountAssetTabState.accounts(tonWallet, contracts));
    });
  }

  final AssetsService assetsService;
  final TonWalletAsset tonWallet;

  late StreamSubscription<List<TokenContractAsset>> _contractsSubscription;

  @override
  Future<void> close() {
    _contractsSubscription.cancel();

    return super.close();
  }
}
