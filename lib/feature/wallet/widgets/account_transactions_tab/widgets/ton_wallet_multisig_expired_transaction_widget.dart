import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/ton_wallet_multisig_expired_transaction_details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget that displays expired multisig transaction for ton wallet
class TonWalletMultisigExpiredTransactionWidget extends StatelessWidget {
  const TonWalletMultisigExpiredTransactionWidget({
    required this.transaction,
    required this.isFirst,
    required this.isLast,
    required this.price,
    required this.account,
    super.key,
  });

  final TonWalletMultisigExpiredTransaction transaction;
  final Fixed price;
  final bool isFirst;
  final bool isLast;
  final KeyAccount account;

  @override
  Widget build(BuildContext context) {
    final ticker =
        inject<NekotonRepository>().currentTransport.nativeTokenTicker;
    final theme = context.themeStyleV2;
    final transactionTimeFormatter = DateFormat(
      'HH:mm',
      context.locale.languageCode,
    );

    return TonWalletTransactionWidget(
      icon: LucideIcons.x,
      isFirst: isFirst,
      isLast: isLast,
      onPressed: () => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (_) => TonWalletMultisigExpiredTransactionDetailsPage(
            transaction: transaction,
            price: price,
            account: account,
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
      additionalInformation: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            LocaleKeys.transactionExpired.tr(),
            style: theme.textStyles.labelXSmall.copyWith(
              color: theme.colors.content3,
            ),
          ),
          const SizedBox(height: DimensSizeV2.d4),
          Text(
            transactionTimeFormatter.format(transaction.date),
            style: theme.textStyles.labelXSmall.copyWith(
              color: theme.colors.content3,
            ),
          ),
          const SizedBox(height: DimensSizeV2.d6),
        ],
      ),
    );
  }
}
