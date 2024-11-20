import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class SelectSeedModel extends ElementaryModel {
  SelectSeedModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currentKeyService,
    this._currentSeedService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final CurrentKeyService _currentKeyService;
  final CurrentSeedService _currentSeedService;

  Stream<List<Seed>> get seedWithAccounts =>
      _nekotonRepository.seedListStream.map(
        (seedList) => seedList.seeds,
      );

  Stream<Seed?> get currentAccount => _currentSeedService.currentSeedStream;

  PublicKey? getCurrentKey() {
    return _currentKeyService.currentKey;
  }
}
