part of 'profile_bloc.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;

  /// [currentSeed] is seed for current key.
  /// [exportedSeed] is seed for [currentSeed], that was exported with password.
  const factory ProfileState.data({
    required Seed currentSeed,
    List<String>? exportedSeed,
  }) = _Data;
}
