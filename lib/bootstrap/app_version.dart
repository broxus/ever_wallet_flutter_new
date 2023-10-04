import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:logging/logging.dart';

Future<void> configureAppVersion() async {
  final log = Logger('bootstrap')
    ..finest('AppVersionService initializating...');

  final service = inject<AppVersionService>();
  await service.init();

  log.finest('AppVersionService initialized');
}
