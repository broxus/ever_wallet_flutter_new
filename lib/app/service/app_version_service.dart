import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

///Service that store info about app version
@singleton
class AppVersionService {
  /// TODO(knightforce) remove late
  late String appVersion;
  late String buildNumber;

  Future<void> init() async {
    final info = await PackageInfo.fromPlatform();
    appVersion = info.version;
    buildNumber = info.buildNumber;
  }
}
