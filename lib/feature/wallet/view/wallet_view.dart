import 'package:app/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class WalletView extends StatelessWidget {
  const WalletView({
    required this.currentAccount,
    required this.scrollController,
    super.key,
  });

  final KeyAccount? currentAccount;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SafeArea(
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          WalletAccountsBody(account: currentAccount),
          WalletBottomPanel(
            currentAccount: currentAccount!,
            scrollController: scrollController,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(color: theme.colors.background1),
          ),
        ],
      ),
    );
  }
}
