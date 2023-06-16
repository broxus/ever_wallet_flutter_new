import 'package:app/app/service/service.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Service that allows set/get/listen current key of application.
/// This service is initialized after [_storageService] is initialized.
@singleton
class CurrentKeyService {
  CurrentKeyService(
    this._storageService,
    this._nekotonRepository,
  );

  final GeneralStorageService _storageService;
  final NekotonRepository _nekotonRepository;

  /// Getter of last used key
  String? get currentKey => _storageService.currentKey;

  /// Stream of last used key
  Stream<String?> get currentKeyStream => _storageService.currentKeyStream;

  /// Getter of last viewed seed (only master keys)
  List<String> get lastViewedSeeds => _storageService.lastViewedSeeds;

  /// Stream of ast viewed seed (only master keys)
  Stream<List<String>> get lastViewedSeedsStream =>
      _storageService.lastViewedSeedsStream;

  /// Change current selected key and update [lastViewedSeeds].
  Future<void> changeCurrentKey(String publicKey) {
    final masterKey =
        _nekotonRepository.seedList.findSeedKey(publicKey)?.key.masterKey;
    final lastViewed = List<String>.from(lastViewedSeeds);
    if (masterKey != null) {
      lastViewed.insert(0, masterKey);
    }

    return Future.wait([
      _storageService.setCurrentKey(publicKey),
      _storageService.updateLastViewedSeeds(
        lastViewed.take(maxLastSelectedSeeds).toList(),
      ),
    ]);
  }
}
