import 'package:app/app/service/service.dart';
import 'package:app/app/service/session/session_service.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/app_version_utils.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class ProfilePageModel extends ElementaryModel {
  ProfilePageModel(
    ErrorHandler errorHandler,
    this._currentSeedService,
    this._biometryService,
    this._sessionService,
  ) : super(errorHandler: errorHandler);

  final CurrentSeedService _currentSeedService;
  final BiometryService _biometryService;
  final SessionService _sessionService;

  Future<String> get appVersion async {
    return '${await AppVersion.appVersion}.${await AppVersion.buildNumber}';
  }

  Stream<Seed?> get currentSeedStream => _currentSeedService.currentSeedStream;

  Stream<bool> get biometryAvailabilityStream =>
      _biometryService.availabilityStream;

  Stream<bool> get biometryEnabledStream => _biometryService.enabledStream;

  Future<void> logout() async {
    await _sessionService.clear();
  }

  Future<void> setBiometryEnabled({required bool enabled}) async {
    if (enabled && !await _biometryService.checkBiometryPermission()) return;

    await _biometryService.setStatus(
      localizedReason: LocaleKeys.biometryAuthReason.tr(),
      isEnabled: enabled,
    );
  }
}
