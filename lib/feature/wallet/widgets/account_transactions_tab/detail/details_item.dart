import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/data/wallet_prepare_transfer_asset.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Widget that displays title and content of transaction information.
class TonWalletTransactionDetailsItem extends StatelessWidget {
  const TonWalletTransactionDetailsItem({
    required this.title,
    this.content,
    this.contentChild,
    super.key,
    this.titleTrailingChild,
    this.copyMessage,
    this.copyValue,
  }) : assert(
          content == null && contentChild != null ||
              content != null && contentChild == null,
          'Content or contentChild must not be null',
        );

  /// Title for item
  final String title;

  /// Widget that displays right from [title]
  final Widget? titleTrailingChild;

  /// Content text of item, can be null if [contentChild] provided
  final String? content;

  /// Content widget of item, can be null if [content] provided.
  /// Typically, this is [MoneyWidget].
  final Widget? contentChild;

  /// Value that should be copied to clipboard
  final String? copyValue;

  /// Message that will be displayed during copy action
  final String? copyMessage;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    final theme = context.themeStyleV2;
    final canCopy = copyValue != null;

    //old implementation
    final Widget titleWidget = Text(
      title,
      style: theme.textStyles.labelSmall.copyWith(color: theme.colors.content3),
    );

    final child = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget,
        Row(
          children: [
            if (content != null)
              Expanded(
                child: Text(
                  content!,
                  style: StyleRes.primaryBold.copyWith(
                    color: canCopy ? colors.blue : colors.textPrimary,
                  ),
                ),
              ),
            if (contentChild != null) Expanded(child: contentChild!),
          ],
        ),
      ],
    );

    return child;
  }
}

class WalletTransactionDetailsItem extends StatelessWidget {
  const WalletTransactionDetailsItem({
    required this.title,
    this.subtitle,
    this.icon,
    this.value,
    this.valueWidget,
    this.onPressed,
    this.walletAsset,
    this.tonIconPath,
    this.convertedValueWidget,
    super.key,
  });

  final String title;
  final String? subtitle;
  final IconData? icon;
  final String? value;
  final Widget? valueWidget;
  final VoidCallback? onPressed;
  final WalletPrepareTransferAsset? walletAsset;
  final String? tonIconPath;
  final Widget? convertedValueWidget;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        constraints: const BoxConstraints(minHeight: DimensSizeV2.d40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textStyles.labelSmall
                      .copyWith(color: theme.colors.content3),
                ),
                const SizedBox(height: DimensSizeV2.d2),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: theme.textStyles.labelSmall,
                  ),
              ],
            ),
            if (icon != null)
              FloatButton(
                buttonShape: ButtonShape.square,
                icon: icon,
                onPressed: onPressed,
              ),
            if (icon == null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      if (walletAsset != null)
                        Padding(
                          padding:
                              const EdgeInsets.only(right: DimensSizeV2.d8),
                          child: TokenWalletIconWidget(
                            size: DimensSizeV2.d20,
                            address: walletAsset!.rootTokenContract,
                            logoURI: walletAsset!.logoURI,
                            version:
                                walletAsset!.version ?? TokenWalletVersion.tip3,
                          ),
                        ),
                      if (tonIconPath != null)
                        Padding(
                          padding:
                              const EdgeInsets.only(right: DimensSizeV2.d8),
                          child: TonWalletIconWidget(
                            path: tonIconPath!,
                            size: DimensSizeV2.d20,
                          ),
                        ),
                      if (value != null)
                        Text(
                          value!,
                          style: theme.textStyles.labelSmall,
                        ),
                      if (valueWidget != null) valueWidget!,
                    ],
                  ),
                  if (convertedValueWidget != null) ...[
                    const SizedBox(height: DimensSizeV2.d4),
                    convertedValueWidget!,
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
}