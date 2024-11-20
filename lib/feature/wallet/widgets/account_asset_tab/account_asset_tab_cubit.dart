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
    this.tokenWalletsService,
    this.assetsService, {
    required this.isShowingNewTokens,
  })  : tonWallet = account.account.tonWallet,
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

    _searchSubscription = tokenWalletsService
        .searchTokenWalletsForAddress(tonWallet.address)
        .reduce((previous, element) => [...previous, ...element])
        .asStream()
        .listen(
      (value) {
        _updateAccounts(value.length);
      },
      onError: (_) => _updateAccounts(0),
    );
  }

  final AssetsService assetsService;
  final TokenWalletsService tokenWalletsService;
  final TonWalletAsset tonWallet;
  final bool isShowingNewTokens;

  late List<TokenContractAsset>? _contracts;
  int? _contractCount;
  late StreamSubscription<List<TokenContractAsset>> _contractsSubscription;
  StreamSubscription<dynamic>? _searchSubscription;

  @override
  Future<void> close() async {
    await _contractsSubscription.cancel();
    await _searchSubscription?.cancel();

    return super.close();
  }

  void _updateAccounts(int contractCount) {
    _contractCount = contractCount;

    emit(
      AccountAssetTabState.accounts(
        tonWallet,
        _contracts,
        _contractCount,
      ),
    );
  }
}
