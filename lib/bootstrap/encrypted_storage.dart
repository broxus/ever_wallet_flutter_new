import 'package:app/di/di.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:logging/logging.dart';

Future<void> configureEncryptedStorage() async {
  final log = Logger('bootstrap')..finest('EncryptedStorage initializating...');
  final encryptedStorage = inject<EncryptedStorage>();
  await encryptedStorage.init();
  log.finest('EncryptedStorage initialized');
}
