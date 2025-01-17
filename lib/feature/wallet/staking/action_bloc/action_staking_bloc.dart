import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/utils/utils.dart';
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
    required this.gasPriceService,
  }) : super(const ActionStakingBlocState.nothing()) {
    _registerHandlers();
  }

  final NekotonRepository nekotonRepository;
  final Address accountAddress;
  final StakingService stakingService;
  final GeneralStorageService storage;
  final GasPriceService gasPriceService;

  StakingInformation? _staking;

  void _registerHandlers() {
    on<_Init>(_prepareInit);
    on<_Stake>(_prepareStaking);
    on<_Unstake>(_prepareUntaking);
  }

  Future<void> _prepareStaking(
    _Stake event,
    Emitter<ActionStakingBlocState> emit,
  ) async {
    final valutAddress = _staking?.stakingValutAddress;
    final depositAttachedFee = _staking?.stakeDepositAttachedFee;

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
    final valutAddress = _staking?.stakingValutAddress;
    final withdrawAttachedFee = _staking?.stakeWithdrawAttachedFee;
    final rootContractAddress = _staking?.stakingRootContractAddress;

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
    _staking = await _getStakingInformation();
    final rootContractAddress = _staking?.stakingRootContractAddress;

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

  Future<StakingInformation?> _getStakingInformation() async {
    final staking = nekotonRepository.currentTransport.stakeInformation;
    if (staking == null) return null;

    final prices = await gasPriceService.getGasPriceParams();
    final (deposit, withdraw, removePendingWithdraw) = await FutureExt.wait3(
      gasPriceService.computeGas(staking.stakeDepositAttachedFee, prices),
      gasPriceService.computeGas(staking.stakeWithdrawAttachedFee, prices),
      gasPriceService.computeGas(
        staking.stakeRemovePendingWithdrawAttachedFee,
        prices,
      ),
    );

    return StakingInformation(
      stakingAPYLink: staking.stakingAPYLink,
      stakingRootContractAddress: staking.stakingRootContractAddress,
      stakingValutAddress: staking.stakingValutAddress,
      stakeDepositAttachedFee: deposit,
      stakeWithdrawAttachedFee: withdraw,
      stakeRemovePendingWithdrawAttachedFee: removePendingWithdraw,
    );
  }
}
