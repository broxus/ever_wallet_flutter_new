import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import 'package:ui_components_lib/ui_components_lib.dart';

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
          (icon != null || svg != null) && !(icon != null && svg != null),
          'IconData or Svg path must be specified, but not together',
        );

  /// Factory that allows creating widget with [IconData]
  factory CommonIconWidget.icon({
    required IconData icon,
    Color? color,
    double? size,
    Key? key,
  }) =>
      CommonIconWidget(
        icon: icon,
        size: size,
        key: key,
        color: color,
      );

  /// Factory that allows creating widget with svg asset
  factory CommonIconWidget.svg({
    required String svg,
    Color? color,
    double? size,
    Key? key,
  }) =>
      CommonIconWidget(
        svg: svg,
        size: size,
        key: key,
        color: color,
      );

  /// Data of icon that is used in [Icon]
  final IconData? icon;

  /// Path in assets directory to svg image
  final String? svg;

  /// Size for image
  final double? size;

  /// Color of image, if not specified then color of EverButtonStyleProvider
  /// is used, if it's absent too, then icon renders its own color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final contentColor = EverButtonStyleProvider.maybeOf(context)?.contentColor;

    final color = this.color ?? contentColor;

    if (icon != null) {
      return Icon(
        icon,
        color: color,
        size: size ?? defaultCommonIconSize,
      );
    }

    if (svg != null) {
      return SvgPicture.asset(
        svg!,
        colorFilter: color == null
            ? null
            : ui.ColorFilter.mode(color, ui.BlendMode.srcIn),
        theme: SvgTheme(fontSize: size ?? defaultCommonIconSize),
      );
    }

    return const SizedBox.shrink();
  }
}
