import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class SeedDetailPageModel extends ElementaryModel {
  SeedDetailPageModel(
    ErrorHandler errorHandler,
    this._currentSeedService,
    this._currentKeyService,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final CurrentSeedService _currentSeedService;
  final CurrentKeyService _currentKeyService;
  final NekotonRepository _nekotonRepository;

  Stream<Seed?> get currentSeed => _currentSeedService.currentSeedStream;

  Stream<PublicKey?> get currentKey => _currentKeyService.currentKeyStream;

  Stream<Set<String>> get findingExistingWallets =>
      _nekotonRepository.findingExistingWalletsStream;

  Stream<Seed?> getSeedStream(PublicKey publicKey) =>
      _nekotonRepository.seedListStream.map(
        (seedList) => seedList.findSeed(publicKey),
      );
}
