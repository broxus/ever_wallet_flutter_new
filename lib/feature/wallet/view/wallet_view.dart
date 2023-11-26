import 'package:app/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Sum of heights of elements on main screen
final _appbarAccountCardActionsHeight = defaultAppBarHeight +
    walletActionButtonSize.value +
    walletAccountCardHeight +
    walletAccountIndicatorSpace +
    // multiply by 2 because indicators height is 8 and space between indicator
    // and button is 8
    walletAccountsPageIndicatorHeight * 2 +
    kToolbarHeight +
    // card margin
    DimensSize.d12 +
    // just space below
    DimensSize.d24;

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
    if (oldWidget.currentAccount != null &&
        widget.currentAccount == null &&
        _panelController.isAttached) {
      _panelController.hide();
    }
    if (oldWidget.currentAccount == null &&
        widget.currentAccount != null &&
        _panelController.isAttached) {
      _panelController.show();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return CommonSlidingPanel(
      maxHeightSizePercent: 1,
      minHeight: mq.size.height - _appbarAccountCardActionsHeight,
      panelController: _panelController,
      panelBuilder: (context, scrollController) {
        if (widget.currentAccount == null) {
          return const SizedBox.shrink();
        }

        return WalletBottomPanel(
          key: Key('WalletBottomPanel-${widget.currentAccount!.address}'),
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
