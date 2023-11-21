import 'package:flutter/material.dart';

import 'package:ui_components_lib/ui_components_lib.dart';

const _cardDefaultHeight = DimensSize.d48;

/// Card that allow display information in a squircle box.
class CommonCard extends StatelessWidget {
  const CommonCard({
    this.titleChild,
    this.titleText,
    this.leadingChild,
    this.leadingText,
    super.key,
    this.height = _cardDefaultHeight,
    this.width = DimensSize.d168,
    this.borderColor,
    this.trailingChild,
    this.topSubtitleChild,
    this.topSubtitleText,
    this.padding,
    this.centerTitle = false,
    this.backgroundColor,
    this.alignment,
  });

  /// Custom widget or text that displays above title.
  /// For better displaying card with topSubtitle, use height >= 72.
  /// If height not specified, it automatically imply 72.
  final Widget? topSubtitleChild;
  final String? topSubtitleText;

  /// Custom widget or text that displays as main information
  final Widget? titleChild;
  final String? titleText;

  /// Custom widget or text that displays left from title
  final Widget? leadingChild;
  final String? leadingText;

  /// Widget that displays right from title
  final Widget? trailingChild;

  /// Height of card.
  /// If null, then it will try to wrap content, default [_cardDefaultHeight]
  final double? height;

  /// Width of card.
  /// If null, then it will try to wrap content, default [DimensSize.d168]
  final double? width;

  /// Color of card border
  final Color? borderColor;

  /// Default padding is horizontal: 12
  final EdgeInsets? padding;

  /// If title should be centered
  final bool centerTitle;

  /// Color of card
  final Color? backgroundColor;

  /// Alignment for content
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    Widget title;
    Widget? subtitle;
    if (titleChild != null) {
      title = titleChild!;
    } else if (titleText != null) {
      title = Text(
        titleText!,
        style: StyleRes.button.copyWith(color: colors.textPrimary),
      );
    } else {
      title = const SizedBox();
    }

    final hasTopSubtitle = topSubtitleChild != null || topSubtitleText != null;
    if (hasTopSubtitle) {
      final topSubtitle = topSubtitleChild != null
          ? topSubtitleChild!
          : Text(
              topSubtitleText!,
              style: StyleRes.addRegular.copyWith(color: colors.textSecondary),
            );
      title = SeparatedColumn(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        separatorSize: DimensSize.d4,
        children: [
          topSubtitle,
          title,
        ],
      );
    }

    if (leadingChild != null) {
      subtitle = leadingChild;
    } else if (leadingText != null) {
      subtitle = Text(
        leadingText!,
        style: StyleRes.addRegular.copyWith(color: colors.textSecondary),
      );
    }
    final padding =
        this.padding ?? const EdgeInsets.symmetric(horizontal: DimensSize.d12);

    return EverButtonStyleProvider(
      contentColor: colors.textSecondary,
      child: Material(
        shape: const SquircleShapeBorder(cornerRadius: DimensRadius.medium),
        color: backgroundColor ?? colors.backgroundSecondary,
        child: Container(
          alignment: alignment,
          width: width,
          height: height == _cardDefaultHeight && hasTopSubtitle
              ? DimensSize.d72
              : height,
          decoration: BoxDecoration(
            border: borderColor == null
                ? null
                : SquircleBoxBorder(
                    squircleRadius: DimensRadius.medium,
                    borderSide: BorderSide(color: borderColor!),
                  ),
          ),
          padding: padding,
          child: SeparatedRow(
            mainAxisSize: width == null ? MainAxisSize.min : MainAxisSize.max,
            children: [
              if (subtitle != null) subtitle,
              Expanded(child: centerTitle ? Center(child: title) : title),
              if (trailingChild != null) trailingChild!,
            ],
          ),
        ),
      ),
    );
  }
}
