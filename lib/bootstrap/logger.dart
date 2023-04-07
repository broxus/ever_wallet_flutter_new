import 'package:app/bootstrap.dart';
import 'package:app/di/di.dart';
import 'package:fancy_logger/fancy_logger.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

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
        Level.ALL: 100,
        Level.SEVERE: 100,
      };
      break;
    case AppBuildType.staging:
      retainStrategy = {
        Level.ALL: 100,
        Level.SEVERE: 100,
      };
      break;
    case AppBuildType.production:
      retainStrategy = {
        Level.CONFIG: 50,
        Level.SEVERE: 50,
      };
      break;
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
