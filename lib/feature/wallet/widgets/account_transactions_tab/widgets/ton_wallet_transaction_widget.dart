import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

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
    final colors = context.themeStyle.colors;
    final date = displayDate ? _headerDate() : null;
    final statusWidget = tonWalletTransactionStatusBody(status);

    final body = PressScaleWidget(
      onPressed: onPressed,
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
          child: SeparatedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            separator: const CommonDivider(),
            children: [
              _baseTransactionBody(),
              if (additionalInformation != null) additionalInformation!,
              if (statusWidget != null)
                Padding(
                  padding: const EdgeInsets.all(DimensSize.d16),
                  child: SeparatedRow(
                    children: [
                      Text(
                        LocaleKeys.statusWord.tr(),
                        style: StyleRes.addRegular.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                      const Spacer(),
                      statusWidget,
                    ],
                  ),
                ),
            ],
          ),
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

        final now = DateTime.now();
        final formatter = transactionDateTime.year == now.year
            ? DateFormat('MMMM dd', context.locale.languageCode)
            : DateFormat('MMMM dd y', context.locale.languageCode);

        return Padding(
          padding: const EdgeInsets.only(top: DimensSize.d8),
          child: Text(
            formatter.format(transactionDateTime),
            style: StyleRes.secondaryBold.copyWith(color: colors.textPrimary),
          ),
        );
      },
    );
  }

  // ignore: long-method
  Widget _baseTransactionBody() {
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
                          TextSpan(text: address.toEllipseString()),
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
                                .format(transactionDateTime),
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
