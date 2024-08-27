import 'package:app/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class WalletView extends StatefulWidget {
  const WalletView({
    required this.currentAccount,
    super.key,
  });

  final KeyAccount? currentAccount;

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  late final ScrollController _controller;

  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SafeArea(
      child: CustomScrollView(
        controller: _controller,
        slivers: [
          WalletAccountsBody(account: widget.currentAccount),
          WalletBottomPanel(
            currentAccount: widget.currentAccount!,
            scrollController: _controller,
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
