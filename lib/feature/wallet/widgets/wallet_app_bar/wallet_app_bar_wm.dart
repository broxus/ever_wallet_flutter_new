import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/network/bottom_sheets/bottom_sheets.dart';
import 'package:app/feature/wallet/widgets/wallet_app_bar/wallet_app_bar_model.dart';
import 'package:app/feature/wallet/widgets/wallet_app_bar/wallet_app_bar_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

WalletAppBarWidgetModel defaultWalletAppBarWidgetModelFactory(
  BuildContext context,
) =>
    WalletAppBarWidgetModel(
      WalletAppBarModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
      ),
    );

class WalletAppBarWidgetModel
    extends CustomWidgetModel<WalletAppBarWidget, WalletAppBarModel> {
  WalletAppBarWidgetModel(super.model);

  late final _currentAccount = createNotifierFromStream(model.currentAccount);
  late final _walletState = createNotifierFromStream(model.walletState);

  ListenableState<KeyAccount?> get currentAccount => _currentAccount;

  ListenableState<TonWalletState?> get walletState => _walletState;

  ThemeStyleV2 get theme => context.themeStyleV2;

  void onNetwork() {
    showSelectNetworkSheet(context: context);
  }

  void onSettings() {
    // TODO(komarov): account options
  }
}
