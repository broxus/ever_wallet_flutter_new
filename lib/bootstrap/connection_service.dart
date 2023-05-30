import 'package:app/app/service/nekoton_related/connection_service/connection_service.dart';
import 'package:app/di/di.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

Future<void> configureConnectionService() async {
  final log = Logger('bootstrap')
    ..finest('ConnectionService initializating...');
  final service = inject<ConnectionService>();
  await service.setUp();

  log.finest('NekotonRepository start SeedList listening');
  inject<NekotonRepository>().setupSeedListUpdating();
}
