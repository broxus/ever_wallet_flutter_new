import 'package:app/bootstrap.dart';
import 'package:app/di/di.dart';
import 'package:fancy_logger/fancy_logger.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

Future<void> configureLogs(
  AppBuildType appBuildType,
) async {
  var level = Level.WARNING;

  /// This enables direct mobile logger (adb logcat / oslog)
  const mobileLogger = false;

  /// Log levels depending on build type
  switch (appBuildType) {
    case AppBuildType.development:
      level = Level.FINE;
      break;
    case AppBuildType.staging:
      level = Level.INFO;
      break;
    case AppBuildType.production:
      level = Level.WARNING;
      break;
  }
  await inject<FancyLogger>().init(level);
  await inject<NekotonRepository>().setupLogger(
    level: level,
    mobileLogger: mobileLogger,
  );
}
