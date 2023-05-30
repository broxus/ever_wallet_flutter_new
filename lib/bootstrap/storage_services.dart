import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:logging/logging.dart';

/// Initialize storages and its streams
Future<void> configureStorageServices() async {
  final log = Logger('bootstrap')
    ..finest('StorageManagerService initializating...');
  await inject<StorageManagerService>().init();
  log.finest('StorageManagerService initialized');
}
