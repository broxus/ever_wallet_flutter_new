part of 'add_seed_enable_biometry_cubit.dart';

@Deprecated('Use v2 version')
@freezed
class AddSeedEnableBiometryState with _$AddSeedEnableBiometryState {
  @Deprecated('Use v2 version')
  const factory AddSeedEnableBiometryState.init() = _Init;

  /// Display page to ask biometry with fingerprint or face
  @Deprecated('Use v2 version')
  const factory AddSeedEnableBiometryState.ask({
    required bool isFaceBiometry,
  }) = _Ask;

  /// Close screen
  @Deprecated('Use v2 version')
  const factory AddSeedEnableBiometryState.completed() = _Completed;
}
