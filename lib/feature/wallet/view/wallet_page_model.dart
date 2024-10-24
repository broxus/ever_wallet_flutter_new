import 'package:app/app/service/secure_storage_service.dart';
import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class WalletPageModel extends ElementaryModel {
  WalletPageModel(
    ErrorHandler errorHandler,
    this._currentAccountsService,
    this._storageService,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final CurrentAccountsService _currentAccountsService;
  final SecureStorageService _storageService;
  final NekotonRepository _nekotonRepository;

  Stream<KeyAccount?> get currentAccount =>
      _currentAccountsService.currentActiveAccountStream;

  Future<bool?> isNewUser() async {
    return _storageService.getValue(StorageKey.userWithNewWallet());
  }

  Future<void> resetValueNewUser() async {
    return _storageService.cleanStorage(StorageKey.userWithNewWallet());
  }

  Future<bool?> isFirstEntering() async {
    return _storageService.getValue(StorageKey.firstEntering());
  }

  Future<void> updateFirstEntering() async {
    return _storageService.addValue(StorageKey.firstEntering(), false);
  }

  Future<bool?> isShowingBadge(KeyAccount account) async {
    final masterPublicKey = _nekotonRepository.seedList
        .findSeedByAnyPublicKey(account.publicKey)
        ?.masterPublicKey;

    if (masterPublicKey == null) return null;

    return _storageService.getValue(
      StorageKey.showingManualBackupBadge(masterPublicKey.publicKey),
    );
  }

  Future<void> hideShowingBadge(KeyAccount account) async {
    final masterPublicKey = _nekotonRepository.seedList
        .findSeedByAnyPublicKey(account.publicKey)
        ?.masterPublicKey;

    if (masterPublicKey == null) return;

    return _storageService.addValue(
      StorageKey.showingManualBackupBadge(masterPublicKey.publicKey),
      false,
    );
  }
}
