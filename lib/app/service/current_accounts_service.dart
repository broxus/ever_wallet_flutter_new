import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:collection/collection.dart';
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

  final _currentActiveAccountSubject =
      BehaviorSubject<(int, KeyAccount?)>.seeded((-1, null));

  /// Get stream of accounts in scope of current active key
  Stream<AccountList?> get currentAccountsStream => _currentAccountsSubject;

  /// Get accounts in scope of current active key
  AccountList? get currentAccounts => _currentAccountsSubject.valueOrNull;

  /// Get stream of current active account in wallet tab.
  /// This will automatically changes when [currentAccountsStream] emits new
  /// accounts for another key.
  /// 1-st value of record - is index from [currentAccounts], if account is
  /// null, then -1
  ///
  /// Changes in this stream can also sign you that [currentAccountsStream]
  /// could provide a new value.
  ///
  /// You can affect for this stream, calling [updateCurrentActiveAccount]
  Stream<(int, KeyAccount?)?> get currentActiveAccountStream =>
      _currentActiveAccountSubject;

  /// Get current active account in wallet tab.
  /// This will automatically changes when [currentAccountsStream] emits new
  /// accounts for another key.
  /// 1-st value of record - is index from [currentAccounts], if account is
  /// null, then -1
  ///
  /// You can affect for this value, calling [updateCurrentActiveAccount]
  (int, KeyAccount?)? get currentActiveAccount =>
      _currentActiveAccountSubject.valueOrNull;

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

  /// Try updating current active account for [currentAccounts], this will try
  /// to take account for [AccountList.displayAccounts] by index and emit
  /// it in [currentActiveAccountStream].
  ///
  /// If user switched to tab `Add new account`, then index will > -1 and
  /// account will be null.
  void updateCurrentActiveAccount(int index) {
    final accounts = currentAccounts?.displayAccounts;
    if (accounts == null) {
      _currentActiveAccountSubject.add((-1, null));
      _nekotonRepository
        ..stopPolling()
        ..stopPollingToken();

      return;
    }

    final current =
        index >= 0 && index < accounts.length ? accounts[index] : null;

    if (current != null) {
      _tryStartPolling(current.address);
    } else {
      // add new account tab selected
      _tonWalletSubscription?.cancel();
      _tokenWalletSubscription?.cancel();

      _nekotonRepository
        ..stopPolling()
        ..stopPollingToken();
    }

    _currentActiveAccountSubject.add((index, current));
  }

  /// Try updating current active account for [currentAccounts]
  void changeCurrentActiveAccount(KeyAccount account) {
    if (currentActiveAccount?.$2 == account) return;

    final index = currentAccounts?.displayAccounts.indexOf(account);

    if (index != null && index != -1) {
      _tryStartPolling(account.address);
      _currentActiveAccountSubject.add((index, account));
    }
  }

  /// Subscriptions for listening Ton/Token wallets to start its polling when
  /// their account is selected in [currentActiveAccount].
  StreamSubscription<dynamic>? _tonWalletSubscription;
  StreamSubscription<dynamic>? _tokenWalletSubscription;

  /// Start listening for wallet subscriptions and when subscription will be
  /// created, start polling.
  void _tryStartPolling(Address address) {
    _tonWalletSubscription?.cancel();
    _tokenWalletSubscription?.cancel();
    _nekotonRepository
      ..stopPolling()
      ..stopPollingToken();

    _tonWalletSubscription = _nekotonRepository.walletsStream.listen((wallets) {
      if (wallets.map((e) => e.address).contains(address)) {
        _nekotonRepository.startPolling(address);
        _tonWalletSubscription?.cancel();
      }
    });

    _tokenWalletSubscription =
        _nekotonRepository.tokenWalletsStream.listen((wallets) {
      wallets.where((w) => w.owner == address).forEach((w) {
        _nekotonRepository.startPollingToken(
          w.owner,
          w.rootTokenContract,
          stopPrevious: false,
        );
        // ignore cancelling sub, because we do not know how many tokens could
        // be here and duplicate startPolling will be ignored
      });
    });
  }

  void _tryUpdatingCurrentActiveAccount(AccountList? list) {
    if (list == null) {
      // means no accounts for this key and we should be logged out or another
      // accounts will be selected soon
      _currentActiveAccountSubject.add((-1, null));
      _nekotonRepository
        ..stopPolling()
        ..stopPollingToken();

      return;
    }

    final index = currentActiveAccount?.$1 ?? 0;
    final currentAccount = currentActiveAccount?.$2;
    final keyChanged = currentAccount?.publicKey != list.publicKey;

    // key changed, update account index.
    // do not compare instances, because accounts can be different.
    //
    // for init method this will be called anyway.
    if (keyChanged) {
      updateCurrentActiveAccount(0);
    } else {
      // key just updated, so update it
      updateCurrentActiveAccount(index);
    }
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
    _tryUpdatingCurrentActiveAccount(key?.accountList);

    if (key == null) {
      _currentAccountsSubject.add(null);

      return;
    }

    _currentAccountsSubject.add(key.accountList);
    _updateSubscriptions(key.accountList);

    final currentAccount = currentActiveAccount?.$2;
    final accounts = currentAccounts?.displayAccounts;
    if (currentAccount == null && accounts != null && accounts.isNotEmpty) {
      updateCurrentActiveAccount(0);
    }
  }

  /// Update Ton/Token wallet subscriptions when user changes current active key
  ///
  /// Old subscriptions will be automatically cancelled if haven't complete yet.
  Future<void> _updateSubscriptions(AccountList accountList) async {
    final accounts = accountList.displayAccounts;

    await _nekotonRepository.updateSubscriptions(
      accounts.map((e) => (e.account.tonWallet, e.isExternal)).toList(),
    );
    await _nekotonRepository.updateTokenSubscriptions(
      accounts.map((e) => e.account).toList(),
    );
  }
}
