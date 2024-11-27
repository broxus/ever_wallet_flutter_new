import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:logging/logging.dart';

/// Migrate storage from old version to new one
Future<void> migrateStorage() async {
  final log = Logger('bootstrap')..finest('MigrationService starting...');
  await MigrationService.migrateWithHiveInit(
    inject<GeneralStorageService>(),
    inject<SecureStorageService>(),
    inject<BrowserTabsStorageService>(),
    inject<BrowserHistoryStorageService>(),
    inject<BrowserBookmarksStorageService>(),
    inject<BrowserPermissionsStorageService>(),
    inject<NekotonStorageService>(),
    inject<ConnectionsStorageService>(),
  );
  log
    ..finest('MigrationService finished')
    ..finest('StorageMigrationService starting...');
  await StorageMigrationService.migrateToContainers(
    inject<EncryptedStorage>(),
  );
  log.finest('StorageMigrationService finished');
}
