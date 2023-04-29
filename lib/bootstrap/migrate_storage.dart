import 'package:app/app/service/migration_service.dart';
import 'package:app/app/service/storage_service/account_seed_storage_service.dart';
import 'package:app/app/service/storage_service/browser_storage_service.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/di/di.dart';

/// Migrate storage from old version to new one
Future<void> migrateStorage() async {
  await MigrationService.migrateWithHiveInit(
    inject<GeneralStorageService>(),
    inject<BrowserStorageService>(),
    inject<AccountSeedStorageService>(),
  );
}
