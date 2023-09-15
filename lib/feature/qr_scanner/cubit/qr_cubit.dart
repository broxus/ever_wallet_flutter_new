import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

part 'qr_cubit_state.dart';

part 'qr_cubit.freezed.dart';

/// Cubit that helps with scanning QR codes via camera or taking image.
class QrCubit extends Cubit<QrCubitState> {
  QrCubit(this.permissionsService) : super(const QrCubitState.loading()) {
    requestCamera();
  }

  final AppPermissionsService permissionsService;

  final controller = MobileScannerController();

  /// Request camera access and if given, start scanning
  Future<void> requestCamera() async {
    final isGranted = await permissionsService.requestCamera();
    if (!isGranted) {
      emit(const QrCubitState.givePermissionsError());
    } else {
      emit(QrCubitState.scanning(controller));
    }
  }

  void openSettings() => permissionsService.openSettings();

  Future<void> tryScanPhoto() async {
    if (await permissionsService.requestPhotos()) {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 30,
      );

      if (image != null) {
        await controller.analyzeImage(image.path);
      }
    } else {
      inject<MessengerService>().show(
        Message.error(
          message: LocaleKeys.givePhotosPermission.tr(),
          actionText: LocaleKeys.giveWord.tr(),
          onAction: openSettings,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    controller.dispose();

    return super.close();
  }
}
