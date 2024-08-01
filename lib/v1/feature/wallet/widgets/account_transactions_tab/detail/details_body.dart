import 'package:app/v1/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

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
    this.comment,
    this.type,
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

  /// Comment of transaction
  final String? comment;

  /// Type of transaction, that exists for TokenWallet
  final String? type;

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      separatorSize: DimensSize.d16,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
          child: Text(
            LocaleKeys.transactionInformation.tr(),
            style: StyleRes.h1
                .copyWith(color: context.themeStyle.colors.textPrimary),
          ),
        ),
        ShapedContainerColumn(
          mainAxisSize: MainAxisSize.min,
          separator: const Padding(
            padding: EdgeInsets.symmetric(vertical: DimensSize.d8),
            child: CommonDivider(),
          ),
          children: [
            _statusDateRow(),
            TonWalletTransactionDetailsItem(
              title: isIncoming
                  ? LocaleKeys.senderWord.tr()
                  : LocaleKeys.recipientWord.tr(),
              content: recipientOrSender.address,
              copyValue: recipientOrSender.address,
              copyMessage: LocaleKeys.valueCopiedExclamation.tr(
                args: [recipientOrSender.toEllipseString()],
              ),
            ),
            TonWalletTransactionDetailsItem(
              title: LocaleKeys.hashId.tr(),
              content: hash,
              copyValue: hash,
              copyMessage: LocaleKeys.valueCopiedExclamation.tr(args: [hash]),
            ),
            TonWalletTransactionDetailsItem(
              title: LocaleKeys.amountWord.tr(),
              contentChild: MoneyWidget(
                money: value,
                style: MoneyWidgetStyle.primary,
                sign: isIncoming ? 0 : -1,
              ),
            ),
            TonWalletTransactionDetailsItem(
              title: LocaleKeys.blockchainFee.tr(),
              contentChild:
                  MoneyWidget(money: fee, style: MoneyWidgetStyle.primary),
            ),
            if (comment != null && comment!.isNotEmpty)
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.commentWord.tr(),
                content: comment,
              ),
            if (type != null)
              TonWalletTransactionDetailsItem(
                title: LocaleKeys.typeWord.tr(),
                content: type,
              ),
          ],
        ),
      ],
    );
  }

  Widget _statusDateRow() {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;
        final formatter = date.year == NtpTime.now().year
            ? DateFormat('MM.dd, HH:mm', context.locale.languageCode)
            : DateFormat('MM.dd.y, HH:mm', context.locale.languageCode);

        final statusWidget = tonWalletTransactionStatusBody(status);

        return SeparatedRow(
          children: [
            if (statusWidget != null) statusWidget,
            Expanded(
              child: Text(
                formatter.format(date),
                style: StyleRes.addRegular.copyWith(
                  color: colors.textSecondary,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Body of transaction for TonWallet that contains additional information,
/// that is mapped based on transaction data.
class WalletTransactionAdditionalBody extends StatelessWidget {
  const WalletTransactionAdditionalBody({
    required this.children,
    this.type,
    super.key,
  });

  /// Type of transaction
  final String? type;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ShapedContainerColumn(
      mainAxisSize: MainAxisSize.min,
      separator: const Padding(
        padding: EdgeInsets.symmetric(vertical: DimensSize.d8),
        child: CommonDivider(),
      ),
      children: [
        if (type != null)
          TonWalletTransactionDetailsItem(
            title: LocaleKeys.typeWord.tr(),
            content: type,
          ),
        ...children,
      ],
    );
  }
}
