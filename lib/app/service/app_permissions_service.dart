import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

/// Service that is a wrapper above Permission package and allows requesting
/// permissions from platform.
@singleton
class AppPermissionsService {
  Future<bool> requestPermission(Permission permission) async {
    final isGranted = await permission.isGranted;
    if (!isGranted) {
      final isDenied = await permission.isDenied;
      if (isDenied) {
        return false;
      }

      return (await permission.request()).isGranted;
    } else {
      return true;
    }
  }

  Future<bool> requestCamera() => requestPermission(Permission.camera);

  Future<bool> requestPhotos() => requestPermission(Permission.photos);

  Future<void> openSettings() => openAppSettings();
}
