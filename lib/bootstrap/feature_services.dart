import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/http/http.dart';
import 'package:logging/logging.dart';

/// This is a method that allows configure some feature-related services
Future<void> configureFeatureServices() async {
  final log = Logger('bootstrap')
    ..finest('CurrentSeedService initializating...');

  await inject<CurrentSeedService>().init();
  log
    ..finest('CurrentSeedService initialized')
    ..finest('CurrentAccountsService initializating...');

  await inject<CurrentAccountsService>().init();
  log
    ..finest('CurrentAccountsService initialized')
    ..finest('CurrenciesService initializating...');

  inject<CurrenciesService>().init();
  log
    ..finest('CurrenciesService initialized')
    ..finest('AssetsService initializating...');

  inject<AssetsService>().init();
  log
    ..finest('AssetsService initialized')
    ..finest('PermissionsService initializing...');

  inject<PermissionsService>().init();
  log
    ..finest('PermissionsService initialized')
    ..finest('StakingService initializing...');

  await inject<StakingService>().init();
  log
    ..finest('StakingService initialized')
    ..finest('TokenWalletsService initializing...');

  await inject<TokenWalletsService>().init();
  log.finest('TokenWalletsService initialized');

  inject<TokenRepository>().init();
}
