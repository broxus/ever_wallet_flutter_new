import 'package:app/app/service/service.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:rxdart/rxdart.dart';

class BiometryNotAuthException implements Exception {}

class BiometryPasswordNotStoredException implements Exception {}

/// Service that helps reading/updating biometry settings.
@singleton
class BiometryService {
  BiometryService(this.storage, this.appLifecycleService);

  final GeneralStorageService storage;
  final AppLifecycleService appLifecycleService;

  final _localAuth = LocalAuthentication();
  final _availabilitySubject = BehaviorSubject<bool>.seeded(false);

  /// Stream of availability biometry in app
  Stream<bool> get availabilityStream => _availabilitySubject;

  /// If biometry available in app
  bool get available => _availabilitySubject.value;

  /// Stream of biometry enabled status
  Stream<bool> get enabledStream => storage.isBiometryEnabledStream;

  /// If biometry enabled
  bool get enabled => storage.isBiometryEnabled;

  /// Init biometry settings and subscriptions
  Future<void> init() async {
    _availabilitySubject.add(await _isAvailable);

    /// Update availability status on app state change
    appLifecycleService.appLifecycleStateStream
        .asyncMap((_) => _isAvailable)
        .listen(_availabilitySubject.add);

    // disable biometry if it is not available
    availabilityStream
        .where((e) => !e)
        .listen((e) => storage.setIsBiometryEnabled(isEnabled: e));

    // clear all passwords if biometry was disabled
    enabledStream.where((e) => !e).listen((e) => storage.clearKeyPasswords());
  }

  /// Update status of enabled biometry.
  /// [localizedReason] is a message that will be shown to user with biometry
  ///   dialog.
  Future<void> setStatus({
    required String localizedReason,
    required bool isEnabled,
  }) async {
    // if user want disable biometry - do it.
    // if user want enable biometry - ask auth.
    if (!isEnabled || isEnabled && await _authenticate(localizedReason)) {
      await storage.setIsBiometryEnabled(isEnabled: isEnabled);
    }
  }

  /// Save password of [publicKey] to storage if biometry is enabled
  Future<void> setKeyPassword({
    required String publicKey,
    required String password,
  }) =>
      storage.setKeyPassword(
        publicKey: publicKey,
        password: password,
      );

  /// Get password of [publicKey] if it was stored before or throw exception.
  /// [localizedReason] is a message that will be shown to user with biometry
  ///   dialog.
  Future<String> getKeyPassword({
    required String localizedReason,
    required String publicKey,
  }) async {
    final password = await storage.getKeyPassword(publicKey);

    if (password != null) {
      if (await _authenticate(localizedReason)) {
        return password;
      } else {
        throw BiometryNotAuthException();
      }
    } else {
      throw BiometryPasswordNotStoredException();
    }
  }

  /// Try to authenticate user with biometry or throw exception.
  Future<bool> _authenticate(String localizedReason) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: localizedReason,
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (_) {
      _availabilitySubject.add(await _isAvailable);
      rethrow;
    }
  }

  /// Check if biometry available on device
  Future<bool> get _isAvailable async {
    if (!await _localAuth.canCheckBiometrics) return false;
    if (!await _localAuth.isDeviceSupported()) return false;
    if ((await _localAuth.getAvailableBiometrics()).isEmpty) {
      return false;
    }

    return true;
  }
}