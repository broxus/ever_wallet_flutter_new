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
      ),
    );

class WalletPageWidgetModel
    extends CustomWidgetModel<WalletPageWidget, WalletPageModel> {
  WalletPageWidgetModel(super.model);

  late final scrollController = createScrollController();

  late final _currentAccount = createNotifierFromStream(model.currentAccount);

  ListenableState<KeyAccount?> get currentAccount => _currentAccount;
}
