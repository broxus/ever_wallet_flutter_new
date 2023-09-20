part of 'staking_bloc.dart';

@freezed
class StakingBlocEvent with _$StakingBlocEvent {
  const factory StakingBlocEvent.init() = _Init;

  const factory StakingBlocEvent.selectMax() = _SelectMax;

  /// Internal event
  const factory StakingBlocEvent.updateResuests(
    List<StEverWithdrawRequest> requests,
  ) = _UpdateRequests;

  const factory StakingBlocEvent.changeTab(StakingPageType type) = _ChangeTab;

  const factory StakingBlocEvent.updateReceive(Money? receive) = _UpdateReceive;
}
