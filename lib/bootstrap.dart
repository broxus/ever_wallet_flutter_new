import 'dart:async';

import 'package:app/app/router/app_route.dart';
import 'package:app/bootstrap/bootstrap.dart';
import 'package:app/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

enum AppBuildType { development, staging, production }

class AppBlocObserver extends BlocObserver {
  final _log = Logger('AppBlocObserver');

  // TODO(nesquikm): Maybe this this is a good point to debug something bad?
  // @override
  // void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
  //   super.onChange(bloc, change);
  //   _log.fine('onChange(${bloc.runtimeType}, $change)');
  // }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    _log.severe('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(
  Widget Function() builder,
  AppBuildType appBuildType,
) async {
  final log = Logger('bootstrap');

  await runZonedGuarded(
    () async {
      await configureDi();
      await configureLogger(appBuildType);

      await configureEncryptedStorage();
      await configureNavigationService();
      await migrateStorage();
      await configureStorageServices();
      // SetUp nekoton after storage migrations
      await configureNekoton();
      await configureConnectionService();

      FlutterError.onError = (details) {
        log.severe(details.exceptionAsString(), details, details.stack);
      };

      Bloc.observer = AppBlocObserver();

      DefaultAppBar.defaultPopAction = (context) => context.maybePop();
      DefaultAppBar.defaultCanPopAction = (context) => context.canPop();

      WidgetsFlutterBinding.ensureInitialized();
      // easy_localization claims that this is needed
      await EasyLocalization.ensureInitialized();

      runApp(
        EasyLocalization(
          supportedLocales: const [
            Locale('en', 'US'),
          ],
          path: 'assets/translations',
          fallbackLocale: const Locale('en', 'US'),
          child: AppWrapper(
            builder: builder,
          ),
        ),
      );
    },
    (error, stackTrace) => log.severe(error.toString(), error, stackTrace),
  );
}

class AppWrapper extends StatefulWidget {
  const AppWrapper({required this.builder, super.key});

  final Widget Function() builder;

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) startLogSession();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder();
  }
}
