import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Service that allows set/get/listen current key of application.
/// This service is initialized after [_storageService] is initialized.
@singleton
class CurrentKeyService {
  CurrentKeyService(this._storageService);

  final GeneralStorageService _storageService;

  /// Getter of last used key
  String? get currentKey => _storageService.currentKey;

  /// Stream of last used key
  Stream<String?> get currentKeyStream => _storageService.currentKeyStream;

  /// Getter of last viewed keys
  List<String> get lastViewedKeys => _storageService.lastViewedKeys;

  /// Stream of last viewed keys
  Stream<List<String>> get lastViewedKeysStream =>
      _storageService.lastViewedKeysStream;

  /// Change current selected key and update [lastViewedKeys].
  Future<void> changeCurrentKey(String publicKey) {
    final lastViewed = List<String>.from(lastViewedKeys)..insert(0, publicKey);
    return Future.wait([
      _storageService.setCurrentKey(publicKey),
      _storageService.updateLastViewedKeys(
        lastViewed.take(maxLastSelectedSeeds).toList(),
      ),
    ]);
  }
}
