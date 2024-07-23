part of 'add_seed_enable_biometry_cubit.dart';

@freezed
class AddSeedEnableBiometryState with _$AddSeedEnableBiometryState {
  const factory AddSeedEnableBiometryState.init() = _Init;

  /// Display page to ask biometry with fingerprint or face
  const factory AddSeedEnableBiometryState.ask({
    required bool isFaceBiometry,
  }) = _Ask;

  /// Close screen
  const factory AddSeedEnableBiometryState.completed() = _Completed;
}
