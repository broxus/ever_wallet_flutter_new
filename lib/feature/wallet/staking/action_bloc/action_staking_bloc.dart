import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'action_staking_bloc.freezed.dart';
part 'action_staking_bloc_event.dart';
part 'action_staking_bloc_state.dart';

/// Helper bloc that can prepare transaction for sending before open send screen
class ActionStakingBloc
    extends Bloc<ActionStakingBlocEvent, ActionStakingBlocState> {
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

  StakingInformation get staking =>
      nekotonRepository.currentTransport.stakeInformation!;

  void _registerHandlers() {
    on<_Init>(_prepareInit);
    on<_Stake>(_prepareStaking);
    on<_Unstake>(_prepareUntaking);
  }

  Future<void> _prepareStaking(
    _Stake event,
    Emitter<ActionStakingBlocState> emit,
  ) async {
    emit(const ActionStakingBlocState.inProgress());

    final payload = await stakingService.depositEverBodyPayload(event.amount);

    emit(
      ActionStakingBlocState.goStake(
        payload: payload,
        amount: event.amount,
        destination: staking.stakingValutAddress,
        sender: accountAddress,
        accountKey: event.accountKey,
        attachedFee: staking.stakeDepositAttachedFee,
      ),
    );
    emit(const ActionStakingBlocState.nothing());
  }

  Future<void> _prepareUntaking(
    _Unstake event,
    Emitter<ActionStakingBlocState> emit,
  ) async {
    emit(const ActionStakingBlocState.inProgress());

    final payload = await stakingService.withdrawStEverPayload();

    emit(
      ActionStakingBlocState.goUnstake(
        payload: payload,
        amount: event.amount,
        destination: staking.stakingValutAddress,
        sender: accountAddress,
        accountKey: event.accountKey,
        attachedFee: staking.stakeWithdrawAttachedFee,
        withdrawHours: event.withdrawHours,
        stakeContractAddress: staking.stakingRootContractAddress,
      ),
    );
    emit(const ActionStakingBlocState.nothing());
  }

  Future<void> _prepareInit(
    _Init event,
    Emitter<ActionStakingBlocState> emit,
  ) async {
    final group = nekotonRepository.currentTransport.transport.group;
    final account =
        nekotonRepository.seedList.findAccountByAddress(accountAddress);
    // if staking coin not in account, add it
    if (account?.additionalAssets[group]?.tokenWallets.firstWhereOrNull(
          (c) => c.rootTokenContract == staking.stakingRootContractAddress,
        ) ==
        null) {
      unawaited(account?.addTokenWallet(staking.stakingRootContractAddress));
    }

    final opened = storage.getWasStEverOpened;

    if (!opened) {
      emit(const ActionStakingBlocState.showHowItWorksSheet());
      storage.saveWasStEverOpened();
      emit(const ActionStakingBlocState.nothing());
    }
  }
}
