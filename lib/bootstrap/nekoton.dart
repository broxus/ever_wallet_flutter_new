import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/di/di.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

Future<void> configureNekoton() async {
  final log = Logger('bootstrap')
    ..finest('NekotonRepository initializating...');

  final nekotonRepository = inject<NekotonRepository>();

  final storage = inject<GeneralStorageService>();
  await nekotonRepository.setupNekoton(
    get: storage.getStorageData,
    set: storage.setStorageData,
    setUnchecked: storage.setStorageData,
    remove: storage.removeStorageData,
    removeUnchecked: storage.removeStorageData,
  );
  log.finest('NekotonRepository initialized with storage hooks');
}
