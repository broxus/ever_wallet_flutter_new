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
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

WalletPageWidgetModel defaultWalletPageWidgetModelFactory(
  BuildContext context,
) =>
    WalletPageWidgetModel(
      WalletPageModel(
        createPrimaryErrorHandler(context),
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
  late final _isShowingBadgeNotifier = StateNotifier<bool>();

  StreamSubscription<PressBottomNavigationEvent>? _pressWalletSubscribtion;

  ListenableState<KeyAccount?> get currentAccount => _currentAccount;

  ListenableState<bool> get isShowingBadge => _isShowingBadgeNotifier;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    GoRouter.of(context);
    _pressWalletSubscribtion = primaryBus
        .on<PressBottomNavigationEvent>()
        .listen(_onPressWalletBottomNavigation);
  }

  @override
  void dispose() {
    _pressWalletSubscribtion?.cancel();
    super.dispose();
  }

  void hideShowingBadge() {
    final address = currentAccount.value?.address.address;
    _isShowingBadgeNotifier.accept(false);
    if (address != null) {
      model.hideShowingBadge(address);
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
  }

  Future<void> _checkBadge() async {
    //check user create new wallet or login
    final account = _currentAccount.value;
    final isNewUser = await model.isNewUser();
    if (isNewUser != null && account != null) {
      if (isNewUser) {
        _isShowingBadgeNotifier.accept(true);
      } else {
        _isShowingBadgeNotifier.accept(false);
        unawaited(model.hideShowingBadge(account.address.address));
      }
      unawaited(model.resetValueNewUser());
      return;
    }
    if (account != null) {
      _isShowingBadgeNotifier.accept(
        await model.isShowingBadge(account.address.address) ?? true,
      );
    } else {
      _isShowingBadgeNotifier.accept(true);
    }
  }
}
