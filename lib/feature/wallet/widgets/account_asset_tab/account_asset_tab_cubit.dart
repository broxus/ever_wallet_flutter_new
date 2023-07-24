import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'account_asset_tab_state.dart';

part 'account_asset_tab_cubit.freezed.dart';

/// Cubit to assets tab from wallet bottom panel.
/// This cubit allows tracking for account with [accountAddress] changing.
///
/// This cubit also tracks for contracts changing.
class AccountAssetTabCubit extends Cubit<AccountAssetTabState> {
  AccountAssetTabCubit(
    KeyAccount account,
    this.nekotonRepository,
  )   : accountAddress = account.address,
        super(AccountAssetTabState.account(account)) {
    _seedListSubscription =
        nekotonRepository.seedListStream.skip(1).listen((list) {
      final newAccount = list.findAccountByAddress(accountAddress);
      if (newAccount == null) {
        emit(const AccountAssetTabState.empty());

        return;
      }
      emit(AccountAssetTabState.account(newAccount));
    });
  }

  final NekotonRepository nekotonRepository;
  final Address accountAddress;

  late StreamSubscription<SeedList> _seedListSubscription;

  @override
  Future<void> close() {
    _seedListSubscription.cancel();

    return super.close();
  }
}
