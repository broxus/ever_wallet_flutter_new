import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/transaction_icon.dart';
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
    required this.isFirst,
    required this.isLast,
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
  final bool isFirst;
  final bool isLast;
  final Fixed price;
  final Address rootTokenContract;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final date = isFirst ? _headerDate(theme) : null;

    final body = PressScaleWidget(
      onPressed: () => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (_) => TokenWalletOrdinaryTransactionDetailsScreen(
            transaction: transaction,
            tokenCurrency: transactionValue.currency,
            price: price,
            rootTokenContract: rootTokenContract,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colors.background1,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(isFirst ? DimensRadiusV2.radius16 : 0),
            bottom: Radius.circular(isLast ? DimensRadiusV2.radius16 : 0),
          ),
        ),
        child: _baseTransactionBody(theme),
      ),
    );

    return date == null
        ? body
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
                        TransactionIcon(
                          isIncoming: isIncoming,
                          icon: isIncoming
                              ? LucideIcons.arrowDownLeft
                              : LucideIcons.arrowUpRight,
                        ),
                        const SizedBox(width: DimensSizeV2.d8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              isIncoming
                                  ? LocaleKeys.fromWord.tr(
                                      args: [
                                        transaction.address.toEllipseString(),
                                      ],
                                    )
                                  : LocaleKeys.toWord.tr(
                                      args: [
                                        transaction.address.toEllipseString(),
                                      ],
                                    ),
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
                  const SizedBox(height: DimensSizeV2.d14),
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
