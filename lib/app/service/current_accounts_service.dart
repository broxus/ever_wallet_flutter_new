import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

const _currentAddress = 'current_address';
const _preferencesKey = 'preferences_key';

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
    this._storage,
  );

  final NekotonRepository _nekotonRepository;
  final CurrentKeyService _currentKeyService;
  final EncryptedStorage _storage;

  final _currentAccountsSubject = BehaviorSubject<AccountList?>.seeded(null);

  final _currentActiveAccountAddressSubject =
      BehaviorSubject<Address?>.seeded(null);

  /// Get stream of accounts in scope of current active key
  Stream<AccountList?> get currentAccountsStream => _currentAccountsSubject;

  /// Get accounts in scope of current active key
  AccountList? get currentAccounts => _currentAccountsSubject.valueOrNull;

  Address? get currentActiveAccountAddress =>
      _currentActiveAccountAddressSubject.valueOrNull;

  /// Get stream of current active account in wallet tab.
  /// This will automatically changes when [currentAccountsStream] emits new
  /// accounts for another key.
  ///
  /// Changes in this stream can also sign you that [currentAccountsStream]
  /// could provide a new value.
  ///
  /// You can affect for this stream, calling [updateCurrentActiveAccount]
  Stream<KeyAccount?> get currentActiveAccountStream =>
      CombineLatestStream.combine2(
        _currentActiveAccountAddressSubject,
        _currentAccountsSubject,
        (address, accounts) => accounts?.allAccounts.firstWhereOrNull(
          (account) => account.address == address,
        ),
      );

  /// Get current active account in wallet tab.
  /// This will automatically changes when [currentAccountsStream] emits new
  /// accounts for another key.
  ///
  /// You can affect for this value, calling [updateCurrentActiveAccount]
  KeyAccount? get currentActiveAccount {
    final address = currentActiveAccountAddress;
    final accounts = currentAccounts;
    return accounts?.allAccounts.firstWhereOrNull(
      (account) => account.address == address,
    );
  }

  Future<void> init() async {
    // skip 1 to avoid duplicate calls
    _nekotonRepository.seedListStream.skip(1).listen(
          (list) => _updateAccountsList(list, _currentKeyService.currentKey),
        );
    _currentKeyService.currentKeyStream.skip(1).listen(
          (key) => _updateAccountsList(_nekotonRepository.seedList, key),
        );

    currentActiveAccountStream
        .map((account) => account?.address)
        .distinct()
        .listen(_tryStartPolling);

    await _initCurrentAccount();

    _updateAccountsList(
      _nekotonRepository.seedList,
      _currentKeyService.currentKey,
    );
  }

  /// Try updating current active account for [currentAccounts]
  Future<void> updateCurrentActiveAccount(Address address) async {
    if (currentActiveAccountAddress == address) return;

    _currentActiveAccountAddressSubject.add(address);

    await _storage.set(
      _currentAddress,
      address.address,
      domain: _preferencesKey,
    );
  }

  /// Subscriptions for listening Ton/Token wallets to start its polling when
  /// their account is selected in [currentActiveAccount].
  StreamSubscription<dynamic>? _tonWalletSubscription;
  StreamSubscription<dynamic>? _tokenWalletSubscription;

  Future<void> _initCurrentAccount() async {
    final address = await _storage.get(
      _currentAddress,
      domain: _preferencesKey,
    );

    if (address == null) {
      return;
    }

    final key = _currentKeyService.currentKey?.let(
      (value) => _nekotonRepository.seedList.findSeedKey(value),
    );
    final account = key?.accountList.allAccounts.firstWhereOrNull(
      (KeyAccount account) => account.address.address == address,
    );

    if (account == null) {
      return;
    }

    unawaited(updateCurrentActiveAccount(account.address));
  }

  /// Start listening for wallet subscriptions and when subscription will be
  /// created, start polling.
  void _tryStartPolling(final Address? address) {
    _tonWalletSubscription?.cancel();
    _tokenWalletSubscription?.cancel();
    _nekotonRepository
      ..stopPolling()
      ..stopPollingToken();

    if (address == null) return;

    _tonWalletSubscription = _nekotonRepository.walletsStream.listen((wallets) {
      if (_nekotonRepository.walletsMap.containsKey(address)) {
        _nekotonRepository.startPolling(address);
        _tonWalletSubscription?.cancel();
      }
    });

    _tokenWalletSubscription =
        _nekotonRepository.tokenWalletsStream.listen((wallets) {
      wallets.where((w) => w.owner == address).forEach((w) {
        final key = (w.owner, w.rootTokenContract);
        if (_nekotonRepository.tokenWalletsMap.containsKey(key)) {
          _nekotonRepository.startPollingToken(
            w.owner,
            w.rootTokenContract,
            stopPrevious: false,
          );
        }
        // ignore cancelling sub, because we do not know how many tokens could
        // be here and duplicate startPolling will be ignored
      });
    });
  }

  void _tryUpdatingCurrentActiveAccount(AccountList? list) {
    if (list == null) {
      // means no accounts for this key and we should be logged out or another
      // accounts will be selected soon
      _currentActiveAccountAddressSubject.add(null);
      _nekotonRepository
        ..stopPolling()
        ..stopPollingToken();

      return;
    }

    final address = currentActiveAccountAddress;
    final keyChanged = address == null ||
        list.allAccounts.every(
          (account) => account.address != address,
        );

    // key changed
    // for init method this will be called anyway.
    if (keyChanged) {
      final account =
          list.displayAccounts.firstOrNull ?? list.allAccounts.firstOrNull;

      if (account != null) {
        updateCurrentActiveAccount(account.address);
      }
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

    if (_currentAccountsSubject.valueOrNull != key.accountList) {
      _currentAccountsSubject.add(key.accountList);
      _updateSubscriptions(key.accountList);
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
