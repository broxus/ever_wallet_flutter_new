import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/di/di.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

Future<void> configureNekoton() async {
  final nekotonRepository = inject<NekotonRepository>();
  await nekotonRepository.setupStorage(storage: inject<EncryptedStorage>());

  final storage = inject<GeneralStorageService>();
  await nekotonRepository.setupNekoton(
    get: storage.getStorageData,
    set: storage.setStorageData,
    setUnchecked: storage.setStorageData,
    remove: storage.removeStorageData,
    removeUnchecked: storage.removeStorageData,
  );
}
