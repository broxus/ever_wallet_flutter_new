part of 'action_staking_bloc.dart';

@freezed
class ActionStakingBlocState with _$ActionStakingBlocState {
  /// no any action in progress
  const factory ActionStakingBlocState.nothing() = _Nothing;

  /// Means loading indicator should be displayed
  const factory ActionStakingBlocState.inProgress() = _InProgress;

  /// Show sheet describing staking mechanism
  const factory ActionStakingBlocState.showHowItWorksSheet() = _ShowHowItWorks;

  /// Navigate to stake confirm transaction in ui
  const factory ActionStakingBlocState.goStake({
    required String payload,
    // amount in native tokens
    required BigInt amount,
    required Address destination,
    required Address sender,
    required PublicKey accountKey,
    required BigInt attachedFee,
  }) = _GoStake;

  /// Navigate to stake confirm transaction in ui
  const factory ActionStakingBlocState.goUnstake({
    required String payload,
    // amount in staking tokens
    required BigInt amount,
    required Address destination,
    required Address sender,
    required PublicKey accountKey,
    required BigInt attachedFee,
    required int withdrawHours,
    required Address stakeContractAddress,
  }) = _GoUnstake;
}
