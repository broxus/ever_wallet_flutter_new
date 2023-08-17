import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Size of loading indicator for [CommonCircularProgressIndicator].
enum CircularIndicatorSize {
  small(DimensSize.d24),
  medium(DimensSize.d32),
  large(DimensSize.d48);

  const CircularIndicatorSize(this.value);

  final double value;
}

/// Common loading indicator with predefined sizes
class CommonCircularProgressIndicator extends StatelessWidget {
  const CommonCircularProgressIndicator({
    this.size = CircularIndicatorSize.medium,
    super.key,
  });

  final CircularIndicatorSize size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.value,
      width: size.value,
      child: Center(
        child: CircularProgressIndicator(
          color: context.themeStyle.colors.strokeContrast,
          strokeWidth: DimensStroke.medium,
        ),
      ),
    );
  }
}
