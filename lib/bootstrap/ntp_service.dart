import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:logging/logging.dart';

/// NTP service which provides the correct time of the system clock with offset
Future<void> configureNtpService() async {
  final log = Logger('bootstrap')..finest('NtpService initializating...');
  await inject<NtpService>().init();
  log.finest('NtpService initialized');
}
