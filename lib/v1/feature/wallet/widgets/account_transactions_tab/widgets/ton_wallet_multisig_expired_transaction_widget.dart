import 'package:app/di/di.dart';
import 'package:app/v1/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Widget that displays expired multisig transaction for ton wallet
class TonWalletMultisigExpiredTransactionWidget extends StatelessWidget {
  const TonWalletMultisigExpiredTransactionWidget({
    required this.transaction,
    required this.displayDate,
    super.key,
  });

  final TonWalletMultisigExpiredTransaction transaction;
  final bool displayDate;

  @override
  Widget build(BuildContext context) {
    final ticker =
        inject<NekotonRepository>().currentTransport.nativeTokenTicker;

    return TonWalletTransactionWidget(
      displayDate: displayDate,
      onPressed: () => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (_) => TonWalletMultisigExpiredTransactionDetailsPage(
            transaction: transaction,
          ),
        ),
      ),
      address: transaction.address,
      isIncoming: !transaction.isOutgoing,
      status: TonWalletTransactionStatus.expired,
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
