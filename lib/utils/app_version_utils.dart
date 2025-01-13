import 'package:package_info_plus/package_info_plus.dart';

abstract class AppVersion {
  static PackageInfo? _info;

  static Future<String> get appVersion async {
    final info = _info ??= await PackageInfo.fromPlatform();
    return info.version;
  }

  static Future<String> get buildNumber async {
    final info = _info ??= await PackageInfo.fromPlatform();
    return info.buildNumber;
  }
}
