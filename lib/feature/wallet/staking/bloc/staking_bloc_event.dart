part of 'staking_bloc.dart';

@freezed
class StakingBlocEvent with _$StakingBlocEvent {
  const factory StakingBlocEvent.init() = _Init;

  const factory StakingBlocEvent.selectMax(
    FormFieldState<String>? fieldState,
  ) = _SelectMax;

  const factory StakingBlocEvent.doAction() = _DoAction;

  /// Internal event
  const factory StakingBlocEvent.updateResuests(
    List<StEverWithdrawRequest> requests,
  ) = _UpdateRequests;

  const factory StakingBlocEvent.changeTab(StakingPageType type) = _ChangeTab;

  const factory StakingBlocEvent.updateReceive(Fixed value) = _UpdateReceive;
}
