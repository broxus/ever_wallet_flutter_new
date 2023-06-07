import 'package:flutter/material.dart';
import 'package:ui_components_lib/components/common/common.dart';

/// Squircle shape border for inputs
class SquircleInputBorder extends InputBorder {
  SquircleInputBorder({
    required double squircleRadius,
    super.borderSide,
  }) : shape = SquircleShapeBorder(cornerRadius: squircleRadius);

  final SquircleShapeBorder shape;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      shape.getInnerPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      shape.getOuterPath(rect, textDirection: textDirection);

  @override
  void paint(
    Canvas canvas,
    Rect rect, {
    double? gapStart,
    double gapExtent = 0.0,
    double gapPercentage = 0.0,
    TextDirection? textDirection,
  }) {
    final paint = borderSide.toPaint();
    canvas.drawPath(getOuterPath(rect), paint);
  }

  @override
  SquircleInputBorder copyWith({BorderSide? borderSide}) => SquircleInputBorder(
        borderSide: borderSide ?? this.borderSide,
        squircleRadius: shape.cornerRadius,
      );

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(borderSide.width);
  }

  @override
  bool get isOutline => true;

  @override
  SquircleInputBorder scale(double t) => SquircleInputBorder(
        borderSide: borderSide.scale(t),
        squircleRadius: shape.cornerRadius * t,
      );
}
