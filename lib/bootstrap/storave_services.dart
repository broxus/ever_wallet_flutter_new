import 'package:app/app/service/storage_service/storage_manager_service.dart';
import 'package:app/di/di.dart';

/// Initialize storages and its streams
Future<void> configureStorageServices() =>
    inject<StorageManagerService>().init();
