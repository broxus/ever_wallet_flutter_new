import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget that can be used to display loading indicator
class CommonLoader extends StatelessWidget {
  const CommonLoader({
    required this.width,
    required this.height,
    this.borderRadius = DimensRadius.small,
    super.key,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: colors.loading,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
