part of 'profile_bloc.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;

  const factory ProfileState.data({
    required SeedList seedList,
    required String currentSeed,
    required bool biometryEnabled,
    required bool biometryAvailable,
  }) = _Data;
}
