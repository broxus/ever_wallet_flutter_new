import 'package:app/di/di.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

Future<void> configureNekoton() async {
  final nekotonRepository = inject<NekotonRepository>();
  await nekotonRepository.setupStorage(storage: inject<EncryptedStorage>());
}
