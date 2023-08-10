import 'package:app/app/service/service.dart';
import 'package:injectable/injectable.dart';

/// Service that allows init or clear data of all storages from single point
@singleton
class StorageManagerService {
  StorageManagerService(
    GeneralStorageService general,
    BrowserStorageService browser,
    BrowserTabsStorageService browserTabs,
    BrowserHistoryStorageService browserHistory,
    BrowserBookmarksStorageService browserBookmarks,
    NekotonStorageService accountSeed,
    NekotonRepositoryStorageService nekotonRepositoryStorageService,
    TonWalletStorageService tonWalletStorageService,
    TokenWalletStorageService tokenWalletStorageService,
  ) : _storages = [
          general,
          browser,
          browserTabs,
          browserHistory,
          browserBookmarks,
          accountSeed,
          nekotonRepositoryStorageService,
          tonWalletStorageService,
          tokenWalletStorageService,
        ];

  final List<AbstractStorageService> _storages;

  /// Init all user-data.
  /// This let you call read methods to init stream data.
  Future<void> init() => Future.wait(_storages.map((e) => e.init()));

  /// Remove from storage all data that can be linked to user.
  Future<void> clearSensitiveData() =>
      Future.wait(_storages.map((e) => e.clearSensitiveData()));
}
