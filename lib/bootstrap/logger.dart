import 'package:app/bootstrap.dart';
import 'package:app/di/di.dart';
import 'package:fancy_logger/fancy_logger.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

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

  final fancyLogger = inject<FancyLogger>();
  await fancyLogger.init(retainStrategy);
  await inject<NekotonRepository>().setupLogger(
    level: fancyLogger.minLevel,
    mobileLogger: mobileLogger,
  );
}

Future<void> startLogSession() async {
  await inject<FancyLogger>().startSession();
}
