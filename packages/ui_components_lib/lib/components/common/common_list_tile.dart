import 'package:flutter/material.dart';

import 'package:ui_components_lib/ui_components_lib.dart';

const _defaultListTileScaleRation = 2.5;
const _defaultSubtitleMaxLines = 2;

/// {@template common_list_tile}
///
/// Default ListTile for application with basic styling
///
/// {@endtemplate}
class CommonListTile extends StatelessWidget {
  /// {@macro common_list_tile}
  const CommonListTile({
    this.onPressed,
    this.onLongPressed,
    this.titleText,
    this.titleChild,
    this.subtitleText,
    this.subtitleChild,
    this.leading,
    this.trailing,
    super.key,
    this.height = DimensSize.d56,
    this.backgroundColor,
    this.squircleRadius = DimensRadius.xMedium,
    this.padding = const EdgeInsets.symmetric(horizontal: DimensSize.d8),
    this.contentColor,
    this.invertTitleSubtitleStyles = false,
    this.subtitleMaxLines = 2,
  });

  /// Press callback of tile
  final VoidCallback? onPressed;

  /// Long press callback of tile
  final VoidCallback? onLongPressed;

  /// Title text or title widget of tile, it renders above subtitle
  final String? titleText;
  final Widget? titleChild;

  /// Subtitle text or subtitle widget of tile, it renders under title.
  final String? subtitleText;
  final Widget? subtitleChild;

  /// Widget that renders on the left side of tile, typically it can be
  /// [CommonBackgroundedIconWidget].
  final Widget? leading;

  /// Widget that renders on the right side of tile
  final Widget? trailing;

  /// Default height of tile, [DimensSize.d56] by default.
  /// If height is null, then tile will wrap its content by height.
  final double? height;

  /// Background color of tile, [Colors.transparent] by default
  final Color? backgroundColor;

  /// Radius of squircle shape if [backgroundColor] is not null.
  final double squircleRadius;

  /// Padding of content inside tile, default is horizontal: DimensSize.d8.
  final EdgeInsets padding;

  /// Color of text and icons inside tile
  final Color? contentColor;

  /// If true, then title will contains [StyleRes.addRegular] style and subtitle
  /// will contains [StyleRes.button] style.
  /// false by default.
  final bool invertTitleSubtitleStyles;

  /// [Text.maxLines] paramether for [subtitleText], default 2
  final int? subtitleMaxLines;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    final title = titleText != null
        ? Text(
            titleText!,
            style: (invertTitleSubtitleStyles
                    ? StyleRes.addRegular
                    : StyleRes.button)
                .copyWith(
              color: contentColor ??
                  (invertTitleSubtitleStyles
                      ? colors.textSecondary
                      : colors.textPrimary),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          )
        : titleChild;

    final subtitle = subtitleText != null
        ? Text(
            subtitleText!,
            style: (invertTitleSubtitleStyles
                    ? StyleRes.button
                    : StyleRes.addRegular)
                .copyWith(
              color: contentColor ??
                  (invertTitleSubtitleStyles
                      ? colors.textPrimary
                      : colors.textSecondary),
            ),
            maxLines: subtitleMaxLines,
            overflow: subtitleMaxLines == null ? null : TextOverflow.ellipsis,
            softWrap: subtitleMaxLines == null,
          )
        : subtitleChild;

    return PressScaleWidget(
      onPressed: onPressed,
      onLongPress: onLongPressed,
      scaleRatio: _defaultListTileScaleRation,
      child: Material(
        color: backgroundColor ?? Colors.transparent,
        shape: backgroundColor == null
            ? null
            : SquircleShapeBorder(cornerRadius: squircleRadius),
        child: ContainerRow(
          padding: padding,
          height: height,
          children: [
            if (leading != null) leading!,
            Expanded(
              child: SeparatedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                separatorSize: DimensSize.d4,
                children: [
                  if (title != null) title,
                  if (subtitle != null) subtitle,
                ],
              ),
            ),
            if (trailing != null)
              EverButtonStyleProvider(
                contentColor: contentColor ?? colors.textSecondary,
                child: trailing!,
              ),
          ],
        ),
      ),
    );
  }
}
