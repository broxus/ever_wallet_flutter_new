import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/event_bus/events/navigation/bottom_navigation_events.dart';
import 'package:app/event_bus/primary_bus.dart';
import 'package:app/feature/wallet/view/wallet_page_model.dart';
import 'package:app/feature/wallet/view/wallet_page_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

WalletPageWidgetModel defaultWalletPageWidgetModelFactory(
  BuildContext context,
) =>
    WalletPageWidgetModel(
      WalletPageModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
        inject(),
      ),
    );

class WalletPageWidgetModel
    extends CustomWidgetModel<WalletPageWidget, WalletPageModel> {
  WalletPageWidgetModel(super.model) {
    _currentAccount.addListener(_onAccountChanged);
  }

  late final scrollController = createScrollController();

  late final _currentAccount = createNotifierFromStream(model.currentAccount);
  late final _transportStrategy =
      createNotifierFromStream(model.transportStrategy);
  late final _isShowingBadgeNotifier = createNotifier<bool>();
  late final _isShowingNewTokensNotifier = createNotifier<bool>();
  late final _hasUnconfirmedTransactionsNotifier = createNotifier<bool>();

  StreamSubscription<PressBottomNavigationEvent>? _pressWalletSubscribtion;

  StreamSubscription<void>? _changeTransactions;

  ListenableState<KeyAccount?> get currentAccount => _currentAccount;

  ListenableState<bool?> get hasUnconfirmedTransactions =>
      _hasUnconfirmedTransactionsNotifier;

  ListenableState<TransportStrategy> get transportStrategy =>
      _transportStrategy;

  ListenableState<bool> get isShowingBadge => _isShowingBadgeNotifier;

  ListenableState<bool> get isShowingNewTokens => _isShowingNewTokensNotifier;
  int? _numberUnconfirmedTransactions;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _pressWalletSubscribtion = primaryBus
        .on<PressBottomNavigationEvent>()
        .listen(_onPressWalletBottomNavigation);
  }

  @override
  void dispose() {
    _pressWalletSubscribtion?.cancel();
    _changeTransactions?.cancel();
    super.dispose();
  }

  void hideShowingBadge() {
    final account = currentAccount.value;
    _isShowingBadgeNotifier.accept(false);
    if (account != null) {
      model.hideShowingBadge(account);
    }
  }

  void hideNewTokensLabel() {
    final account = currentAccount.value;
    _isShowingNewTokensNotifier.accept(false);
    if (account != null) {
      model.hideNewTokenLabels(account);
    }
  }

  void _onPressWalletBottomNavigation(PressBottomNavigationEvent event) {
    if (!event.isSameTab || !event.isWalletTab) {
      return;
    }

    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
    );
  }

  void _onAccountChanged() {
    _checkBadge();
    _checkUnconfirmedTransactions();
  }

  void _checkBadge() {
    //check user create new wallet or login
    final account = _currentAccount.value;
    final isNewUser = model.isNewUser();

    if (account == null) return;

    if (isNewUser != null) {
      if (isNewUser) {
        _isShowingNewTokensNotifier.accept(true);
        _isShowingBadgeNotifier.accept(true);
      } else {
        _isShowingBadgeNotifier.accept(false);
        model.hideShowingBadge(account);
      }

      model.resetValueNewUser();
      return;
    }

    _isShowingBadgeNotifier.accept(model.isShowingBadge(account) ?? true);
    _isShowingNewTokensNotifier.accept(
      model.isShowingNewTokens(account) ?? true,
    );
  }

  Future<void> _checkUnconfirmedTransactions() async {
    final walletTonState =
        await model.getTonWalletState(_currentAccount.value?.address);
    _numberUnconfirmedTransactions =
        walletTonState.wallet?.unconfirmedTransactions.length ?? 0;
    _hasUnconfirmedTransactionsNotifier.accept(
      (_numberUnconfirmedTransactions ?? 0) > 0,
    );
    _changeTransactions = walletTonState.wallet?.fieldUpdatesStream.listen((_) {
      final newNumber = walletTonState.wallet?.unconfirmedTransactions.length;
      if (_numberUnconfirmedTransactions != newNumber) {
        _numberUnconfirmedTransactions = newNumber;
        _hasUnconfirmedTransactionsNotifier.accept(
          (_numberUnconfirmedTransactions ?? 0) > 0,
        );
      }
    });
  }
}
