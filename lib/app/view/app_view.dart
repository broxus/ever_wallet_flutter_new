import 'package:app/app/router/router.dart';
import 'package:app/app/view/app_root_widgets.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = getRouter(context);
  }

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: everPredefinedLightTheme(),
      darkTheme: everPredefinedDarkTheme(),
      builder: (context, child) => AppRootWidgets(child: child ?? Container()),
    );
  }
}
