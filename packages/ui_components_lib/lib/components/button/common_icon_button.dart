import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template common_icon_button}
/// This is a common button with icon inside
/// {@endtemplate}
class CommonIconButton extends StatelessWidget {
  /// {@macro common_icon_button}
  const CommonIconButton({
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    super.key,
    this.icon,
    this.svg,
    this.size,
    this.color,
    this.outerPadding,
    this.innerPadding,
  }) : assert(
          icon != null || svg != null,
          'IconData or Svg path must be specified',
        );

  /// Factory that allows create button with svg asset
  factory CommonIconButton.svg({
    required String svg,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    FocusNode? focusNode,
    Key? key,
    double? size,
    Color? color,
    EdgeInsets? outerPadding,
    EdgeInsets? innerPadding,
  }) =>
      CommonIconButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        focusNode: focusNode,
        key: key,
        svg: svg,
        size: size,
        color: color,
        outerPadding: outerPadding,
        innerPadding: innerPadding,
      );

  /// Factory that allows create button with [IconData]
  factory CommonIconButton.icon({
    required IconData icon,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    FocusNode? focusNode,
    Key? key,
    double? size,
    Color? color,
    EdgeInsets? outerPadding,
    EdgeInsets? innerPadding,
  }) =>
      CommonIconButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        focusNode: focusNode,
        key: key,
        icon: icon,
        size: size,
        color: color,
        outerPadding: outerPadding,
        innerPadding: innerPadding,
      );

  /// Callback when user tap button
  final VoidCallback? onPressed;

  /// Callback when user long pressed button
  final VoidCallback? onLongPress;

  /// Focus node for button that could be used in [FocusScope]
  final FocusNode? focusNode;

  /// Data of icon that is used in [Icon]
  final IconData? icon;

  /// Path in assets directory to svg image
  final String? svg;

  /// Size for image
  final double? size;

  /// Color of icon, if not specified, then [ColorsPalette.fillingTertiary]
  /// is used.
  final Color? color;

  /// Padding around ink effect, default 0
  final EdgeInsets? outerPadding;

  /// Padding around icon but inside ink effect, default 8
  final EdgeInsets? innerPadding;

  @override
  Widget build(BuildContext context) {
    final color = this.color ??
        (onPressed == null && onLongPress == null
            // TODO(alex-a4): change disabled color
            ? context.themeStyle.colors.fillingTertiary
            : context.themeStyle.colors.fillingTertiary);

    return Padding(
      padding: outerPadding ?? EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(90),
        onTap: onPressed,
        onLongPress: onLongPress,
        focusNode: focusNode,
        child: Padding(
          padding: innerPadding ?? const EdgeInsets.all(8),
          child: icon != null
              ? Icon(icon, color: color, size: size ?? 20)
              : SvgPicture.asset(
                  svg!,
                  theme: SvgTheme(
                    currentColor: color,
                    fontSize: size ?? 20,
                  ),
                ),
        ),
      ),
    );
  }
}
