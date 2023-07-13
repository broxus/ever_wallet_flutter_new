import 'package:app/bootstrap.dart';
import 'package:app/di/di.dart';
import 'package:fancy_logger/fancy_logger.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:package_info_plus/package_info_plus.dart';

const _devLogsRetainSessionCount = 100;
const _prodLogsRetainSessionCount = 50;

Future<void> configureLogger(
  AppBuildType appBuildType,
) async {
  var retainStrategy = {Level.ALL: 100};

  /// This enables direct mobile logger (adb logcat / oslog)
  const mobileLogger = false;

  // /// Log levels depending on build type
  switch (appBuildType) {
    case AppBuildType.development:
      retainStrategy = {
        Level.ALL: _devLogsRetainSessionCount,
        Level.SEVERE: _devLogsRetainSessionCount,
      };
    case AppBuildType.staging:
      retainStrategy = {
        Level.ALL: _devLogsRetainSessionCount,
        Level.SEVERE: _devLogsRetainSessionCount,
      };
    case AppBuildType.production:
      retainStrategy = {
        Level.ALL: _prodLogsRetainSessionCount,
        Level.SEVERE: _prodLogsRetainSessionCount,
      };
  }

  WidgetsFlutterBinding.ensureInitialized();
  final packageInfo = await PackageInfo.fromPlatform();
  final packageInfoString =
      '[${packageInfo.version}:${packageInfo.buildNumber}]';

  final fancyLogger = inject<FancyLogger>();
  await fancyLogger.init(retainStrategy, sessionStartExtra: packageInfoString);

  await inject<NekotonRepository>().setupLogger(
    level: fancyLogger.minLevel,
    mobileLogger: mobileLogger,
  );
}

Future<void> startLogSession() async {
  await inject<FancyLogger>().startSession();
}
