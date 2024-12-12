import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Widget that displays expired transaction for ton wallet
class TonWalletExpiredTransactionWidget extends StatelessWidget {
  const TonWalletExpiredTransactionWidget({
    required this.transaction,
    required this.isFirst,
    required this.isLast,
    super.key,
  });

  final TonWalletExpiredTransaction transaction;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final ticker =
        inject<NekotonRepository>().currentTransport.nativeTokenTicker;

    return TonWalletTransactionWidget(
      icon: LucideIcons.x,
      isFirst: isFirst,
      isLast: isLast,
      // ignore: no-empty-block
      onPressed: () {},
      address: transaction.address,
      isIncoming: transaction.isIncoming,
      status: TonWalletTransactionStatus.expired,
      transactionFee: null,
      transactionDateTime: transaction.date,
      transactionValue: Money.fromBigIntWithCurrency(
        transaction.amount,
        Currencies()[ticker]!,
      ),
    );
  }
}
