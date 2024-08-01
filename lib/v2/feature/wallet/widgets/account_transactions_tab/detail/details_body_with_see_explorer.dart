import 'package:app/v2/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget that wraps [body] in stack and adds [SeeInExplorerButton].
/// [body] automatically wraps with scroll widget.
/// Works for Ton/Token wallets
class WalletTransactionDetailsBodyWithExplorerButton extends StatelessWidget {
  const WalletTransactionDetailsBodyWithExplorerButton({
    required this.body,
    required this.transactionHash,
    this.action,
    super.key,
  });

  /// Content of transaction
  final Widget body;

  /// Hash of transaction that is used to open explorer in browser
  final String transactionHash;

  /// Action that can add behavior for transaction
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: DimensSize.d16 +
                    commonButtonHeight +
                    DimensSize.d8 +
                    (action == null ? 0 : commonButtonHeight + DimensSize.d8),
              ),
              child: body,
            ),
          ),
        ),
        Positioned(
          bottom: DimensSize.d16,
          left: DimensSize.d16,
          right: DimensSize.d16,
          child: SeparatedColumn(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (action != null) action!,
              SeeInExplorerButton(
                transactionHash: transactionHash,
                isSecondary: action != null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
