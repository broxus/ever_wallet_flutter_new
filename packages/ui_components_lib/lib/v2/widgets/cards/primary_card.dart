import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class PrimaryCard extends StatelessWidget {
  const PrimaryCard({
    super.key,
    this.child,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.only(
      top: DimensSizeV2.d12,
      bottom: DimensSizeV2.d12,
      left: DimensSizeV2.d12,
      right: DimensSizeV2.d12,
    ),
    this.borderRadius,
    this.color,
  });

  final Widget? child;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Padding(
      padding: margin,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color ?? theme.colors.background1,
          borderRadius: borderRadius,
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
