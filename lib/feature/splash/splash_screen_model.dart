import 'package:app/app/service/bootstrap_service.dart';
import 'package:app/app/service/navigation/service/navigation_service.dart';
import 'package:app/app/service/network_connection/network_connection_service.dart';
import 'package:app/feature/splash/splash_screen.dart';
import 'package:app/runner.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [SplashScreen]
class SplashScreenModel extends ElementaryModel {
  SplashScreenModel(
    ErrorHandler errorHandler,
    this._bootstrapService,
    this._navigationService,
    this._networkConnectionService,
  ) : super(errorHandler: errorHandler);

  final BootstrapService _bootstrapService;
  final NavigationService _navigationService;
  final NetworkConnectionService _networkConnectionService;

  String get savedLocation => _navigationService.savedState.location;

  Future<bool> get isExistInternet => _networkConnectionService.isExistInternet;

  Future<void> configure() async {
    await _bootstrapService.init(currentAppBuildType);
  }
}
