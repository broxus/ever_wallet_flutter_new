import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'wallet_account_actions_state.dart';

part 'wallet_account_actions_cubit.freezed.dart';

/// Action that describes behavior for account.
enum WalletAccountActionBehavior {
  deploy, // deploy wallet needed
  send, // send without any restrictions
  sendLocalCustodiansNeeded, // send button but with showing snackbar
}

/// Cubit for actions for current selected account.
/// This cubit allows identify which actions should be available for account.
class WalletAccountActionsCubit extends Cubit<WalletAccountActionsState> {
  WalletAccountActionsCubit(
    this.nekotonRepository,
    this.address,
  ) : super(const WalletAccountActionsState.loading()) {
    _walletsSubscription = nekotonRepository.walletsStream.listen((wallets) {
      final wl = wallets.firstWhereOrNull((w) => w.address == address);
      if (wl != null) _initWallet(wl);
    });
  }

  final NekotonRepository nekotonRepository;
  final Address address;

  TonWallet? wallet;

  late StreamSubscription<List<TonWallet>> _walletsSubscription;
  StreamSubscription<void>? _thisWalletSubscription;

  void _initWallet(TonWallet w) {
    if (wallet != null) return;

    wallet = w;
    _thisWalletSubscription =
        w.fieldUpdatesStream.listen((_) => _updateWalletData(w));
  }

  void _updateWalletData(TonWallet w) {
    final localCustodians = nekotonRepository.getLocalCustodians(address);
    final details = w.details;
    final contract = w.contractState;

    WalletAccountActionBehavior action;

    if (!details.requiresSeparateDeploy) {
      action = WalletAccountActionBehavior.send;
    } else if (contract.isDeployed) {
      action = localCustodians != null && localCustodians.isNotEmpty
          ? WalletAccountActionBehavior.send
          : WalletAccountActionBehavior.sendLocalCustodiansNeeded;
    } else {
      action = WalletAccountActionBehavior.deploy;
    }

    // TODO(alex-a4): add stake check in transport
    emit(WalletAccountActionsState.data(action: action, hasStake: true));
  }

  @override
  Future<void> close() {
    _walletsSubscription.cancel();
    _thisWalletSubscription?.cancel();

    return super.close();
  }
}
