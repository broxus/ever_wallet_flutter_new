import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class SelectAccountModel extends ElementaryModel {
  SelectAccountModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currentKeyService,
    this._currentAccountsService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final CurrentKeyService _currentKeyService;
  final CurrentAccountsService _currentAccountsService;

  Stream<List<KeyAccount>> get accounts =>
      _nekotonRepository.seedListStream.map(
        (seedList) => seedList.seeds
            .expand(
              (seed) => seed.allKeys.expand(
                (key) => key.accountList.allAccounts,
              ),
            )
            .where((account) => !account.isHidden)
            .toList(),
      );

  Stream<KeyAccount?> get currentAccount =>
      _currentAccountsService.currentActiveAccountStream.map(
        (value) => value?.$2,
      );

  Future<void> changeCurrentAccount(KeyAccount account) async {
    await _currentKeyService.changeCurrentKey(account.publicKey);
    _currentAccountsService.changeCurrentActiveAccount(account);
  }
}
