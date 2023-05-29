import 'package:app/app/service/migration_service.dart';
import 'package:app/app/service/storage_service/account_seed_storage_service.dart';
import 'package:app/app/service/storage_service/browser_storage_service.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/di/di.dart';
import 'package:logging/logging.dart';

/// Migrate storage from old version to new one
Future<void> migrateStorage() async {
  final log = Logger('bootstrap')..finest('MigrationService starting...');
  await MigrationService.migrateWithHiveInit(
    inject<GeneralStorageService>(),
    inject<BrowserStorageService>(),
    inject<NekotonStorageService>(),
  );
  log.finest('MigrationService finished');
}
