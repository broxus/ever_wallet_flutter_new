part of 'profile_bloc.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;

  /// [currentSeed] is seed for current key.
  const factory ProfileState.data({
    required Seed currentSeed,
    required bool isBiometryAvailable,
  }) = _Data;
}
