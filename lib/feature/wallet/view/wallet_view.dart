import 'package:app/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class WalletView extends StatefulWidget {
  const WalletView({
    required this.controller,
    required this.list,
    required this.currentAccount,
    required this.publicKey,
    super.key,
  });

  final PageController controller;
  final List<KeyAccount> list;
  final PublicKey publicKey;
  final KeyAccount? currentAccount;

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  final _panelController = PanelController();

  @override
  void didUpdateWidget(covariant WalletView oldWidget) {
    if (oldWidget.currentAccount != null && widget.currentAccount == null) {
      _panelController.hide();
    }
    if (oldWidget.currentAccount == null && widget.currentAccount != null) {
      _panelController.show();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return CommonSlidingPanel(
      panelController: _panelController,
      panelBuilder: (context, scrollController) {
        if (widget.currentAccount == null) {
          return const SizedBox.shrink();
        }

        return WalletBottomPanel(
          currentAccount: widget.currentAccount!,
          scrollController: scrollController,
        );
      },
      body: WalletAccountsBody(
        accounts: widget.list,
        publicKey: widget.publicKey,
        currentAccount: widget.currentAccount,
        controller: widget.controller,
      ),
    );
  }
}
