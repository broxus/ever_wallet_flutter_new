import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

/// Service that is a wrapper above Permission package and allows requesting
/// permissions from platform.
@singleton
class AppPermissionsService {
  /// Returns true if user granted permissions, see [_isGoodStatus].
  /// Otherwise return false, meaning that we must show some message that
  /// permission was fully denied and ask user to visit settings.
  Future<bool> requestPermission(Permission permission) async {
    if (await shouldAskForSettings(permission)) {
      return false;
    }

    return _check(permission);
  }

  /// If permission was fully denied or not.
  /// For android we must additionally ask for requesting.
  /// Before next request, check result of this method. If this is false, then
  /// try asking for next request.
  Future<bool> _isDenied(Permission permission) async {
    var status = await permission.status;
    if (status == PermissionStatus.denied) {
      if (Platform.isAndroid) {
        status = await permission.request();
        if (status == PermissionStatus.permanentlyDenied) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  /// Request permission and return if it's granted
  Future<bool> _request(Permission permission) async {
    final status = await permission.request();
    return _isGoodStatus(status);
  }

  /// Check status of permission and return if it's granted
  Future<bool> _check(Permission permission) async {
    final status = await permission.status;
    return _isGoodStatus(status);
  }

  /// Returns true if we must show some dialog for user to ask him for
  /// permissions.
  Future<bool> shouldAskForSettings(Permission permission) async {
    final isPermissionDenied = await _isDenied(permission);
    final isGranted = Platform.isAndroid
        ? !isPermissionDenied && await _check(permission)
        : await _request(permission);
    final permanentlyDenied = await permission.isPermanentlyDenied;
    return !isPermissionDenied && !isGranted || permanentlyDenied;
  }

  bool _isGoodStatus(PermissionStatus status) =>
      status == PermissionStatus.granted ||
      status == PermissionStatus.limited ||
      status == PermissionStatus.restricted;

  Future<bool> requestCamera() => requestPermission(Permission.camera);

  Future<bool> requestPhotos() => requestPermission(Permission.photos);

  Future<void> openSettings() => openAppSettings();
}
