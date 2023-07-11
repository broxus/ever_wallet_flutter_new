import 'package:flutter/material.dart';

import 'package:ui_components_lib/ui_components_lib.dart';

/// Squircle border that can be used inside DecoratedBox or Container
class SquircleBoxBorder extends BoxBorder {
  SquircleBoxBorder({
    required double squircleRadius,
    // width 0.1 because if 0, it do not renders by DecoratedBox, by typically
    // we do not need this side anyway.
    this.borderSide = const BorderSide(color: Colors.transparent, width: 0.1),
  }) : shape = SquircleShapeBorder(cornerRadius: squircleRadius);

  final SquircleShapeBorder shape;
  final BorderSide borderSide;

  @override
  BorderSide get bottom => borderSide;

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
    TextDirection? textDirection,
    BoxShape shape = BoxShape.rectangle,
    BorderRadius? borderRadius,
  }) {
    final paint = borderSide.toPaint();
    canvas.drawPath(getOuterPath(rect), paint);
  }

  @override
  EdgeInsetsGeometry get dimensions {
    return EdgeInsets.all(borderSide.width);
  }

  @override
  SquircleInputBorder scale(double t) => SquircleInputBorder(
        borderSide: borderSide.scale(t),
        squircleRadius: shape.cornerRadius * t,
      );

  @override
  BorderSide get top => borderSide;

  @override
  bool get isUniform => true;
}
