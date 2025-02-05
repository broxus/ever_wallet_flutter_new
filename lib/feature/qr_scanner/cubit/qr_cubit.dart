// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:app/app/service/service.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart' hide Address;
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

part 'qr_cubit.freezed.dart';
part 'qr_cubit_state.dart';

enum SettingsOpenType { camera, photos }

/// Type of scanning data, that will be validated before return
enum QrScanType {
  address;

  String get description {
    switch (this) {
      case QrScanType.address:
        return LocaleKeys.addressWord.tr();
    }
  }
}

/// Cubit that helps with scanning QR codes via camera or taking image.
class QrCubit extends Cubit<QrCubitState> with BlocBaseMixin {
  QrCubit({
    required this.context,
    required this.permissionsService,
    required this.type,
    required this.lifecycleService,
  }) : super(const QrCubitState.loading()) {
    requestCamera();
    _lifecycleListener =
        lifecycleService.appLifecycleStateStream.listen((state) {
      final perms = _awaitingPermissions;
      if (perms != null && state == AppLifecycleState.resumed) {
        _awaitingPermissions = null;

        switch (perms) {
          case SettingsOpenType.camera:
            requestCamera();
          case SettingsOpenType.photos:
            tryScanPhoto();
        }
      }
    });
  }

  final BuildContext context;
  final QrScanType type;
  final AppLifecycleService lifecycleService;
  final AppPermissionsService permissionsService;
  StreamSubscription<dynamic>? _lifecycleListener;

  final controller = MobileScannerController();

  /// If not null, then [_lifecycleListener] will request permissions again
  /// after user returned from settings
  SettingsOpenType? _awaitingPermissions;

  /// Request camera access and if given, start scanning
  Future<void> requestCamera() async {
    final isGranted = await permissionsService.requestCamera();
    if (!isGranted) {
      emitSafe(const QrCubitState.givePermissionsError());
    } else {
      emitSafe(QrCubitState.scanning(controller: controller));
    }
  }

  void openSettings(SettingsOpenType settingsType) {
    _awaitingPermissions = settingsType;
    permissionsService.openSettings();
  }

  void analyzeBarcodes(BarcodeCapture barcodes) {
    final codes = barcodes.barcodes;
    if (codes.isNotEmpty && codes.first.rawValue != null) {
      _validateDataAndComplete(codes.first.rawValue);
    }
  }

  Future<void> tryScanPhoto() async {
    final isGranted =
        Platform.isAndroid || await permissionsService.requestPhotos();
    if (isGranted) {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (image != null) {
        if (state is _GivePermissions) {
          late StreamSubscription<dynamic> sub;
          sub = controller.barcodes.listen(
            (event) {
              analyzeBarcodes(event);
              sub.cancel();
            },
            onError: (_) {
              sub.cancel();
            },
          );
        }

        await controller.analyzeImage(image.path);
      }
    } else {
      inject<MessengerService>().show(
        Message.error(
          context: context,
          message: LocaleKeys.givePhotosPermission.tr(),
          actionText: LocaleKeys.giveWord.tr(),
          onAction: () => openSettings(SettingsOpenType.photos),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    controller.dispose();
    _lifecycleListener?.cancel();

    return super.close();
  }

  Future<void> _validateDataAndComplete(String? data) async {
    if (data == null) return;

    if (await _validate(data)) {
      emitSafe(QrCubitState.scanning(controller: controller, data: data));
    } else {
      inject<MessengerService>().show(
        Message.error(
          context: context,
          message: LocaleKeys.scannedDataIsNot.tr(
            args: [type.description.toLowerCase()],
          ),
        ),
      );
    }
  }

  Future<bool> _validate(String data) async {
    switch (type) {
      case QrScanType.address:
        return validateAddress(Address(address: data));
    }
  }
}
