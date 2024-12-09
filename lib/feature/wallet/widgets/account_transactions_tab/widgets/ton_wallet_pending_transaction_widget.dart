import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Widget that displays pending transaction for ton wallet
class TonWalletPendingTransactionWidget extends StatelessWidget {
  const TonWalletPendingTransactionWidget({
    required this.transaction,
    required this.isFirst,
    required this.isLast,
    super.key,
  });

  final TonWalletPendingTransaction transaction;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final ticker =
        inject<NekotonRepository>().currentTransport.nativeTokenTicker;

    return TonWalletTransactionWidget(
      isFirst: isFirst,
      isLast: isLast,
      // ignore: no-empty-block
      onPressed: () {},
      address: transaction.address,
      isIncoming: transaction.isIncoming,
      status: TonWalletTransactionStatus.pending,
      transactionFee: null,
      transactionDateTime: transaction.date,
      transactionValue: Money.fromBigIntWithCurrency(
        transaction.amount,
        Currencies()[ticker]!,
      ),
    );
  }
}
