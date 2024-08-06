import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

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
    this.height = DimensSize.d56,
    this.backgroundColor,
    this.squircleRadius = DimensRadiusV2.radius16,
    this.padding = const EdgeInsets.symmetric(horizontal: DimensSizeV2.d8),
    this.contentColor,
    this.invertTitleSubtitleStyles = false,
    this.subtitleMaxLines = _defaultSubtitleMaxLines,
    super.key,
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

  /// If height is null, then tile will wrap its content by height.
  final double? height;

  /// Background color of tile, [Colors.transparent] by default
  final Color? backgroundColor;

  /// Radius of squircle shape if [backgroundColor] is not null.
  final double squircleRadius;

  /// Padding of content inside tile, default is horizontal: DimensSizeV2.d8.
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
    final theme = context.themeStyleV2;

    final subtitle = subtitleText != null
        ? Text(
            subtitleText!,
            style: (invertTitleSubtitleStyles
                    ? theme.textStyles.labelMedium
                    : theme.textStyles.labelXSmall)
                .copyWith(
              color: contentColor ??
                  (invertTitleSubtitleStyles
                      ? theme.colors.content0
                      : theme.colors.content3),
            ),
            maxLines: subtitleMaxLines,
            overflow: subtitleMaxLines == null ? null : TextOverflow.ellipsis,
            softWrap: subtitleMaxLines == null,
          )
        : subtitleChild;

    final title = titleText != null
        ? Text(
            titleText!,
            style: (invertTitleSubtitleStyles
                    ? theme.textStyles.labelXSmall
                    : theme.textStyles.labelMedium)
                .copyWith(
              color: contentColor ??
                  (invertTitleSubtitleStyles
                      ? theme.colors.content3
                      : theme.colors.content0),
            ),
            maxLines: subtitle == null ? null : 1,
            overflow: subtitle == null ? null : TextOverflow.ellipsis,
            softWrap: subtitle == null ? null : false,
          )
        : titleChild;

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
            Flexible(
              fit: trailing != null ? FlexFit.tight : FlexFit.loose,
              child: SeparatedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                separatorSize: DimensSizeV2.d4,
                children: [
                  if (title != null) title,
                  if (subtitle != null) subtitle,
                ],
              ),
            ),
            if (trailing != null)
              EverButtonStyleProvider(
                contentColor: contentColor ?? theme.colors.content0,
                child: trailing!,
              ),
          ],
        ),
      ),
    );
  }
}
