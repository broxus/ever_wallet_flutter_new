import 'package:app/app/service/crash_detector/widget/crash_detector_service_widget.dart';
import 'package:app/app/service/localization/widget/localization_service_widget.dart';
import 'package:app/app/service/messenger/widget/messenger_service_widget.dart';
import 'package:app/app/service/navigation/widget/navigation_service_widget.dart';
import 'package:app/app/view/app_wm.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class App extends ElementaryWidget<AppWidgetModel> {
  const App({
    Key? key,
    WidgetModelFactory<AppWidgetModel> wmFactory = defaultAppWidgetModelFactory,
  }) : super(
          wmFactory,
          key: key,
        );

  @override
  Widget build(AppWidgetModel wm) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: wm.router,
      localizationsDelegates: wm.localizationDelegates,
      supportedLocales: wm.supportedLocales,
      locale: wm.locale,
      theme: getPredefinedLightTheme(),
      darkTheme: getPredefinedDarkTheme(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.noScaling,
        ),
        child: AppRootWidgets(
          child: child ?? Container(),
        ),
      ),
    );
  }
}

/// Widget that should be placed at the root of the app
/// This is a good place to put services that should be available
/// throughout the app
class AppRootWidgets extends StatelessWidget {
  const AppRootWidgets({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InAppNotification(
      child: CrashDetectorServiceWidget(
        child: LocalizationServiceWidget(
          child: MessengerServiceWidget(
            child: NavigationServiceWidget(child: child),
          ),
        ),
      ),
    );
  }
}
