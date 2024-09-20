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

  Future<void> changeCurrentAccount(Address address) async {
    final account = _nekotonRepository.seedList.findAccountByAddress(address);

    if (account != null) {
      await _currentKeyService.changeCurrentKey(account.publicKey);
      await _currentAccountsService.changeCurrentActiveAccount(account);
    }
  }
}
