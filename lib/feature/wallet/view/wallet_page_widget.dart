import 'package:app/feature/wallet/view/wallet_page_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
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
      body: TripleSourceBuilder(
        firstSource: wm.currentAccount,
        secondSource: wm.hasUnconfirmedTransactions,
        thirdSource: wm.connection,
        builder: (_, account, hasUnconfirmed, connection) {
          if (account == null) return const SizedBox.shrink();
          return TripleSourceBuilder(
            firstSource: wm.isShowingBadge,
            secondSource: wm.isShowingNewTokens,
            thirdSource: wm.transportStrategy,
            builder: (_, isShowingBadge, isShowingNewTokens, transport) {
              return WalletView(
                key: ValueKey(account),
                currentAccount: account,
                scrollController: wm.scrollController,
                isShowingBadge: isShowingBadge ?? false,
                isShowingNewTokens: isShowingNewTokens ?? false,
                finishedBackupCallback: wm.hideShowingBadge,
                confirmImportCallback: wm.hideNewTokensLabel,
                manifestUrl: transport?.manifestUrl ?? '',
                hasUnconfirmedTransactions: hasUnconfirmed ?? false,
                imageUrl: wm.getImagePathByNetwork(connection),
              );
            },
          );
        },
      ),
    );
  }
}
