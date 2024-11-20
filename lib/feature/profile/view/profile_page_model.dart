import 'package:app/app/service/service.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class ProfilePageModel extends ElementaryModel {
  ProfilePageModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currentSeedService,
    this._biometryService,
    this._versionService,
    this._storageManagerService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final CurrentSeedService _currentSeedService;
  final BiometryService _biometryService;
  final AppVersionService _versionService;
  final StorageManagerService _storageManagerService;

  String get appVersion =>
      '${_versionService.appVersion}.${_versionService.buildNumber}';

  Stream<Seed?> get currentSeedStream => _currentSeedService.currentSeedStream;

  Stream<bool> get biometryAvailabilityStream =>
      _biometryService.availabilityStream;

  Stream<bool> get biometryEnabledStream => _biometryService.enabledStream;

  Future<void> logout() async {
    await _nekotonRepository.updateSubscriptions([]);
    await _nekotonRepository.updateTokenSubscriptions([]);
    await _storageManagerService.clearSensitiveData();
    await _nekotonRepository.keyStore.reloadKeystore();
  }

  Future<void> setBiometryEnabled({required bool enabled}) async {
    if (enabled && !await _biometryService.checkBiometryPermission()) return;

    await _biometryService.setStatus(
      localizedReason: LocaleKeys.biometryAuthReason.tr(),
      isEnabled: enabled,
    );
  }
}
