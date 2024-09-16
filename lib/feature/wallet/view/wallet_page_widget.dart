import 'package:app/feature/wallet/view/wallet_page_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

class WalletPageWidget extends ElementaryWidget<WalletPageWidgetModel> {
  const WalletPageWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultWalletPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(WalletPageWidgetModel wm) {
    return Scaffold(
      body: StateNotifierBuilder(
        listenableState: wm.currentAccount,
        builder: (_, currentAccount) {
          return currentAccount?.let(
                (value) => StateNotifierBuilder(
                  listenableState: wm.isShowingBadge,
                  builder: (_, isShowingBadge) => WalletView(
                    key: ValueKey(value),
                    currentAccount: value,
                    scrollController: wm.scrollController,
                    isShowingBadge: isShowingBadge ?? false,
                    finishedBackupCallback: wm.hideShowingBadge,
                  ),
                ),
              ) ??
              const SizedBox.shrink();
        },
      ),
    );
  }
}
