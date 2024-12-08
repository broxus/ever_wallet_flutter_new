part of 'biometry_cubit.dart';

@freezed
class BiometryState with _$BiometryState {
  const factory BiometryState.init() = _Init;

  /// Display page to ask biometry with fingerprint or face
  const factory BiometryState.ask({
    required bool isFaceBiometry,
  }) = _Ask;

  /// Close screen
  const factory BiometryState.completed() = _Completed;
}
