import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

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
    final canCopy = copyValue != null;

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

    final child = SeparatedColumn(
      separatorSize: DimensSize.d4,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget,
        SeparatedRow(
          separatorSize: DimensSize.d16,
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
            if (canCopy)
              CommonIconWidget.svg(
                svg: Assets.images.copy.path,
                color: colors.blue,
              ),
          ],
        ),
      ],
    );

    if (canCopy && copyValue != null) {
      return PressScaleWidget(
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: copyValue!));
          if (copyMessage != null) {
            inject<MessengerService>().show(
              Message.successful(message: copyMessage!),
            );
          }
        },
        child: child,
      );
    }

    return child;
  }
}
