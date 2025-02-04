import 'package:app/app/service/storage_service/balance_storage_service.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/storage_migration.dart';
import 'package:get_storage/get_storage.dart';

class StorageMigrationV2 implements StorageMigration {
  static const int version = 2;

  @override
  Future<void> apply() async {
    for (final container in BalanceStorageService.containers) {
      await GetStorage.init(container);
      await GetStorage(container).erase();
    }
  }

  @override
  Future<void> complete() async {}
}
