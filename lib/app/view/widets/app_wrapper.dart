import 'package:app/app/router/app_route.dart';
import 'package:app/app/service/app_lifecycle_service.dart';
import 'package:app/app/service/biometry_service.dart';
import 'package:app/app/service/localization/service/localization_service.dart';
import 'package:app/app/service/navigation/service/navigation_service.dart';
import 'package:app/bootstrap/bootstrap.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';

class AppWrapper extends StatefulWidget {
  const AppWrapper({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> with WidgetsBindingObserver {
  late final AppLifecycleListener _listener;

  // TODO(knightforce): refactor to DI
  late final _appLifecycleService = inject<AppLifecycleService>();

  // TODO(knightforce): refactor to DI
  late final _localizationService = inject<LocalizationService>();

  // TODO(knightforce): refactor to DI
  late final _biometryService = inject<BiometryService>();

  // TODO(knightforce): refactor to DI
  late final _navigationService = inject<NavigationService>();

  @override
  void initState() {
    super.initState();

    _listener = AppLifecycleListener(
      onStateChange: _onStateChanged,
    );

    appStartSession(setCrashDetected: true);
    // put it here so system faceid check window will appear after splashscreen
    _checkBiometry();
  }

  @override
  void dispose() {
    _listener.dispose();

    super.dispose();
  }

  void _onStateChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        startLogSession();
        appStartSession(setCrashDetected: false);
      case AppLifecycleState.inactive:
        appStopSession();
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        break;
    }

    _appLifecycleService.updateState(state);
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);

    _localizationService.refreshLocale();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future<void> _checkBiometry() async {
    final location = _navigationService.savedState.location;
    final canUpdateStatus = await _biometryService.canUpdateStatus();

    if (canUpdateStatus && location == AppRoute.profile.path) {
      await _biometryService.setStatus(
        localizedReason: LocaleKeys.biometryAuthReason.tr(),
        isEnabled: true,
      );
    }
  }
}
