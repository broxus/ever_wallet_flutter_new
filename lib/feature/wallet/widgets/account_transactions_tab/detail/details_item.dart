import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget that displays title and content of transaction information.
class TonWalletTransactionDetailsItem extends StatelessWidget {
  const TonWalletTransactionDetailsItem({
    required this.title,
    this.content,
    this.contentChild,
    super.key,
    this.titleTrailingChild,
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

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    Widget titleWidget = Text(
      title,
      style: StyleRes.addRegular.copyWith(color: colors.textSecondary),
      overflow: TextOverflow.ellipsis,
      softWrap: false,
      maxLines: 1,
    );

    if (titleTrailingChild != null) {
      titleWidget = SeparatedRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleWidget,
          Expanded(child: titleTrailingChild!),
        ],
      );
    }

    return SeparatedColumn(
      separatorSize: DimensSize.d4,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget,
        if (content != null)
          Text(
            content!,
            style: StyleRes.primaryBold.copyWith(color: colors.textPrimary),
          ),
        if (contentChild != null) contentChild!,
      ],
    );
  }
}
