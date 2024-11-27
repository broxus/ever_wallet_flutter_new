import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class SwitchToSeedModel extends ElementaryModel {
  SwitchToSeedModel(
    ErrorHandler errorHandler,
    this._currentKeyService,
  ) : super(errorHandler: errorHandler);

  final CurrentKeyService _currentKeyService;

  Future<void> changeCurrentAccount(PublicKey publicKey) async {
    _currentKeyService.changeCurrentKey(publicKey);
  }
}
