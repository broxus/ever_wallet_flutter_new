import 'dart:async';

import 'package:app/app/service/secure_storage_service.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
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
        SecureStorageService(),
      ),
    );

class WalletPageWidgetModel
    extends CustomWidgetModel<WalletPageWidget, WalletPageModel> {
  WalletPageWidgetModel(super.model);

  late final scrollController = createScrollController();

  late final _currentAccount = createNotifierFromStream(model.currentAccount);
  late final _isShowingBadgeNotifier = StateNotifier<bool>();

  ListenableState<KeyAccount?> get currentAccount => _currentAccount;

  ListenableState<bool> get isShowingBadge => _isShowingBadgeNotifier;

  void hideShowingBadge() {
    final address = currentAccount.value?.address.address;
    _isShowingBadgeNotifier.accept(false);
    if (address != null) {
      model.hideShowingBadge(address);
    }
  }

  Future<void> checkBadge(KeyAccount? account) async {
    //check user create new wallet or login
    final isNewUser = await model.isNewUser();
    if (isNewUser != null) {
      if (isNewUser) {
        _isShowingBadgeNotifier.accept(true);
      } else {
        _isShowingBadgeNotifier.accept(false);
        if (account != null) {
          unawaited(model.hideShowingBadge(account.address.address));
        }
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
