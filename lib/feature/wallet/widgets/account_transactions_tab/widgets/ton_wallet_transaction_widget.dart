import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/transaction_icon.dart';
import 'package:flutter/material.dart';
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
    required this.isFirst,
    required this.isLast,
    required this.onPressed,
    required this.address,
    required this.icon,
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
  final bool isFirst;

  /// if isLast true, it means that this transaction is last for this date
  final bool isLast;

  /// Press callback to open detailed transaction page
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final date = isFirst ? _headerDate(theme) : null;

    final body = Container(
      decoration: BoxDecoration(
        color: theme.colors.background1,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(isFirst ? DimensRadiusV2.radius16 : 0),
          bottom: Radius.circular(isLast ? DimensRadiusV2.radius16 : 0),
        ),
      ),
      child: PressScaleWidget(
        onPressed: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: theme.colors.background1,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(isFirst ? DimensRadiusV2.radius16 : 0),
              bottom: Radius.circular(isLast ? DimensRadiusV2.radius16 : 0),
            ),
          ),
          child: SeparatedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _baseTransactionBody(theme),
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
                        TransactionIcon(
                          icon: icon,
                          isIncoming: isIncoming,
                          status: status,
                        ),
                        const SizedBox(width: DimensSizeV2.d12),
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
                                color: _getColorValue(
                                  theme,
                                  status,
                                  isIncoming,
                                ),
                              ),
                            ),
                            const SizedBox(height: DimensSizeV2.d4),
                            Text(
                              isIncoming
                                  ? LocaleKeys.fromWord
                                      .tr(args: [address.toEllipseString()])
                                  : LocaleKeys.toWord
                                      .tr(args: [address.toEllipseString()]),
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
              if (additionalInformation != null)
                additionalInformation!
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (status == TonWalletTransactionStatus.pending ||
                        status ==
                            TonWalletTransactionStatus.unstakingInProgress)
                      Text(
                        status.title,
                        style: theme.textStyles.labelXSmall
                            .copyWith(color: theme.colors.content3),
                      )
                    else
                      Text('', style: theme.textStyles.labelXSmall),
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
        );
      },
    );
  }

  Color _getColorValue(
    ThemeStyleV2 theme,
    TonWalletTransactionStatus status,
    bool isIncoming,
  ) {
    if (status == TonWalletTransactionStatus.waitingConfirmation) {
      return theme.colors.contentWarning;
    } else if (status == TonWalletTransactionStatus.expired ||
        status == TonWalletTransactionStatus.pending) {
      return theme.colors.content3;
    } else if (isIncoming) {
      return theme.colors.contentPositive;
    } else {
      return theme.colors.content0;
    }
  }
}
