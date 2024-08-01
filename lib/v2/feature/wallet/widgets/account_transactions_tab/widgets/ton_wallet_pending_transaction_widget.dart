import 'package:app/di/di.dart';
import 'package:app/v2/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Widget that displays pending transaction for ton wallet
class TonWalletPendingTransactionWidget extends StatelessWidget {
  const TonWalletPendingTransactionWidget({
    required this.transaction,
    required this.displayDate,
    super.key,
  });

  final TonWalletPendingTransaction transaction;
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