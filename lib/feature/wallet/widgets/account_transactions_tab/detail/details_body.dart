import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/widgets/ton_wallet_transaction_status_body.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

/// Body of transaction for Ton/Token Wallets that contains main information
/// about transaction (date, hash, value, fee, sender/recipient).
class WalletTransactionDetailsDefaultBody extends StatelessWidget {
  const WalletTransactionDetailsDefaultBody({
    required this.date,
    required this.recipientOrSender,
    required this.hash,
    required this.value,
    required this.fee,
    required this.status,
    required this.isIncoming,
    required this.type,
    this.comment,
    this.info,
    this.tonIconPath,
    this.tokenIconPath,
    this.price,
    this.expiresAt,
    this.transactionId,
    super.key,
  });

  /// Date of transaction
  final DateTime date;

  /// Address of recipient or sender, based on [isIncoming]
  final Address recipientOrSender;

  /// Flag that indicates direction of transaction
  final bool isIncoming;

  /// Transaction hash
  final String hash;

  /// Amount sended in transaction
  final Money value;

  /// Fee of transaction
  final Money fee;

  /// Status of transaction
  final TonWalletTransactionStatus status;

  final String type;

  /// Comment of transaction
  final String? comment;

  /// Type of transaction, that exists for TokenWallet
  final String? info;
  final String? tonIconPath;
  final String? tokenIconPath;
  final Fixed? price;
  final DateTime? expiresAt;
  final String? transactionId;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return ShapedContainerColumn(
      color: theme.colors.background1,
      mainAxisSize: MainAxisSize.min,
      separatorSize: DimensSize.d16,
      children: [
        const SizedBox.shrink(),
        _statusDateRow(context, theme),
        const CommonDivider(),
        WalletTransactionDetailsItem(
          title: LocaleKeys.typeWord.tr(),
          value: type,
        ),
        WalletTransactionDetailsItem(
          title: LocaleKeys.token.tr(),
          value: value.currency.symbol,
        ),
        WalletTransactionDetailsItem(
          title: LocaleKeys.amountWord.tr(),
          valueWidget: AmountWidget.fromMoney(
            amount: value,
            includeSymbol: false,
            sign: isIncoming
                ? LocaleKeys.plusSign.tr()
                : LocaleKeys.minusSign.tr(),
          ),
          iconPath: tokenIconPath,
          convertedValueWidget: price != null
              ? AmountWidget.dollars(
                  amount: value.exchangeToUSD(price!),
                  style: theme.textStyles.labelXSmall.copyWith(
                    color: theme.colors.content3,
                  ),
                )
              : null,
        ),
        WalletTransactionDetailsItem(
          title: LocaleKeys.networkFee.tr(),
          valueWidget: AmountWidget.fromMoney(
            amount: fee,
            includeSymbol: false,
          ),
          iconPath: tonIconPath,
          convertedValueWidget: AmountWidget.dollars(
            amount: fee.exchangeToUSD(price!, 5),
            style: theme.textStyles.labelXSmall.copyWith(
              color: theme.colors.content3,
            ),
          ),
        ),
        if (info != null)
          WalletTransactionDetailsItem(
            title: LocaleKeys.info.tr(),
            value: info,
          ),
        WalletTransactionDetailsItem(
          title: isIncoming
              ? LocaleKeys.senderWord.tr()
              : LocaleKeys.recipientWord.tr(),
          subtitle: recipientOrSender.toEllipseString(),
          icon: LucideIcons.copy,
          onPressed: () {
            _copy(
              context,
              recipientOrSender.address,
              LocaleKeys.valueCopiedExclamation.tr(
                args: [recipientOrSender.toEllipseString()],
              ),
            );
          },
        ),
        if (transactionId == null)
          WalletTransactionDetailsItem(
            title: LocaleKeys.hashId.tr(),
            subtitle: toEllipseString(hash),
            icon: LucideIcons.copy,
            onPressed: () {
              _copy(
                context,
                hash,
                LocaleKeys.valueCopiedExclamation.tr(args: [hash]),
              );
            },
          )
        else
          WalletTransactionDetailsItem(
            title: LocaleKeys.transactionId.tr(),
            subtitle: transactionId,
            icon: LucideIcons.copy,
            onPressed: () {
              _copy(
                context,
                transactionId!,
                LocaleKeys.valueCopiedExclamation.tr(args: [transactionId!]),
              );
            },
          ),
      ],
    );
  }

  Widget _statusDateRow(BuildContext context, ThemeStyleV2 theme) {
    final formatter = date.year == NtpTime.now().year
        ? DateFormat('MM.dd, HH:mm:ss', context.locale.languageCode)
        : DateFormat('MM.dd.y, HH:mm:ss', context.locale.languageCode);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    isIncoming
                        ? LocaleKeys.received.tr()
                        : LocaleKeys.sent.tr(),
                    style: theme.textStyles.headingMedium,
                  ),
                  const Spacer(),
                  status.chipByStatus,
                ],
              ),
              const SizedBox(height: DimensSizeV2.d4),
              Text(
                formatter.format(date),
                style: theme.textStyles.labelXSmall.copyWith(
                  color: theme.colors.content3,
                ),
                textAlign: TextAlign.right,
              ),
              if (expiresAt != null) const SizedBox(height: DimensSizeV2.d4),
              if (expiresAt != null)
                Text(
                  DateTimeUtils.formatExpirationDate(expiresAt!),
                  style: theme.textStyles.labelXSmall.copyWith(
                    color: theme.colors.content1,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _copy(BuildContext context, String value, String copyMessage) {
    Clipboard.setData(ClipboardData(text: value));
    inject<MessengerService>().show(
      Message.successful(context: context, message: copyMessage),
    );
  }
}
