import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget of icon that allows you to put SvgPicture or Icon in [CommonButton].
///
/// ```
/// CommonButton(
///   leading: CommonButtonIconWidget(svg: 'assets/star.svg'),
/// )
/// ```dart
class CommonButtonIconWidget extends StatelessWidget {
  const CommonButtonIconWidget({
    this.icon,
    this.svg,
    this.size,
    super.key,
  }) : assert(
          icon != null || svg != null,
          'IconData or Svg path must be specified',
        );

  /// Data of icon that is used in [Icon]
  final IconData? icon;

  /// Path in assets directory to svg image
  final String? svg;

  /// Size for image
  final double? size;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = EverButtonStyleProvider.of(context);
    final isDisabled = buttonStyle.isDisabled;
    final style = buttonStyle.style;

    final color = isDisabled
        ? style.contentDisabledColor ?? style.contentColor
        : style.contentColor;

    if (icon != null) {
      return Icon(icon, color: color, size: size ?? 20);
    }

    return SvgPicture.asset(
      svg!,
      theme: SvgTheme(currentColor: color, fontSize: size ?? 20),
    );
  }
}
