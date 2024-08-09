import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:app/v1/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget that displays single transaction for <TokenWallet>
class TokenWalletTransactionWidget extends StatelessWidget {
  const TokenWalletTransactionWidget({
    required this.transaction,
    required this.transactionValue,
    required this.displayDate,
    required this.transactionFee,
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

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    final date = displayDate ? _headerDate() : null;

    final body = PressScaleWidget(
      onPressed: () => Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute<void>(
          builder: (_) => TokenWalletOrdinaryTransactionDetailsPage(
            transaction: transaction,
            tokenCurrency: transactionValue.currency,
          ),
        ),
      ),
      child: Material(
        shape: const SquircleShapeBorder(cornerRadius: DimensRadius.medium),
        color: colors.backgroundSecondary,
        child: Container(
          decoration: BoxDecoration(
            border: SquircleBoxBorder(
              squircleRadius: DimensRadius.medium,
              borderSide: BorderSide(color: colors.strokeSecondary),
            ),
          ),
          child: _baseTransactionBody(),
        ),
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

  Widget _headerDate() {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;
        final date = transaction.date;

        final now = NtpTime.now();
        final formatter = date.year == now.year
            ? DateFormat('MMMM dd', context.locale.languageCode)
            : DateFormat('MMMM dd y', context.locale.languageCode);

        return Padding(
          padding: const EdgeInsets.only(top: DimensSize.d8),
          child: Text(
            formatter.format(date),
            style: StyleRes.secondaryBold.copyWith(color: colors.textPrimary),
          ),
        );
      },
    );
  }

  // ignore: long-method
  Widget _baseTransactionBody() {
    final isIncoming = !transaction.isOutgoing;

    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;
        final transactionTimeFormatter = DateFormat(
          'H:m',
          context.locale.languageCode,
        );

        return Padding(
          padding: const EdgeInsets.all(DimensSize.d16),
          child: SeparatedRow(
            children: [
              Expanded(
                child: SeparatedColumn(
                  separatorSize: DimensSize.d4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // amount
                    SeparatedRow(
                      separatorSize: DimensSize.d4,
                      children: [
                        Container(
                          width: DimensSize.d16,
                          height: DimensSize.d16,
                          padding: const EdgeInsets.all(DimensStroke.medium),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isIncoming
                                ? colors.lightGreen
                                : colors.lightBlue,
                          ),
                          child: CommonIconWidget.svg(
                            svg: isIncoming
                                ? Assets.images.arrowDownFlat.path
                                : Assets.images.arrowUpFlat.path,
                            color: isIncoming ? colors.apply : colors.blue,
                          ),
                        ),
                        Expanded(
                          child: MoneyWidget(
                            money: transactionValue,
                            style: MoneyWidgetStyle.primary,
                            sign: isIncoming ? 1 : -1,
                          ),
                        ),
                      ],
                    ),
                    // Info
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: transaction.address.toEllipseString()),
                          if (transactionFee != null &&
                              transactionFee?.amount != Fixed.zero) ...[
                            const TextSpan(text: ' • '),
                            TextSpan(
                              text: LocaleKeys.feesWithData.tr(
                                args: [transactionFee!.formatImproved()],
                              ),
                            ),
                          ],
                          const TextSpan(text: ' • '),
                          TextSpan(
                            text: transactionTimeFormatter
                                .format(transaction.date),
                          ),
                        ],
                      ),
                      style: StyleRes.addRegular
                          .copyWith(color: colors.textSecondary),
                    ),
                  ],
                ),
              ),
              CommonIconWidget.svg(
                svg: Assets.images.caretRight.path,
                color: colors.textSecondary,
              ),
            ],
          ),
        );
      },
    );
  }
}
