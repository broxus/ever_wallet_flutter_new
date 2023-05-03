import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template common_button_icon}
/// Widget of icon that allows you to put SvgPicture or Icon in [CommonButton].
///
/// ```
/// CommonButton(
///   leading: CommonButtonIconWidget.svg(svg: 'assets/star.svg'),
/// )
/// ```dart
/// {@endtemplate}
class CommonButtonIconWidget extends StatelessWidget {
  /// {@macro common_button_icon}
  const CommonButtonIconWidget({
    this.icon,
    this.svg,
    this.size,
    super.key,
  }) : assert(
          icon != null || svg != null,
          'IconData or Svg path must be specified',
        );

  /// Factory that allows creating widget with [IconData]
  factory CommonButtonIconWidget.icon({
    required IconData icon,
    double? size,
    Key? key,
  }) =>
      CommonButtonIconWidget(icon: icon, size: size, key: key);

  /// Factory that allows creating widget with svg asset
  factory CommonButtonIconWidget.svg({
    required String svg,
    double? size,
    Key? key,
  }) =>
      CommonButtonIconWidget(svg: svg, size: size, key: key);

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
