part of 'qr_cubit.dart';

@freezed
class QrCubitState with _$QrCubitState {
  const factory QrCubitState.loading() = _Loading;

  const factory QrCubitState.givePermissionsError() = _GivePermissions;

  const factory QrCubitState.scanning({
    required MobileScannerController controller,
    String? data,
  }) = _Scanning;
}
