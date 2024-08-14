import 'package:app/di/di.dart';
import 'package:app/v2/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/v2/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/v2/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Widget that displays completed multisig transaction for ton wallet
class TonWalletMultisigOrdinaryTransactionWidget extends StatelessWidget {
  const TonWalletMultisigOrdinaryTransactionWidget({
    required this.transaction,
    required this.displayDate,
    super.key,
  });

  final TonWalletMultisigOrdinaryTransaction transaction;
  final bool displayDate;

  @override
  Widget build(BuildContext context) {
    final ticker =
        inject<NekotonRepository>().currentTransport.nativeTokenTicker;

    return TonWalletTransactionWidget(
      displayDate: displayDate,
      onPressed: () => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (_) => TonWalletMultisigOrdinaryTransactionDetailsPage(
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
