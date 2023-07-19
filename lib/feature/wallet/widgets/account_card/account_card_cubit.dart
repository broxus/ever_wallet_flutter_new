import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'account_card_cubit_state.dart';

part 'account_card_cubit.freezed.dart';

/// Cubit that will be listen for subscriptions from [NekotonRepository] and
/// provides [TonWallet] to ui.
class AccountCardCubit extends Cubit<AccountCardState> {
  AccountCardCubit(
    this.nekotonRepository,
    this.account,
  ) : super(const AccountCardState.initial());

  final NekotonRepository nekotonRepository;
  final KeyAccount account;

  late StreamSubscription<List<TonWallet>> _walletsSubscription;
  TonWallet? wallet;

  void init() {
    emit(AccountCardState.data(account: account, wallet: null));
    _walletsSubscription = nekotonRepository.walletsStream.listen((wallets) {
      final w = wallets.firstWhereOrNull((w) => w.address == account.address);
      if (w != null) _initWallet(w);
    });
  }

  void _initWallet(TonWallet w) {
    if (wallet != null) return;

    wallet = w;
    emit(AccountCardState.data(account: account, wallet: wallet));
  }

  @override
  Future<void> close() {
    _walletsSubscription.cancel();
    return super.close();
  }
}
