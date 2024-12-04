import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
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
        color: theme.colors.background1,
        child: SeparatedColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _baseTransactionBody(theme),
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
                        TransactionIcon(
                          isIncoming: isIncoming,
                          isPending:
                              status == TonWalletTransactionStatus.expired,
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
                                color: _getColor(
                                  theme,
                                  status == TonWalletTransactionStatus.expired,
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
                    const SizedBox(height: DimensSizeV2.d6),
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
}

class TransactionIcon extends StatelessWidget {
  const TransactionIcon({
    required this.isPending,
    required this.isIncoming,
    super.key,
  });

  final bool isPending;
  final bool isIncoming;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final icon = isPending
        ? LucideIcons.timer
        : isIncoming
            ? LucideIcons.arrowDownLeft
            : LucideIcons.arrowUpRight;
    return Container(
      height: DimensSizeV2.d40,
      width: DimensSizeV2.d40,
      decoration: BoxDecoration(
        color: theme.colors.backgroundAlpha,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          size: DimensSizeV2.d20,
          color: _getColor(theme, isPending, isIncoming),
        ),
      ),
    );
  }
}

Color _getColor(ThemeStyleV2 theme, bool isPending, bool isIncoming) {
  if (isPending) {
    return theme.colors.contentWarning;
  } else if (isIncoming) {
    return theme.colors.contentPositive;
  } else {
    return theme.colors.content0;
  }
}
