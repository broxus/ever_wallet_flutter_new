import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:logging/logging.dart';

Future<void> configureNavigationService() async {
  final log = Logger('bootstrap')
    ..finest('NavigationService initializating...');
  final navigationService = inject<NavigationService>();
  await navigationService.init(AppRoute.defaultRoute.path);
  log.finest('NavigationService initialized');
}
