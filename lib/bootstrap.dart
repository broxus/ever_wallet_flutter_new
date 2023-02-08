import 'dart:async';

import 'package:app/di/di.dart';
import 'package:app/logs/logs.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

enum AppBuildType { development, staging, production }

class AppBlocObserver extends BlocObserver {
  final _log = Logger('AppBlocObserver');

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    _log.finest('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    _log.severe('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(
  FutureOr<Widget> Function() builder,
  AppBuildType appBuildType,
) async {
  await configureDi();
  await configureLogs(appBuildType);

  final log = Logger('bootstrap');

  FlutterError.onError = (details) {
    log.severe(details.exceptionAsString(), details, details.stack);
  };

  Bloc.observer = AppBlocObserver();

  await runZonedGuarded(
    () async => runApp(await builder()),
    (error, stackTrace) => log.severe(error.toString(), error, stackTrace),
  );
}
