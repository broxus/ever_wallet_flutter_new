import 'package:app/generated/generated.dart';
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
    return SingleChildScrollView(
      controller: widget.scrollController,
      padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
      child: SeparatedColumn(
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder<WalletBottomPanelTab>(
            valueListenable: currentTabNotifier,
            builder: (_, value, __) {
              return CommonTabSwitcher(
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
              );
            },
          ),
        ],
      ),
    );
  }
}
