import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/data/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'wallet_account_actions_cubit.freezed.dart';

part 'wallet_account_actions_state.dart';

/// Action that describes behavior for account.
enum WalletAccountActionBehavior {
  deploy, // deploy wallet needed
  send, // send without any restrictions
  sendLocalCustodiansNeeded, // send button but with showing snackbar
}

/// Cubit for actions for current selected account.
/// This cubit allows identify which actions should be available for account.
class WalletAccountActionsCubit extends Cubit<WalletAccountActionsState>
    with BlocBaseMixin {
  WalletAccountActionsCubit(
    this.nekotonRepository,
    this.address,
    this.stakingService,
  ) : super(
          WalletAccountActionsState.loading(
            hasStake:
                nekotonRepository.currentTransport.stakeInformation != null,
            nativeTokenTicker:
                nekotonRepository.currentTransport.nativeTokenTicker,
          ),
        ) {
    _walletsSubscription = nekotonRepository.walletsStream.listen((wallets) {
      final wl = wallets.firstWhereOrNull((w) => w.address == address)?.wallet;
      if (wl != null) _initWallet(wl);
    });
  }

  static final _logger = Logger('WalletAccountActionsCubit');

  final NekotonRepository nekotonRepository;
  final Address address;
  final StakingService stakingService;

  TonWallet? wallet;

  late StreamSubscription<List<TonWalletState>> _walletsSubscription;
  StreamSubscription<void>? _thisWalletSubscription;
  StreamSubscription<dynamic>? _withdrawsSubscription;

  List<StEverWithdrawRequest> _cachedWithdraws = [];

  void _initWallet(TonWallet w) {
    if (wallet != null &&
        wallet!.transport.connectionParamsHash ==
            w.transport.connectionParamsHash) {
      return;
    }

    _closeSubs();

    wallet = w;
    _thisWalletSubscription =
        w.fieldUpdatesStream.listen((_) => _updateWalletData(w));
    _withdrawsSubscription =
        stakingService.withdrawRequestsStream(address).listen((withdraws) {
      _cachedWithdraws = withdraws;
      _updateWalletData(wallet!);
    });
  }

  Future<void> _updateWalletData(TonWallet w) async {
    try {
      final details = w.details;
      final contract = w.contractState;

      WalletAccountActionBehavior action;

      if (!details.requiresSeparateDeploy) {
        action = WalletAccountActionBehavior.send;
      } else if (contract.isDeployed) {
        final localCustodians =
            await nekotonRepository.getLocalCustodians(address);
        action = localCustodians != null && localCustodians.isNotEmpty
            ? WalletAccountActionBehavior.send
            : WalletAccountActionBehavior.sendLocalCustodiansNeeded;
      } else {
        action = WalletAccountActionBehavior.deploy;
      }

      final hasStake = action != WalletAccountActionBehavior.deploy &&
          nekotonRepository.currentTransport.stakeInformation != null;

      emitSafe(
        WalletAccountActionsState.data(
          action: action,
          hasStake: hasStake,
          hasStakeActions: hasStake && _cachedWithdraws.isNotEmpty,
          balance: contract.balance,
          minBalance: state.mapOrNull(data: (value) => value.minBalance),
          custodians: wallet?.custodians,
          nativeTokenTicker:
              nekotonRepository.currentTransport.nativeTokenTicker,
          numberUnconfirmedTransactions:
              (wallet?.unconfirmedTransactions.length ?? 0) +
                  (wallet?.pendingTransactions.length ?? 0),
        ),
      );

      if (action == WalletAccountActionBehavior.deploy) {
        unawaited(_estimateFees());
      }
    } catch (e, s) {
      _logger.warning('Error while updating wallet data', e, s);
    }
  }

  Future<void> _estimateFees() async {
    try {
      final message = await nekotonRepository.prepareDeploy(
        address,
        defaultSendTimeout,
      );
      final fees = await nekotonRepository.estimateDeploymentFees(
        address: address,
        message: message,
      );

      final nextState = state.mapOrNull(
        data: (value) => value.copyWith(minBalance: fees),
      );
      nextState?.let(emitSafe);
    } on Exception catch (e, t) {
      _logger.severe('estimateFees', e, t);
    }
  }

  void _closeSubs() {
    _withdrawsSubscription?.cancel();
    _thisWalletSubscription?.cancel();
  }

  @override
  Future<void> close() {
    _walletsSubscription.cancel();
    _closeSubs();

    return super.close();
  }
}
