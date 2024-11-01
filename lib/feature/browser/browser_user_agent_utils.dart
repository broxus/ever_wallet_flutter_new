import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

Future<String> platformUserAgent = (() async =>
    Platform.isIOS ? await _iOSUserAgent : await _androidUserAgent)();

Future<String> get _androidUserAgent async {
  String? androidVersion;
  String? deviceModel;
  String? buildId;

  try {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    androidVersion = androidInfo.version.release;
    deviceModel = '; ${androidInfo.model}';
    buildId = ' Build/${androidInfo.id}';
  } catch (_) {
    androidVersion = '12';
  }

  return 'Mozilla/5.0 '
      '(Linux; '
      'Android $androidVersion$deviceModel$buildId) '
      'AppleWebKit/537.36 (KHTML, like Gecko) '
      'Chrome/117.0.0.0 Mobile Safari/537.36';
}

Future<String> get _iOSUserAgent async {
  String? iosVersion;
  String? deviceModel;

  try {
    final deviceInfo = DeviceInfoPlugin();
    final iosInfo = await deviceInfo.iosInfo;
    iosVersion = iosInfo.systemVersion;
    deviceModel = iosInfo.utsname.machine;
  } catch (_) {
    deviceModel = 'iPhone';
    iosVersion = '15_0';
  }

  return 'Mozilla/5.0 ($deviceModel; '
      'CPU iPhone OS $iosVersion like Mac OS X) '
      'AppleWebKit/605.1.15 (KHTML, like Gecko) '
      'Version/$iosVersion Mobile/15E148 Safari/604.1';
}
