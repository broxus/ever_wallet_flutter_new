part of 'enter_password_cubit.dart';

@freezed
class EnterPasswordState with _$EnterPasswordState {
  const factory EnterPasswordState.initial() = _Initial;

  /// User tries to auth via biometry
  /// If [isFace] is true, auth by face, else by fingerprint (or other, but
  /// we display finger icon)
  const factory EnterPasswordState.biometry({required bool isFace}) = _Biometry;

  /// User tries to auth via entering password
  const factory EnterPasswordState.password() = _Password;

  /// User authorized via biometry or password
  /// if [fromBiometry] is true, then display biometry widget, else password.
  /// [isFaceBiometry] is used only for biometry widget.
  const factory EnterPasswordState.entered({
    required String password,
    required bool fromBiometry,
    required bool isFaceBiometry,
  }) = _Entered;
}
