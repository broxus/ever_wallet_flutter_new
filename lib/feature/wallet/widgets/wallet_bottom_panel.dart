import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/account_transactions_tab.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

enum WalletBottomPanelTab { asset, transactions }

/// Panel of wallet, that displays information about assets and transactions
/// of wallet.
class WalletBottomPanel extends StatefulWidget {
  const WalletBottomPanel({
    required this.currentAccount,
    required this.scrollController,
    required this.isShowingNewTokens,
    required this.hasUnconfirmedTransactions,
    required this.confirmImportCallback,
    required this.manifestUrl,
    super.key,
  });

  final KeyAccount currentAccount;
  final ScrollController scrollController;
  final bool isShowingNewTokens;
  final bool hasUnconfirmedTransactions;
  final VoidCallback confirmImportCallback;
  final String manifestUrl;

  @override
  State<WalletBottomPanel> createState() => _WalletBottomPanelState();
}

class _WalletBottomPanelState extends State<WalletBottomPanel> {
  final currentTabNotifier = ValueNotifier<WalletBottomPanelTab>(
    WalletBottomPanelTab.asset,
  );

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return DecoratedSliver(
      decoration: BoxDecoration(
        color: theme.colors.background0,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(DimensRadiusV2.radius24),
        ),
      ),
      sliver: SliverPadding(
        padding: const EdgeInsets.only(
          top: DimensSizeV2.d24,
          left: DimensSizeV2.d16,
          right: DimensSizeV2.d16,
          bottom: DimensSizeV2.d8,
        ),
        sliver: ValueListenableBuilder<WalletBottomPanelTab>(
          valueListenable: currentTabNotifier,
          builder: (_, value, __) {
            return SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: DimensSizeV2.d24),
                    child: SwitcherSegmentControls(
                      currentValue: value,
                      values: [
                        PrimarySegmentControl(
                          state: SegmentControlState.normal,
                          title: LocaleKeys.assetsWord.tr(),
                          value: WalletBottomPanelTab.asset,
                          size: SegmentControlSize.xsmall,
                        ),
                        PrimarySegmentControl(
                          state: SegmentControlState.normal,
                          title: LocaleKeys.transactionsWord.tr(),
                          value: WalletBottomPanelTab.transactions,
                          size: SegmentControlSize.xsmall,
                          postfixIcon: widget.hasUnconfirmedTransactions
                              ? LucideIcons.timer
                              : null,
                          customIconColor: theme.colors.contentWarning,
                        ),
                      ],
                      onTabChanged: (v) => currentTabNotifier.value = v,
                    ),
                  ),
                ),
                switch (value) {
                  WalletBottomPanelTab.asset => AccountAssetsTab(
                      account: widget.currentAccount,
                      isShowingNewTokens: widget.isShowingNewTokens,
                      confirmImportCallback: widget.confirmImportCallback,
                      manifestUrl: widget.manifestUrl,
                    ),
                  WalletBottomPanelTab.transactions => AccountTransactionsTab(
                      account: widget.currentAccount,
                      scrollController: widget.scrollController,
                    ),
                },
              ],
            );
          },
        ),
      ),
    );
  }
}
