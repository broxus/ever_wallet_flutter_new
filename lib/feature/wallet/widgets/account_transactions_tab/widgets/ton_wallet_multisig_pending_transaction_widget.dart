import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_pending_transaction_details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget that displays pending multisig transaction for ton wallet
class TonWalletMultisigPendingTransactionWidget extends StatelessWidget {
  const TonWalletMultisigPendingTransactionWidget({
    required this.transaction,
    required this.isFirst,
    required this.isLast,
    required this.price,
    required this.account,
    super.key,
  });

  final TonWalletMultisigPendingTransaction transaction;
  final bool isFirst;
  final bool isLast;
  final Fixed price;
  final KeyAccount account;

  @override
  Widget build(BuildContext context) {
    final ticker =
        inject<NekotonRepository>().currentTransport.nativeTokenTicker;
    final expireAtFormat = DateFormat('HH:mm:ss', context.locale.languageCode);
    final theme = context.themeStyleV2;

    return TonWalletTransactionWidget(
      isFirst: isFirst,
      isLast: isLast,
      onPressed: () => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (_) => TonWalletMultisigPendingTransactionDetailsPage(
            transaction: transaction,
            price: price,
            account: account,
          ),
        ),
      ),
      address: transaction.address,
      isIncoming: !transaction.isOutgoing,
      status: transaction.canConfirm
          ? TonWalletTransactionStatus.waitingConfirmation
          : TonWalletTransactionStatus.pending,
      transactionFee: Money.fromBigIntWithCurrency(
        transaction.fees,
        Currencies()[ticker]!,
      ),
      transactionDateTime: transaction.date,
      transactionValue: Money.fromBigIntWithCurrency(
        transaction.value,
        Currencies()[ticker]!,
      ),
      additionalInformation: Padding(
        padding: const EdgeInsets.only(bottom: DimensSizeV2.d3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              LocaleKeys.confirmedCustodians.tr(
                args: [
                  transaction.signsReceived.toString(),
                  transaction.signsRequired.toString(),
                ],
              ),
              style: theme.textStyles.labelXSmall
                  .copyWith(color: theme.colors.warning),
            ),
            Text(
              LocaleKeys.expiresInCustodians
                  .tr(args: [expireAtFormat.format(transaction.expireAt)]),
              style: theme.textStyles.labelXSmall
                  .copyWith(color: theme.colors.content3),
            ),
          ],
        ),
      ),
      icon: LucideIcons.timer,
    );
  }
}
