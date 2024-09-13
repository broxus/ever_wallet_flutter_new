import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template common_backgrounded_icon}
///
/// Default widget that allows display icon with background in squircle shape.
///
/// {@endtemplate}
class CommonBackgroundedIconWidget extends StatelessWidget {
  /// {@macro common_backgrounded_icon}
  const CommonBackgroundedIconWidget({
    super.key,
    this.icon,
    this.svg,
    this.size = DimensSize.d40,
    this.iconColor,
    this.iconSize,
    this.backgroundColor,
    this.squircleRadius = DimensRadius.xMedium,
    this.useDefaultColor = true,
  });

  /// Factory that allows creating widget with [IconData]
  factory CommonBackgroundedIconWidget.icon({
    required IconData icon,
    Color? backgroundColor,
    Color? iconColor,
    bool useDefaultColor = true,
    Key? key,
  }) =>
      CommonBackgroundedIconWidget(
        icon: icon,
        key: key,
        backgroundColor: backgroundColor,
        iconColor: iconColor,
        useDefaultColor: useDefaultColor,
      );

  /// Factory that allows creating widget with svg asset
  factory CommonBackgroundedIconWidget.svg({
    required String svg,
    Color? backgroundColor,
    Color? iconColor,
    bool useDefaultColor = true,
    Key? key,
  }) =>
      CommonBackgroundedIconWidget(
        svg: svg,
        key: key,
        backgroundColor: backgroundColor,
        iconColor: iconColor,
        useDefaultColor: useDefaultColor,
      );

  /// Data of icon that is used in [Icon]
  final IconData? icon;

  /// Path in assets directory to svg image
  final String? svg;

  /// Size for image
  final double? iconSize;

  /// Color of background that icon renders in, if not specified then
  /// [ColorsPalette.lightBlue] is used.
  final Color? backgroundColor;

  /// Color of image, if not specified then color of EverButtonStyleProvider
  /// is used, if it's absent too, it will try to [useDefaultColor] and if it's
  /// false, then icon renders its own color.
  ///
  /// Summary, steps of color selection:
  /// 1) [iconColor]
  /// 2) [useDefaultColor]
  /// 3) color from [EverButtonStyleProvider] (inside [CommonIconWidget])
  /// 4) default icon color
  final Color? iconColor;

  /// Size of container that icon renders in
  final double size;

  /// Radius of squircle border, default [DimensRadius.xMedium]
  final double squircleRadius;

  /// If true, then [ColorsPalette.blue] is used as [iconColor] if it
  /// is not provided.
  final bool useDefaultColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: backgroundColor ?? colors.lightBlue,
        shape: SquircleShapeBorder(cornerRadius: squircleRadius),
        child: Center(
          child: CommonIconWidget(
            icon: icon,
            svg: svg,
            size: iconSize,
            color: iconColor ?? (useDefaultColor ? colors.blue : null),
          ),
        ),
      ),
    );
  }
}
