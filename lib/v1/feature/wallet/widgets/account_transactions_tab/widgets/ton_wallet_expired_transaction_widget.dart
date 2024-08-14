import 'package:app/di/di.dart';
import 'package:app/v1/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/v1/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Widget that displays expired transaction for ton wallet
class TonWalletExpiredTransactionWidget extends StatelessWidget {
  const TonWalletExpiredTransactionWidget({
    required this.transaction,
    required this.displayDate,
    super.key,
  });

  final TonWalletExpiredTransaction transaction;
  final bool displayDate;

  @override
  Widget build(BuildContext context) {
    final ticker =
        inject<NekotonRepository>().currentTransport.nativeTokenTicker;

    return TonWalletTransactionWidget(
      displayDate: displayDate,
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
