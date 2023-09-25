part of 'action_staking_bloc.dart';

@freezed
class ActionStakingBlocEvent with _$ActionStakingBlocEvent {
  /// Check for showing how it works sheet and add stever to list of contracts
  /// to account.
  const factory ActionStakingBlocEvent.init() = _Init;

  const factory ActionStakingBlocEvent.stake({
    // in native tokens
    required BigInt amount,
    required PublicKey accountKey,
  }) = _Stake;

  const factory ActionStakingBlocEvent.unstake({
    // in staking tokens
    required BigInt amount,
    required PublicKey accountKey,
    required int withdrawHours,
  }) = _Unstake;
}
