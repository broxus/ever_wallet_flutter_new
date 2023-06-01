import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

Future<void> configureNekoton() async {
  final log = Logger('bootstrap')
    ..finest('NekotonRepository initializating...');

  final nekotonRepository = inject<NekotonRepository>();

  await nekotonRepository.setupNekotonAndStorage(
    storage: inject<NekotonStorageService>(),
  );
  log.finest('NekotonRepository initialized with storage');
}
