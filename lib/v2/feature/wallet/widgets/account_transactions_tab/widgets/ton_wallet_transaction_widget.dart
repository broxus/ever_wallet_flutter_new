import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:app/v2/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Widget that displays pure transaction for TonWallet
class TonWalletTransactionWidget extends StatelessWidget {
  const TonWalletTransactionWidget({
    required this.transactionDateTime,
    required this.isIncoming,
    required this.transactionValue,
    required this.transactionFee,
    required this.status,
    required this.displayDate,
    required this.onPressed,
    required this.address,
    super.key,
    this.additionalInformation,
  });

  /// Date and time of transaction creation
  final DateTime transactionDateTime;

  /// If this transaction filled our account balance
  final bool isIncoming;

  /// Amount of tokens that was sent
  final Money transactionValue;

  /// Fee of blockchain that was taken for transaction.
  /// Transaction can be null for some type of transactions, for example pending
  final Money? transactionFee;

  /// Address of recipient/sender
  final Address address;

  /// Widget that will be displayed between header part and status part,
  /// optional.
  final Widget? additionalInformation;

  /// Status of transaction, if it's not [TonWalletTransactionStatus.completed],
  /// then it will be displayed.
  final TonWalletTransactionStatus status;

  /// If date of this transaction must be displayed.
  /// This is external decision that could use comparing this transaction and
  /// prev one.
  final bool displayDate;

  /// Press callback to open detailed transaction page
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final date = displayDate ? _headerDate(theme) : null;

    final body = PressScaleWidget(
      onPressed: onPressed,
      child: Material(
        shape: const SquircleShapeBorder(cornerRadius: DimensRadius.medium),
        color: theme.colors.background2,
        child: SeparatedColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          separator: const CommonDivider(),
          children: [
            _baseTransactionBody(theme),
            if (additionalInformation != null) additionalInformation!,
          ],
        ),
      ),
    );

    return date == null
        ? Padding(
            padding: const EdgeInsets.only(top: DimensSize.d8),
            child: body,
          )
        : SeparatedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [date, body],
          );
  }

  Widget _headerDate(ThemeStyleV2 theme) {
    return Builder(
      builder: (context) {
        final now = NtpTime.now();
        final formatter = transactionDateTime.year == now.year
            ? DateFormat('MMMM dd', context.locale.languageCode)
            : DateFormat('MMMM dd y', context.locale.languageCode);

        return Padding(
          padding: const EdgeInsets.only(top: DimensSize.d8),
          child: Text(
            formatter.format(transactionDateTime),
            style: theme.textStyles.headingXSmall,
          ),
        );
      },
    );
  }

  // ignore: long-method
  Widget _baseTransactionBody(ThemeStyleV2 theme) {
    return Builder(
      builder: (context) {
        final transactionTimeFormatter = DateFormat(
          'HH:mm',
          context.locale.languageCode,
        );

        return Padding(
          padding: const EdgeInsets.all(DimensSize.d16),
          child: SeparatedRow(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // amount
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          isIncoming
                              ? LucideIcons.arrowDown
                              : LucideIcons.arrowUp,
                          color: isIncoming
                              ? theme.colors.contentPositive
                              : theme.colors.content0,
                          size: DimensSizeV2.d16,
                        ),
                        const SizedBox(width: DimensSizeV2.d8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isIncoming ? 'Received' : 'Sent',
                              style: theme.textStyles.labelSmall,
                            ),
                            const SizedBox(height: DimensSizeV2.d4),
                            Text(
                              address.toEllipseString(),
                              style: theme.textStyles.labelXSmall.copyWith(
                                color: theme.colors.content3,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: DimensSizeV2.d4),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AmountWidget.fromMoney(
                    amount: transactionValue,
                    sign: isIncoming ? '+' : '-',
                    style: theme.textStyles.labelXSmall.copyWith(
                      color: isIncoming
                          ? theme.colors.contentPositive
                          : theme.colors.content0,
                    ),
                  ),
                  const SizedBox(height: DimensSizeV2.d4),
                  Row(
                    children: [
                      if (status == TonWalletTransactionStatus.pending ||
                          status ==
                              TonWalletTransactionStatus.unstakingInProgress)
                        Text(
                          '${status.title} • ',
                          style: theme.textStyles.labelXSmall
                              .copyWith(color: theme.colors.content3),
                        ),
                      Text(
                        transactionTimeFormatter.format(transactionDateTime),
                        style: theme.textStyles.labelXSmall.copyWith(
                          color: theme.colors.content3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
