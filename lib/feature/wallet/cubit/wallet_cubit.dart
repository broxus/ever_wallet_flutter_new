import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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

  late StreamSubscription<(int, KeyAccount?)?> _accountsListSubscription;

  void init() {
    // skip 1 to avoid duplicate initializing
    _accountsListSubscription = currentAccountsService
        .currentActiveAccountStream
        .skip(1)
        .listen(_updateCurrentAccounts);

    _pageController = PageController();
    _pageController.addListener(_pageControllerListener);

    currentAccountsService.updateCurrentActiveAccount(initialIndex ?? 0);
  }

  /// If called, then new account was selected by user or by changing key
  void _updateCurrentAccounts((int, KeyAccount?)? currentAccount) {
    final index = currentAccount?.$1;
    final current = currentAccount?.$2;
    final accounts = currentAccountsService.currentAccounts?.displayAccounts;
    final key = currentAccountsService.currentAccounts?.publicKey;

    if (index == null || accounts == null || key == null) {
      emit(const WalletState.empty());

      return;
    }

    if (_pageController.hasClients && _pageController.page?.round() != index) {
      _pageController.animateToPage(
        index,
        duration: kThemeChangeDuration,
        curve: Curves.easeIn,
      );
    }

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
      currentAccountsService.updateCurrentActiveAccount(currentPage);
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
