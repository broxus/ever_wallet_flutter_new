import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Widget that displays completed transaction for ton wallet
class TonWalletOrdinaryTransactionWidget extends StatelessWidget {
  const TonWalletOrdinaryTransactionWidget({
    required this.transaction,
    required this.displayDate,
    super.key,
  });

  final TonWalletOrdinaryTransaction transaction;
  final bool displayDate;

  @override
  Widget build(BuildContext context) {
    final ticker =
        inject<NekotonRepository>().currentTransport.nativeTokenTicker;

    return TonWalletTransactionWidget(
      displayDate: displayDate,
      onPressed: () => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (_) => TonWalletOrdinaryTransactionDetailsPage(
            transaction: transaction,
          ),
        ),
      ),
      address: transaction.address,
      isIncoming: !transaction.isOutgoing,
      status: TonWalletTransactionStatus.completed,
      transactionFee: Money.fromBigIntWithCurrency(
        transaction.fees,
        Currencies()[ticker]!,
      ),
      transactionDateTime: transaction.date,
      transactionValue: Money.fromBigIntWithCurrency(
        transaction.value,
        Currencies()[ticker]!,
      ),
    );
  }
}
