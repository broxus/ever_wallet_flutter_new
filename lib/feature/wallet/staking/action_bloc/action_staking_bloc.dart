import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'action_staking_bloc.freezed.dart';

part 'action_staking_bloc_event.dart';

part 'action_staking_bloc_state.dart';

/// Helper bloc that can prepare transaction for sending before open send screen
class ActionStakingBloc
    extends Bloc<ActionStakingBlocEvent, ActionStakingBlocState>
    with BlocMixin, BlocBaseMixin {
  ActionStakingBloc({
    required this.nekotonRepository,
    required this.accountAddress,
    required this.stakingService,
    required this.storage,
  }) : super(const ActionStakingBlocState.nothing()) {
    _registerHandlers();
  }

  final NekotonRepository nekotonRepository;
  final Address accountAddress;
  final StakingService stakingService;
  final GeneralStorageService storage;

  StakingInformation? get staking =>
      nekotonRepository.currentTransport.stakeInformation;

  void _registerHandlers() {
    on<_Init>(_prepareInit);
    on<_Stake>(_prepareStaking);
    on<_Unstake>(_prepareUntaking);
  }

  Future<void> _prepareStaking(
    _Stake event,
    Emitter<ActionStakingBlocState> emit,
  ) async {
    final valutAddress = staking?.stakingValutAddress;
    final depositAttachedFee = staking?.stakeDepositAttachedFee;

    if (valutAddress == null || depositAttachedFee == null) {
      return;
    }

    emitSafe(const ActionStakingBlocState.inProgress());

    final payload = await stakingService.depositEverBodyPayload(event.amount);

    emitSafe(
      ActionStakingBlocState.goStake(
        payload: payload,
        amount: event.amount,
        destination: valutAddress,
        sender: accountAddress,
        accountKey: event.accountKey,
        attachedFee: depositAttachedFee,
      ),
    );
    emitSafe(const ActionStakingBlocState.nothing());
  }

  Future<void> _prepareUntaking(
    _Unstake event,
    Emitter<ActionStakingBlocState> emit,
  ) async {
    final valutAddress = staking?.stakingValutAddress;
    final withdrawAttachedFee = staking?.stakeWithdrawAttachedFee;
    final rootContractAddress = staking?.stakingRootContractAddress;

    if (valutAddress == null ||
        withdrawAttachedFee == null ||
        rootContractAddress == null) {
      return;
    }

    emitSafe(const ActionStakingBlocState.inProgress());

    final payload = await stakingService.withdrawStEverPayload();

    emitSafe(
      ActionStakingBlocState.goUnstake(
        payload: payload,
        amount: event.amount,
        destination: valutAddress,
        sender: accountAddress,
        accountKey: event.accountKey,
        attachedFee: withdrawAttachedFee,
        withdrawHours: event.withdrawHours,
        stakeContractAddress: rootContractAddress,
      ),
    );
    emitSafe(const ActionStakingBlocState.nothing());
  }

  Future<void> _prepareInit(
    _Init event,
    Emitter<ActionStakingBlocState> emit,
  ) async {
    final rootContractAddress = staking?.stakingRootContractAddress;

    if (rootContractAddress == null) {
      return;
    }

    final group = nekotonRepository.currentTransport.transport.group;
    final account =
        nekotonRepository.seedList.findAccountByAddress(accountAddress);
    // if staking coin not in account, add it
    if (account?.additionalAssets[group]?.tokenWallets.firstWhereOrNull(
          (c) => c.rootTokenContract == rootContractAddress,
        ) ==
        null) {
      unawaited(account?.addTokenWallet(rootContractAddress));
    }

    final opened = storage.getWasStEverOpened;

    if (!opened) {
      emitSafe(const ActionStakingBlocState.showHowItWorksSheet());
      storage.saveWasStEverOpened();
      emitSafe(const ActionStakingBlocState.nothing());
    }
  }
}
