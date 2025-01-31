import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/app/view/app.dart';
import 'package:app/bootstrap/localization.dart';
import 'package:app/bootstrap/logger.dart';
import 'package:app/bootstrap/sentry.dart';
import 'package:app/core/app_build_type.dart';
import 'package:app/core/bloc/app_bloc_observer.dart';
import 'package:app/di/di.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

late AppBuildType currentAppBuildType;

Future<void> run(
  AppBuildType appBuildType,
) async {
  currentAppBuildType = appBuildType;

  Logger? log;

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await NekotonBridge.init();

      await configureDi();

      await configureLogger(appBuildType);

      log = Logger('bootstrap');

      await configureLocalization();

      await SentryWorker.instance.init(appBuildType);

      FlutterError.onError = (details) {
        log?.severe(details.exceptionAsString(), details, details.stack);
        SentryWorker.instance.captureException(
          details.exception,
          stackTrace: details.stack,
        );
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        log?.severe(null, error, stack);
        SentryWorker.instance.captureException(error, stackTrace: stack);
        return true;
      };

      Bloc.observer = AppBlocObserver();

      DefaultAppBar.defaultPopAction =
          (context) => context.maybePop(preserveQueryParams: false);
      DefaultAppBar.defaultCanPopAction = (context) => context.canPop();

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      runApp(const App());
    },
    (error, stackTrace) async {
      log?.severe(error.toString(), error, stackTrace);
      if (log == null) {
        debugPrint('bootstrap error: $error');
        debugPrintStack(stackTrace: stackTrace, label: 'bootstrap stackTrace:');
      }
      SentryWorker.instance.captureException(error, stackTrace: stackTrace);
    },
  );
}
