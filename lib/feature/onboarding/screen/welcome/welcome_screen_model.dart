import 'package:app/app/service/secure_storage_service.dart';
import 'package:app/feature/onboarding/screen/welcome/welcome_screen.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [WelcomeScreen]
class WelcomeScreenModel extends ElementaryModel {
  WelcomeScreenModel(
    ErrorHandler errorHandler,
    this._storageService,
  ) : super(errorHandler: errorHandler);

  final SecureStorageService _storageService;

  Future<void> saveUserNew({required bool userWithNewWallet}) => _storageService
      .addValue(StorageKey.userWithNewWallet(), userWithNewWallet);

  Future<void> setFirstEntering() =>
      _storageService.addValue(StorageKey.firstEntering(), true);
}
