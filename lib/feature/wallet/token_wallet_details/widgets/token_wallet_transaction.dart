import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Widget that displays single transaction for <TokenWallet>
class TokenWalletTransactionWidget extends StatelessWidget {
  const TokenWalletTransactionWidget({
    required this.transaction,
    required this.transactionValue,
    required this.displayDate,
    required this.transactionFee,
    required this.price,
    required this.rootTokenContract,
    super.key,
  });

  /// Transaction which should be displayed
  final TokenWalletOrdinaryTransaction transaction;

  /// Amount of tokens that was sent
  final Money transactionValue;

  /// Fee of blockchain that was taken for transaction.
  /// Transaction can be null for some type of transactions
  final Money? transactionFee;

  /// If date of this transaction must be displayed.
  /// This is external decision that could use comparing this transaction and
  /// prev one.
  final bool displayDate;
  final Fixed price;
  final Address rootTokenContract;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final date = displayDate ? _headerDate(theme) : null;

    final body = PressScaleWidget(
      onPressed: () => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (_) => TokenWalletOrdinaryTransactionDetailsPage(
            transaction: transaction,
            tokenCurrency: transactionValue.currency,
            price: price,
            rootTokenContract: rootTokenContract,
          ),
        ),
      ),
      child: Material(
        shape: const SquircleShapeBorder(cornerRadius: DimensRadiusV2.radius16),
        color: theme.colors.background2,
        child: _baseTransactionBody(theme),
      ),
    );

    return date == null
        ? Padding(
            padding: const EdgeInsets.only(top: DimensSizeV2.d8),
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
        final date = transaction.date;

        final now = NtpTime.now();
        final formatter = date.year == now.year
            ? DateFormat('MMMM dd', context.locale.languageCode)
            : DateFormat('MMMM dd y', context.locale.languageCode);

        return Padding(
          padding: const EdgeInsets.only(top: DimensSize.d8),
          child: Text(
            formatter.format(date),
            style: theme.textStyles.headingXSmall,
          ),
        );
      },
    );
  }

  Widget _baseTransactionBody(ThemeStyleV2 theme) {
    final isIncoming = !transaction.isOutgoing;

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
                              transaction.address.toEllipseString(),
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
                    includeSymbol: false,
                    sign: isIncoming
                        ? LocaleKeys.plusSign.tr()
                        : LocaleKeys.minusSign.tr(),
                    style: theme.textStyles.labelXSmall.copyWith(
                      color: isIncoming
                          ? theme.colors.contentPositive
                          : theme.colors.content0,
                    ),
                  ),
                  const SizedBox(height: DimensSizeV2.d4),
                  Text(
                    transactionTimeFormatter.format(transaction.date),
                    style: theme.textStyles.labelXSmall.copyWith(
                      color: theme.colors.content3,
                    ),
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
