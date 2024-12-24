import 'package:flutter/material.dart';
import 'package:ui_components_lib/colors.dart';
import 'package:ui_components_lib/components/common/squircle/squircle_shape_border.dart';
import 'package:ui_components_lib/dimens.dart';
import 'package:ui_components_lib/theme_style.dart';

class ShapedContainer extends StatelessWidget {
  const ShapedContainer({
    required this.child,
    this.color,
    this.squircleRadius = DimensRadius.medium,
    this.margin = const EdgeInsets.symmetric(horizontal: DimensSize.d16),
    this.padding = const EdgeInsets.symmetric(
      horizontal: DimensSize.d16,
      vertical: DimensSize.d8,
    ),
    this.width,
    this.height,
    super.key,
  });

  /// Size of container.
  /// If null, container will be sized to fit its children.
  final double? width;
  final double? height;

  /// Outer padding of container, default is horizontal: DimensSize.d16
  final EdgeInsets margin;

  /// Inner padding of container, around content, default is all: DimensSize.d16
  final EdgeInsets padding;

  /// Color of the background of container, default is
  /// [ColorsPalette.backgroundSecondary].
  final Color? color;

  /// Radius of squircle shape, default is [DimensRadius.medium].
  final double squircleRadius;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Padding(
        padding: margin,
        child: Material(
          color: color ?? context.themeStyle.colors.backgroundSecondary,
          shape: SquircleShapeBorder(cornerRadius: squircleRadius),
          // padding here, because ContainerColumn changes alignment in bad way
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
