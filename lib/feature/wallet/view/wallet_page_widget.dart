import 'package:app/feature/wallet/view/wallet_page_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class WalletPageWidget extends ElementaryWidget<WalletPageWidgetModel> {
  const WalletPageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultWalletPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(WalletPageWidgetModel wm) {
    return Scaffold(
      body: DoubleSourceBuilder<KeyAccount?, bool>(
        firstSource: wm.currentAccount,
        secondSource: wm.isFirstEntering,
        builder: (_, currentAccount, isFirstEntering) {
          return currentAccount?.let(
                (value) => StateNotifierBuilder(
                  listenableState: wm.isShowingBadge,
                  builder: (_, isShowingBadge) => WalletView(
                    key: ValueKey(value),
                    currentAccount: value,
                    scrollController: wm.scrollController,
                    isShowingBadge: isShowingBadge ?? false,
                    isFirstEntering: isFirstEntering ?? false,
                    finishedBackupCallback: wm.hideShowingBadge,
                    checkTokensCallback: wm.hideNewTokensLabel,
                  ),
                ),
              ) ??
              const SizedBox.shrink();
        },
      ),
    );
  }
}
