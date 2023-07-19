import 'package:app/app/service/service.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

/// Support service that listen for seed list and current key and emits
/// current account list from current key and seed list.
///
/// This service triggers [TonWalletRepository.updateSubscriptions] when
/// accounts changes.
///
/// To avoid starting subscriptions during app launch, call [init] in the end
/// of bootstrap process.
@singleton
class CurrentAccountsService {
  CurrentAccountsService(
    this._nekotonRepository,
    this._currentKeyService,
  );

  final NekotonRepository _nekotonRepository;
  final CurrentKeyService _currentKeyService;

  final _currentAccountsSubject = BehaviorSubject<AccountList?>.seeded(null);

  /// Get stream of accounts in scope of current active key
  Stream<AccountList?> get currentAccountsStream => _currentAccountsSubject;

  /// Get accounts in scope of current active key
  AccountList? get currentAccounts => _currentAccountsSubject.valueOrNull;

  void init() {
    // skip 1 to avoid duplicate calls
    _nekotonRepository.seedListStream.skip(1).listen(
          (list) => _updateAccountsList(list, _currentKeyService.currentKey),
        );
    _currentKeyService.currentKeyStream.skip(1).listen(
          (key) => _updateAccountsList(_nekotonRepository.seedList, key),
        );

    _updateAccountsList(
      _nekotonRepository.seedList,
      _currentKeyService.currentKey,
    );
  }

  void _updateAccountsList(
    SeedList list,
    PublicKey? currentKey,
  ) {
    if (currentKey == null) {
      _currentAccountsSubject.add(null);

      return;
    }

    final key = list.findSeedKey(currentKey);
    if (key == null) {
      _currentAccountsSubject.add(null);

      return;
    }

    _currentAccountsSubject.add(key.accountList);
    _updateSubscriptions(key.accountList);
  }

  // TODO(alex-a4): decide how we will avoid multiple calls when user just
  //   switching between keys in profile
  Future<void> _updateSubscriptions(AccountList accountList) async {
    final accounts = accountList.displayAccounts.map((e) => e.account).toList();
    await _nekotonRepository
        .updateSubscriptions(accounts.map((e) => e.tonWallet).toList());
    await _nekotonRepository.updateTokenSubscriptions(accounts);
  }
}
