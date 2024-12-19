import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_ordinary_transaction_details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Widget that displays completed transaction for ton wallet
class TonWalletOrdinaryTransactionWidget extends StatelessWidget {
  const TonWalletOrdinaryTransactionWidget({
    required this.transaction,
    required this.isFirst,
    required this.isLast,
    required this.price,
    super.key,
  });

  final TonWalletOrdinaryTransaction transaction;
  final bool isFirst;
  final bool isLast;
  final Fixed price;

  @override
  Widget build(BuildContext context) {
    // TODO(malochka): move it in widget_model or model, old implementation
    final ticker =
        inject<NekotonRepository>().currentTransport.nativeTokenTicker;

    return TonWalletTransactionWidget(
      icon: !transaction.isOutgoing
          ? LucideIcons.arrowDownLeft
          : LucideIcons.arrowUpRight,
      isFirst: isFirst,
      isLast: isLast,
      onPressed: () => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (_) => TonWalletOrdinaryTransactionDetailsPage(
            transaction: transaction,
            price: price,
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
