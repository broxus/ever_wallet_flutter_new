import 'package:app/app/service/service.dart';
import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/app_version_utils.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class ProfilePageModel extends ElementaryModel {
  ProfilePageModel(
    ErrorHandler errorHandler,
    this._browserService,
    this._nekotonRepository,
    this._currentSeedService,
    this._biometryService,
    this._storageManagerService,
  ) : super(errorHandler: errorHandler);

  final BrowserService _browserService;
  final NekotonRepository _nekotonRepository;
  final CurrentSeedService _currentSeedService;
  final BiometryService _biometryService;
  final StorageManagerService _storageManagerService;

  Future<String> get appVersion async {
    return '${await AppVersion.appVersion}.${await AppVersion.buildNumber}';
  }

  Stream<Seed?> get currentSeedStream => _currentSeedService.currentSeedStream;

  Stream<bool> get biometryAvailabilityStream =>
      _biometryService.availabilityStream;

  Stream<bool> get biometryEnabledStream => _biometryService.enabledStream;

  Future<void> logout() async {
    await _nekotonRepository.updateSubscriptions([]);
    await _nekotonRepository.updateTokenSubscriptions([]);
    await _storageManagerService.clearSensitiveData();
    await _nekotonRepository.keyStore.reloadKeystore();
    await _browserService.clear();
  }

  Future<void> setBiometryEnabled({required bool enabled}) async {
    if (enabled && !await _biometryService.checkBiometryPermission()) return;

    await _biometryService.setStatus(
      localizedReason: LocaleKeys.biometryAuthReason.tr(),
      isEnabled: enabled,
    );
  }
}
