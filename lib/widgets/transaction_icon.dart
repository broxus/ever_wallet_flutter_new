import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class TransactionIcon extends StatelessWidget {
  const TransactionIcon({
    required this.isIncoming,
    required this.icon,
    this.status,
    this.size,
    super.key,
  });

  final TonWalletTransactionStatus? status;
  final bool isIncoming;
  final IconData icon;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Container(
      height: size ?? DimensSizeV2.d40,
      width: size ?? DimensSizeV2.d40,
      decoration: BoxDecoration(
        color: theme.colors.backgroundAlpha,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          size: DimensSizeV2.d20,
          color: _getColor(theme, status, isIncoming),
        ),
      ),
    );
  }

  Color _getColor(
    ThemeStyleV2 theme,
    TonWalletTransactionStatus? status,
    bool isIncoming,
  ) {
    if (status == TonWalletTransactionStatus.waitingConfirmation) {
      return theme.colors.contentWarning;
    } else if (status == TonWalletTransactionStatus.pending ||
        status == TonWalletTransactionStatus.expired) {
      return theme.colors.content0;
    } else if (isIncoming) {
      return theme.colors.contentPositive;
    } else {
      return theme.colors.content0;
    }
  }
}
