import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'wallet_state.dart';

part 'wallet_cubit.freezed.dart';

/// Cubit for main wallet screen.
/// This cubit allows changing accounts in scope of current key and explore
/// its balance, tokens etc.
class WalletCubit extends Cubit<WalletState> {
  WalletCubit(
    this.currentAccountsService,
    this.nekotonRepository,
    this.initialIndex,
  ) : super(const WalletState.initial());

  final CurrentAccountsService currentAccountsService;
  final NekotonRepository nekotonRepository;

  /// Starting index for account of current key.
  /// This index can be used, if user goes to wallet screen from another screen
  final int? initialIndex;

  /// Page controller should be here to allow cubit manipulate with it
  late PageController _pageController;

  late StreamSubscription<AccountList?> _accountsListSubscription;

  void init() {
    // skip 1 to avoid duplicate initializing
    _accountsListSubscription = currentAccountsService.currentAccountsStream
        .skip(1)
        .listen(_updateCurrentAccounts);

    _pageController = PageController();
    _pageController.addListener(_pageControllerListener);

    _updateCurrentAccounts(
      currentAccountsService.currentAccounts,
      initialIndex,
    );
  }

  /// Needs to drop/update selected account index
  AccountList? _prevAccounts;

  /// If called, then currentKey changed or seedList updated
  void _updateCurrentAccounts(AccountList? list, [int? initialIndex]) {
    if (list == null) {
      // means no accounts for this key and we should be logged out or another
      // accounts will be selected soon
      emit(const WalletState.empty());

      return;
    }

    final keyChanged = _prevAccounts?.publicKey != list.publicKey;

    // key changed, update account index.
    // do not compare instances, because accounts can be different.
    //
    // for init method this will be called anyway.
    _prevAccounts = list;
    if (keyChanged) {
      updateCurrentAccountIndex(initialIndex ?? 0);
    } else {
      // key just updated, so emit state to update it
      updateCurrentAccountIndex(_pageController.page?.round() ?? 0);
    }
  }

  /// [index] can be more than length of accounts, this means, that
  /// `add account` card is displayed.
  /// [index] is a value of page controller.
  void updateCurrentAccountIndex(int index) {
    final accounts = _prevAccounts?.displayAccounts;
    final key = _prevAccounts?.publicKey;
    if (accounts == null || key == null) {
      emit(const WalletState.empty());

      return;
    }

    final current =
        index >= 0 && index < accounts.length ? accounts[index] : null;

    if (current != null) {
      _tryStartPolling(current.address);
    } else {
      // add new account tab selected
      nekotonRepository.stopPolling();
    }

    emit(
      WalletState.accounts(
        list: accounts,
        currentKey: key,
        currentAccount: current,
        controller: _pageController,
      ),
    );
  }

  bool _onScroll = false;

  void _pageControllerListener() {
    final currentPagePosition = _pageController.page ?? 0;
    final currentPage = currentPagePosition.round();
    if (_onScroll && currentPage == currentPagePosition) {
      updateCurrentAccountIndex(currentPage);
      _onScroll = false;
    } else if (!_onScroll && currentPage != currentPagePosition) {
      _onScroll = true;
    }
  }

  StreamSubscription<dynamic>? _subscription;

  /// Start listening for wallet subscriptions and when subscription will be
  /// created, start polling.
  void _tryStartPolling(Address address) {
    _subscription?.cancel();

    _subscription = nekotonRepository.tokenWalletsStream.listen((wallets) {
      if (wallets.map((e) => e.address).contains(address)) {
        nekotonRepository.startPolling(address);
        _subscription?.cancel();
      }
    });
  }

  @override
  Future<void> close() {
    _pageController.dispose();
    _accountsListSubscription.cancel();

    return super.close();
  }
}
