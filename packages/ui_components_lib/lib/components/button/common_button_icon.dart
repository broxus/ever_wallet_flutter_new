import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Default size for [CommonButtonIconWidget]
const defaultCommonIconSize = 20.0;

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
    final color = buttonStyle.contentColor;

    return AnimatedColor(
      color: color,
      duration: kThemeAnimationDuration,
      builder: (context, color) {
        return CommonIconWidget(
          icon: icon,
          svg: svg,
          size: size ?? defaultCommonIconSize,
          color: color,
        );
      },
    );
  }
}

/// {@template common_icon_widget}
///
/// Widget of icon that allows you to put SvgPicture or Icon.
///
/// {@endtemplate}
class CommonIconWidget extends StatelessWidget {
  /// {@macro common_icon_widget}
  const CommonIconWidget({
    this.icon,
    this.svg,
    this.size,
    super.key,
    this.color,
  }) : assert(
          icon != null || svg != null,
          'IconData or Svg path must be specified',
        );

  /// Factory that allows creating widget with [IconData]
  factory CommonIconWidget.icon({
    required IconData icon,
    double? size,
    Key? key,
  }) =>
      CommonIconWidget(icon: icon, size: size, key: key);

  /// Factory that allows creating widget with svg asset
  factory CommonIconWidget.svg({
    required String svg,
    double? size,
    Key? key,
  }) =>
      CommonIconWidget(svg: svg, size: size, key: key);

  /// Data of icon that is used in [Icon]
  final IconData? icon;

  /// Path in assets directory to svg image
  final String? svg;

  /// Size for image
  final double? size;

  /// Color of image, if not specified then color of image is used
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final contentColor =
        EverButtonStyleProvider.ofNullable(context)?.contentColor;

    final color = this.color ?? contentColor;

    if (icon != null) {
      return Icon(
        icon,
        color: color,
        size: size ?? defaultCommonIconSize,
      );
    }

    return SvgPicture.asset(
      svg!,
      colorFilter:
          color == null ? null : ui.ColorFilter.mode(color, ui.BlendMode.srcIn),
      theme: SvgTheme(fontSize: size ?? defaultCommonIconSize),
    );
  }
}
