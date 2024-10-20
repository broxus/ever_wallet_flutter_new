import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:logging/logging.dart';

/// Migrate storage from old version to new one
Future<void> migrateStorage() async {
  final log = Logger('bootstrap')..finest('MigrationService starting...');
  await MigrationService.migrateWithHiveInit(
    inject<GeneralStorageService>(),
    inject<BrowserTabsStorageService>(),
    inject<BrowserHistoryStorageService>(),
    inject<BrowserBookmarksStorageService>(),
    inject<BrowserPermissionsStorageService>(),
    inject<NekotonStorageService>(),
    inject<ConnectionsStorageService>(),
  );
  log.finest('MigrationService finished');
}
