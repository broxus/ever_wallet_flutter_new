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
    this.nekotonRepository,
    this.currentKeyService,
    this.initialIndex,
  ) : super(const WalletState.initial());

  final NekotonRepository nekotonRepository;
  final CurrentKeyService currentKeyService;

  /// Starting index for account of current key.
  /// This index can be used, if user goes to wallet screen from another screen
  final int? initialIndex;

  /// Page controller should be here to allow cubit manipulate with it
  late PageController _pageController;

  late StreamSubscription<PublicKey?> _currentKeySubscription;
  late StreamSubscription<SeedList> _seedListSubscription;

  void init() {
    // skip 1 to avoid duplicate initializing
    _seedListSubscription = nekotonRepository.seedListStream
        .skip(1)
        .listen((_) => _updateCurrentKey());
    _currentKeySubscription = currentKeyService.currentKeyStream
        .skip(1)
        .listen((_) => _updateCurrentKey());

    _pageController = PageController();
    _pageController.addListener(_pageControllerListener);

    _updateCurrentKey(initialIndex);
  }

  /// Needs to drop/update selected account index
  SeedKey? _prevKey;

  /// If called, then currentKey changed or seedList updated
  void _updateCurrentKey([int? initialIndex]) {
    final list = nekotonRepository.seedList;
    final current = currentKeyService.currentKey;
    final key = current == null ? null : list.findSeedKey(current);

    if (current == null || key == null) {
      // means no instance for this key and we should be logged out or another
      // current key will be selected soon
      emit(const WalletState.empty());

      return;
    }

    final keyChanged = _prevKey?.publicKey != key.publicKey;

    // key changed, update account index.
    // do not compare instances, because accounts can be different.
    //
    // for init method this will be called anyway.
    _prevKey = key;
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
    final list = _prevKey?.accountList;
    if (list == null) {
      emit(const WalletState.empty());

      return;
    }

    final accounts = list.displayAccounts;
    final current =
        index >= 0 && index < accounts.length ? accounts[index] : null;

    emit(
      WalletState.accounts(
        list: accounts,
        currentKey: list.publicKey,
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

  @override
  Future<void> close() {
    _pageController.dispose();
    _seedListSubscription.cancel();
    _currentKeySubscription.cancel();

    return super.close();
  }
}
