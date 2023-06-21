part of 'change_seed_password_cubit.dart';

@freezed
class ChangeSeedPasswordState with _$ChangeSeedPasswordState {
  /// Default state
  const factory ChangeSeedPasswordState.initial() = _Initial;

  /// Show error to user
  const factory ChangeSeedPasswordState.error(String errorCode) = _Error;

  /// Password changed, close sheet
  const factory ChangeSeedPasswordState.completed() = _Completed;
}
