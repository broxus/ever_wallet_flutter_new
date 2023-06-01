// FROM https://github.com/flutter/flutter/pull/27523

// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Shape border that implements figma's squircle.
/// https://github.com/aloisdeniel/figma_squircle/issues/5
class SquircleShapeBorder extends ShapeBorder {
  /// Creates a continuous cornered rectangle border.
  ///
  /// The [cornerRadius] argument must not be null.
  const SquircleShapeBorder({this.cornerRadius = 0.0});

  /// The radius for each corner.
  ///
  /// The radius will be clamped to 0 if a value less than 0 is entered as the
  /// radius. By default the radius is 0. This value must not be null.
  ///
  /// Unlike [RoundedRectangleBorder], there is only a single radius value used
  /// to describe the radius for every corner.
  final double cornerRadius;

  Path path(Rect rect) {
    final calculatedCornerRadius = cornerRadius;

    var limitedRadius = 0.0;
    final width = rect.width;
    final height = rect.height;
    final centerX = rect.center.dx;
    final centerY = rect.center.dy;
    final double radius = math.max(0, calculatedCornerRadius);
    final minSideLength = math.min(rect.width, rect.height);

    // These equations give the x and y values for each of the 8 mid and corner
    // points on a rectangle.
    //
    // For example, leftX(k) will give the x value on the left side of the shape
    // that is precisely `k` distance from the left edge of the shape for the
    // predetermined 'limitedRadius' value.
    double leftX(double x) {
      return centerX + x * limitedRadius - width / 2;
    }

    double rightX(double x) {
      return centerX - x * limitedRadius + width / 2;
    }

    double topY(double y) {
      return centerY + y * limitedRadius - height / 2;
    }

    double bottomY(double y) {
      return centerY - y * limitedRadius + height / 2;
    }

    // Renders the default superelliptical rounded rect shape where there are
    // 4 straight edges and 4 90º corners. Approximately renders a superellipse
    // with an n value of 5.
    //
    // Paths and equations were inspired from the code listed on this website:
    // https://www.paintcodeapp.com/news/code-for-ios-7-rounded-rectangles
    //
    // The shape is drawn from the top midpoint to the upper right hand corner
    // in a clockwise fashion around to the upper left hand corner.
    Path bezierRoundedRect() {
      return Path()
        ..moveTo(leftX(1.52866483), topY(0))
        ..lineTo(rightX(1.52866471), topY(0))
        ..cubicTo(
          rightX(1.08849323),
          topY(0),
          rightX(0.86840689),
          topY(0),
          rightX(0.66993427),
          topY(0.06549600),
        )
        ..lineTo(rightX(0.63149399), topY(0.07491100))
        ..cubicTo(
          rightX(0.37282392),
          topY(0.16905899),
          rightX(0.16906013),
          topY(0.37282401),
          rightX(0.07491176),
          topY(0.63149399),
        )
        ..cubicTo(
          rightX(0),
          topY(0.86840701),
          rightX(0),
          topY(1.08849299),
          rightX(0),
          topY(1.52866483),
        )
        ..lineTo(rightX(0), bottomY(1.52866471))
        ..cubicTo(
          rightX(0),
          bottomY(1.08849323),
          rightX(0),
          bottomY(0.86840689),
          rightX(0.06549600),
          bottomY(0.66993427),
        )
        ..lineTo(rightX(0.07491100), bottomY(0.63149399))
        ..cubicTo(
          rightX(0.16905899),
          bottomY(0.37282392),
          rightX(0.37282401),
          bottomY(0.16906013),
          rightX(0.63149399),
          bottomY(0.07491176),
        )
        ..cubicTo(
          rightX(0.86840701),
          bottomY(0),
          rightX(1.08849299),
          bottomY(0),
          rightX(1.52866483),
          bottomY(0),
        )
        ..lineTo(leftX(1.52866483), bottomY(0))
        ..cubicTo(
          leftX(1.08849323),
          bottomY(0),
          leftX(0.86840689),
          bottomY(0),
          leftX(0.66993427),
          bottomY(0.06549600),
        )
        ..lineTo(leftX(0.63149399), bottomY(0.07491100))
        ..cubicTo(
          leftX(0.37282392),
          bottomY(0.16905899),
          leftX(0.16906013),
          bottomY(0.37282401),
          leftX(0.07491176),
          bottomY(0.63149399),
        )
        ..cubicTo(
          leftX(0),
          bottomY(0.86840701),
          leftX(0),
          bottomY(1.08849299),
          leftX(0),
          bottomY(1.52866483),
        )
        ..lineTo(leftX(0), topY(1.52866471))
        ..cubicTo(
          leftX(0),
          topY(1.08849323),
          leftX(0),
          topY(0.86840689),
          leftX(0.06549600),
          topY(0.66993427),
        )
        ..lineTo(leftX(0.07491100), topY(0.63149399))
        ..cubicTo(
          leftX(0.16905899),
          topY(0.37282392),
          leftX(0.37282401),
          topY(0.16906013),
          leftX(0.63149399),
          topY(0.07491176),
        )
        ..cubicTo(
          leftX(0.86840701),
          topY(0),
          leftX(1.08849299),
          topY(0),
          leftX(1.52866483),
          topY(0),
        )
        ..close();
    }

    // The ratio of the declared corner radius to the total affected pixels
    // along each axis to render the corner. For example if the declared radius
    // were 25px then totalAffectedCornerPixelRatio * 25 (~38) pixels would be
    // affected along each axis.
    //
    // It is also the multiplier where the resulting shape will be convex with
    // a height and width of any value. Below this value, noticeable clipping
    // will be seen at large rectangle dimensions.
    //
    // If the shortest side length to radius ratio drops below this value, the
    // radius must be lessened to avoid clipping (ie. concavity) of the shape.
    //
    // This value comes from the website where the other equations and curves
    // were found
    // (https://www.paintcodeapp.com/news/code-for-ios-7-rounded-rectangles).
    const totalAffectedCornerPixelRatio = 1.52865;

    // The ratio of the radius to the magnitude of pixels on a given side that
    // will be used to construct the two corners.
    const minimalUnclippedSideToCornerRadiusRatio =
        2.0 * totalAffectedCornerPixelRatio;

    // The multiplier of the radius in comparison to the smallest edge length
    // used to describe the minimum radius for this shape.
    //
    // This is multiplier used in the case of an extreme aspect ratio and a
    // small extent value. It can be less than
    // 'minimalUnclippedSideToCornerRadiusRatio' because there
    // are not enough pixels to render the clipping of the shape at this size so
    // it appears to still be concave (whereas mathematically it's convex).
    //
    // This value was determined by an eyeball comparison with the the native
    // iOS search bar.
    const minimalEdgeLengthSideToCornerRadiusRatio = 2;

    // The minimum edge length at which the corner radius multiplier must be at
    // its maximum so as to maintain the appearance of a concave shape with
    // continuous tangents around its perimeter.
    //
    // If the smallest edge length is less than this value, the dynamic radius
    // value can be made smaller than the 'maxMultiplier' while the rendered
    // shape still does not visually clip.
    //
    // This value was determined by an eyeball approximation.
    const minRadiusEdgeLength = 200;

    // As the minimum side edge length (where the round is occurring)
    // approaches 0, the limitedRadius approaches 2 so as to maximize
    // roundness (to make the shape with the largest radius that doesn't clip).
    // As the edge length approaches 200, the limitedRadius approaches ~3 –- the
    // multiplier of the radius value where the resulting shape is concave (ie.
    // does not visually clip) at any dimension.
    final multiplier = ui.lerpDouble(
      minimalEdgeLengthSideToCornerRadiusRatio,
      minimalUnclippedSideToCornerRadiusRatio,
      minSideLength / minRadiusEdgeLength,
    )!;
    limitedRadius = math.min(radius, minSideLength / multiplier);
    return bezierRoundedRect();
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return path(rect);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return path(rect);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  ShapeBorder scale(double t) {
    return SquircleShapeBorder(
      cornerRadius: cornerRadius * t,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is SquircleShapeBorder) {
      return SquircleShapeBorder(
        cornerRadius: ui.lerpDouble(a.cornerRadius, cornerRadius, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is SquircleShapeBorder) {
      return SquircleShapeBorder(
        cornerRadius: ui.lerpDouble(cornerRadius, b.cornerRadius, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  bool operator ==(Object other) {
    if (other is! SquircleShapeBorder) return false;
    return cornerRadius == other.cornerRadius;
  }

  @override
  int get hashCode => cornerRadius.hashCode;

  @override
  String toString() {
    return '$SquircleShapeBorder($cornerRadius)';
  }
}
