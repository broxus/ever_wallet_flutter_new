import 'package:app/generated/generated.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

enum WalletBottomPanelTab { asset, transactions }

/// Panel of wallet, that displays information about assets and transactions
/// of wallet.
class WalletBottomPanel extends StatefulWidget {
  const WalletBottomPanel({
    required this.currentAccount,
    required this.scrollController,
    super.key,
  });

  final KeyAccount currentAccount;
  final ScrollController scrollController;

  @override
  State<WalletBottomPanel> createState() => _WalletBottomPanelState();
}

class _WalletBottomPanelState extends State<WalletBottomPanel> {
  final currentTabNotifier = ValueNotifier<WalletBottomPanelTab>(
    WalletBottomPanelTab.asset,
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<WalletBottomPanelTab>(
      valueListenable: currentTabNotifier,
      builder: (_, value, __) {
        return CustomScrollView(
          controller: widget.scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
                child: CommonTabSwitcher(
                  onTabChanged: (v) => currentTabNotifier.value = v,
                  values: [
                    CommonTabSwitcherItem(
                      title: LocaleKeys.assetsWord.tr(),
                      value: WalletBottomPanelTab.asset,
                    ),
                    CommonTabSwitcherItem(
                      title: LocaleKeys.transactionsWord.tr(),
                      value: WalletBottomPanelTab.transactions,
                    ),
                  ],
                  currentValue: value,
                ),
              ),
            ),
            switch (value) {
              WalletBottomPanelTab.asset =>
                AccountAssetsTab(account: widget.currentAccount),
              WalletBottomPanelTab.transactions => AccountTransactionsTab(
                  account: widget.currentAccount,
                  scrollController: widget.scrollController,
                ),
            },
            const SliverToBoxAdapter(
              child: SafeArea(child: SizedBox(height: DimensSize.d8)),
            ),
          ],
        );
      },
    );
  }
}
