import 'package:app/app/service/service.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// This is a wrapper-class above [NekotonRepository] that provides methods
/// to interact with NekotonRepository.
@singleton
class NekotonRepositoryStorageService extends AbstractStorageService {
  NekotonRepositoryStorageService(this._nekotonRepository);

  final NekotonRepository _nekotonRepository;

  @override
  Future<void> clear() async {
    await _nekotonRepository.clear();
  }

  @override
  // ignore: no-empty-block
  Future<void> init() async {}
}
