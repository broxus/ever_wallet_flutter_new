import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:logging/logging.dart';

/// Initialize storages and its streams
Future<void> configureNtpService() async {
  final log = Logger('bootstrap')..finest('NtpService initializating...');
  await inject<NtpService>().init();
  log.finest('NtpService initialized');
}
