import 'package:app/app/router/router.dart';
import 'package:app/app/service/app_lifecycle_service.dart';
import 'package:app/app/service/biometry_service.dart';
import 'package:app/app/service/bootstrap/bootstrap_service.dart';
import 'package:app/app/service/localization/service/localization_service.dart';
import 'package:app/app/service/navigation/service/navigation_service.dart';
import 'package:app/app/view/app.dart';
import 'package:app/bootstrap/bootstrap.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [ElementaryModel] for [App]
class AppModel extends ElementaryModel with WidgetsBindingObserver {
  AppModel(
    ErrorHandler errorHandler,
    this._bootstrapService,
    this._navigationService,
    this._nekotonRepository,
    this._appLifecycleService,
    this._localizationService,
    this._biometryService,
  ) : super(errorHandler: errorHandler);

  final BootstrapService _bootstrapService;
  final NavigationService _navigationService;
  final NekotonRepository _nekotonRepository;
  final AppLifecycleService _appLifecycleService;
  final LocalizationService _localizationService;
  final BiometryService _biometryService;

  late final appRouter = AppRouter(
    _bootstrapService,
    _navigationService,
    _nekotonRepository,
  );

  AppLifecycleListener? _listener;

  @override
  void init() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _listener = AppLifecycleListener(
        onStateChange: _onStateChanged,
      );
    });
    appStartSession(setCrashDetected: true);
    _checkBiometry();
    super.init();
  }

  @override
  void dispose() {
    appRouter.dispose();
    _listener?.dispose();
    super.dispose();
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    super.didChangeLocales(locales);

    _localizationService.refreshLocale();
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

  Future<void> _checkBiometry() async {
    final location = _navigationService.state.location;
    final canUpdateStatus = await _biometryService.canUpdateStatus();

    if (canUpdateStatus && location == AppRoute.profile.path) {
      await _biometryService.setStatus(
        localizedReason: LocaleKeys.biometryAuthReason.tr(),
        isEnabled: true,
      );
    }
  }
}
