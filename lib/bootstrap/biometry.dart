import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:logging/logging.dart';

Future<void> configureBiometry() async {
  final log = Logger('bootstrap')..finest('BiometryService initializating...');

  final service = inject<BiometryService>();
  await service.init();

  log.finest('BiometryService initialized');
}
