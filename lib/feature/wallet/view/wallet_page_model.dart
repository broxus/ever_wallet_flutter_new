import 'package:app/app/service/secure_storage_service.dart';
import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class WalletPageModel extends ElementaryModel {
  WalletPageModel(
    ErrorHandler errorHandler,
    this._currentAccountsService,
    this._storageService,
  ) : super(errorHandler: errorHandler);

  final CurrentAccountsService _currentAccountsService;
  final SecureStorageService _storageService;

  Stream<KeyAccount?> get currentAccount =>
      _currentAccountsService.currentActiveAccountStream.map(
        (value) => value?.$2,
      );

  Future<bool?> isNewUser() async {
    return _storageService.getFromStorage(StorageConstants.userWithNewWallet);
  }

  Future<void> resetValueNewUser() async {
    return _storageService.cleanStorage(
      StorageConstants.userWithNewWallet,
    );
  }

  Future<bool?> isShowingBadge(String address) async {
    return _storageService
        .getFromStorage(address + StorageConstants.showingManualBackupBadge);
  }

  Future<void> hideShowingBadge(String address) async {
    return _storageService.addToStorage(
      address + StorageConstants.showingManualBackupBadge,
      false,
    );
  }
}
