import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class AddAccountResultModel extends ElementaryModel {
  AddAccountResultModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currentKeyService,
    this._currentAccountsService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final CurrentKeyService _currentKeyService;
  final CurrentAccountsService _currentAccountsService;

  void changeCurrentAccount(Address address) {
    final account = _nekotonRepository.seedList.findAccountByAddress(address);

    if (account != null) {
      _currentAccountsService.updateCurrentActiveAccount(account.address);
      _currentKeyService.changeCurrentKey(account.publicKey);
    }
  }
}
