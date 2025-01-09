import 'package:app/core/app_build_type.dart';
import 'package:app/di/di.dart';
import 'package:app/utils/app_version_utils.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:the_logger/the_logger.dart';

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

  final packageInfoString =
      '[${await AppVersion.appVersion}:${await AppVersion.buildNumber}]';

  final logger = TheLogger.i();
  await logger.init(
    retainStrategy: retainStrategy,
    sessionStartExtra: packageInfoString,
  );

  await inject<NekotonRepository>().setupLogger(
    level: logger.minLevel,
    mobileLogger: mobileLogger,
  );
}

Future<void> startLogSession() async {
  try {
    await TheLogger.i().startSession();
  } catch (_) {}
}
