import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'account_detail_state.dart';

part 'account_detail_cubit.freezed.dart';

/// Cubit for account detail page
class AccountDetailCubit extends Cubit<AccountDetailState> {
  AccountDetailCubit(
    this.address,
    this.nekotonRepository,
  ) : super(const AccountDetailState.initial());

  final Address address;
  final NekotonRepository nekotonRepository;

  late StreamSubscription<SeedList> _seedListSubscription;

  void init() {
    _seedListSubscription =
        nekotonRepository.seedListStream.listen(_updateDataState);
  }

  void _updateDataState(SeedList list) {
    final account = list.findAccountByAddress(address);
    if (account == null) {
      emit(const AccountDetailState.empty());
    } else {
      emit(AccountDetailState.data(account));
    }
  }

  @override
  Future<void> close() {
    _seedListSubscription.cancel();

    return super.close();
  }
}
