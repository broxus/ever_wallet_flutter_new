import 'package:app/app/service/storage_service/storage_manager_service.dart';
import 'package:app/di/di.dart';
import 'package:logging/logging.dart';

/// Initialize storages and its streams
Future<void> configureStorageServices() async {
  final log = Logger('bootstrap')
    ..finest('StorageManagerService initializating...');
  await inject<StorageManagerService>().init();
  log.finest('StorageManagerService initialized');
}
