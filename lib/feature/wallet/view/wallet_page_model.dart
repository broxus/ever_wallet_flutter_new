import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class WalletPageModel extends ElementaryModel {
  WalletPageModel(
    ErrorHandler errorHandler,
    this._currentAccountsService,
  ) : super(errorHandler: errorHandler);

  final CurrentAccountsService _currentAccountsService;

  Stream<KeyAccount?> get currentAccount =>
      _currentAccountsService.currentActiveAccountStream.map(
        (value) => value?.$2,
      );
}
