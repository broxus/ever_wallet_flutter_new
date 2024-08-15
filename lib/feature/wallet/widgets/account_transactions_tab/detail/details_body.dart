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
import 'package:ui_components_lib/v2/dimens_v2.dart';
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
    this.price,
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
  final Fixed? price;

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
        const Divider(),
        WalletTransactionDetailsItem(
          title: LocaleKeys.typeWord.tr(),
          value: type,
        ),
        WalletTransactionDetailsItem(
          title: LocaleKeys.amountWord.tr(),
          valueWidget: AmountWidget.fromMoney(
            amount: value,
            sign: isIncoming ? '+' : '-',
          ),
          tonIconPath: tonIconPath,
          convertedValueWidget: price != null
              ? AmountWidget.fromMoney(
                  amount: value.exchangeToUSD(price!),
                  style: theme.textStyles.labelXSmall.copyWith(
                    color: theme.colors.content3,
                  ),
                  sign: '~ ',
                )
              : null,
        ),
        WalletTransactionDetailsItem(
          title: LocaleKeys.networkFee.tr(),
          valueWidget: AmountWidget.fromMoney(
            amount: fee,
            sign: '~ ',
          ),
          tonIconPath: tonIconPath,
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
              recipientOrSender.address,
              LocaleKeys.valueCopiedExclamation
                  .tr(args: [recipientOrSender.toEllipseString()]),
            );
          },
        ),
        WalletTransactionDetailsItem(
          title: LocaleKeys.hashId.tr(),
          subtitle: toEllipseString(hash),
          icon: LucideIcons.copy,
          onPressed: () {
            _copy(hash, LocaleKeys.valueCopiedExclamation.tr(args: [hash]));
          },
        ),
      ],
    );
  }

  Widget _statusDateRow(BuildContext context, ThemeStyleV2 theme) {
    final colors = context.themeStyle.colors;
    final formatter = date.year == NtpTime.now().year
        ? DateFormat('MM.dd, HH:mm:ss', context.locale.languageCode)
        : DateFormat('MM.dd.y, HH:mm:ss', context.locale.languageCode);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isIncoming ? LocaleKeys.received.tr() : LocaleKeys.sent.tr(),
              style: theme.textStyles.headingMedium,
            ),
            const SizedBox(height: DimensSizeV2.d4),
            Text(
              formatter.format(date),
              style: StyleRes.addRegular.copyWith(
                color: colors.textSecondary,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        const Spacer(),
        status.chipByStatus,
      ],
    );
  }

  void _copy(String value, String copyMessage) {
    Clipboard.setData(ClipboardData(text: value));
    inject<MessengerService>().show(
      Message.successful(message: copyMessage),
    );
  }
}

extension on Money {
  Money exchangeToUSD(Fixed price) => exchangeTo(
        ExchangeRate.fromFixed(
          price,
          fromCode: currency.code,
          toCode: 'USD',
          toScale: 10,
        ),
      );
}
