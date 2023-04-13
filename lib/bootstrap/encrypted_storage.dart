import 'package:app/di/di.dart';
import 'package:encrypted_storage/encrypted_storage.dart';

Future<void> configureEncryptedStorage() async {
  final encryptedStorage = inject<EncryptedStorage>();
  await encryptedStorage.init();
}
