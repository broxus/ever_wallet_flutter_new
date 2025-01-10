import 'package:app/app/service/service.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// This is a wrapper-class above [EncryptedStorage] that provides methods
/// to interact account/seed/public keys.
@singleton
class NekotonStorageService extends NekotonStorageRepository
    implements AbstractStorageService {
  NekotonStorageService(super.storage);

  @override
  Future<void> clear() async {
    try {
      return await clearSensitiveData();
    } catch (_) {}
  }
}
