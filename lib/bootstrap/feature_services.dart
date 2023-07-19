import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';

import 'package:logging/logging.dart';

/// This is a method that allows configure some feature-related services
Future<void> configureFeatureServices() async {
  final log = Logger('bootstrap')
    ..finest('CurrentSeedService initializating...');

  await inject<CurrentSeedService>().init();
  log
    ..finest('CurrentSeedService initialized')
    ..finest('CurrentAccountsService initializating...');

  inject<CurrentAccountsService>().init();
  log.finest('CurrentAccountsService initialized');
}
