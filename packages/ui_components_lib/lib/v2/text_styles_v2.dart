import 'package:flutter/material.dart';

import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

const _interFamily = 'Inter';

class StylesPaletteV2 {
  const StylesPaletteV2(this.colors);

  final ColorsPaletteV2 colors;
}

class TextStylesV2 {
  const TextStylesV2(this.colors);

  final ColorsPaletteV2 colors;

  ///Display
  static const displayLarge = TextStyle(
    fontSize: 52,
    fontFamily: _interFamily,
    fontWeight: FontWeight.w700,
    height: 0.02,
    letterSpacing: -0.88,
  );

  static const displayMedium = TextStyle(
    fontSize: 44,
    fontFamily: _interFamily,
    fontWeight: FontWeight.w700,
    height: 0.03,
    letterSpacing: -0.75,
  );

  static const displaySmall = TextStyle(
    fontSize: 36,
    fontFamily: _interFamily,
    fontWeight: FontWeight.w700,
    height: 0.03,
    letterSpacing: -0.61,
  );

  ///Heading
  static const headingXXLarge = TextStyle(
    fontSize: 36,
    fontFamily: _interFamily,
    fontWeight: FontWeight.w700,
    height: 0.03,
    letterSpacing: -0.58,
  );

  static const headingXLarge = TextStyle(
    fontSize: 32,
    fontFamily: _interFamily,
    fontWeight: FontWeight.w700,
    height: 0.04,
    letterSpacing: -0.51,
  );

  static const headingLarge = TextStyle(
    fontSize: 24,
    fontFamily: _interFamily,
    fontWeight: FontWeight.w700,
    height: 0.06,
    letterSpacing: -0.34,
  );

  static const headingMedium = TextStyle(
    fontSize: 18,
    fontFamily: _interFamily,
    fontWeight: FontWeight.w700,
    height: 0.07,
    letterSpacing: -0.22,
  );

  static const headingSmall = TextStyle(
    fontSize: 16,
    fontFamily: _interFamily,
    fontWeight: FontWeight.w700,
    height: 0.09,
    letterSpacing: -0.10,
  );

  static const headingXSmall = TextStyle(
    fontSize: 14,
    fontFamily: _interFamily,
    fontWeight: FontWeight.w700,
    height: 0.12,
    letterSpacing: -0.01,
  );

  ///Label
  static const labelLarge = TextStyle(
    fontSize: 14,
    fontFamily: _interFamily,
    fontWeight: FontWeight.w700,
    height: 0.12,
    letterSpacing: -0.01,
  );

  static const labelMedium = TextStyle(
    fontSize: 18,
    fontFamily: _interFamily,
    fontWeight: FontWeight.w700,
    height: 0.07,
    letterSpacing: -0.22,
  );

  static const labelSmall = TextStyle(
    fontSize: 16,
    fontFamily: _interFamily,
    fontWeight: FontWeight.w700,
    height: 0.09,
    letterSpacing: -0.10,
  );

  static const labelXSmall = TextStyle(
    fontSize: 14,
    fontFamily: _interFamily,
    fontWeight: FontWeight.w700,
    height: 0.12,
    letterSpacing: -0.01,
  );

  ///Paragraph
  static const paragraphLarge = TextStyle(
    fontSize: 14,
    fontFamily: _interFamily,
    fontWeight: FontWeight.w700,
    height: 0.12,
    letterSpacing: -0.01,
  );

  static const paragraphMedium = TextStyle(
    fontSize: 18,
    fontFamily: _interFamily,
    fontWeight: FontWeight.w700,
    height: 0.07,
    letterSpacing: -0.22,
  );

  static const paragraphSmall = TextStyle(
    fontSize: 16,
    fontFamily: _interFamily,
    fontWeight: FontWeight.w700,
    height: 0.09,
    letterSpacing: -0.10,
  );

  static const paragraphXSmall = TextStyle(
    fontSize: 14,
    fontFamily: _interFamily,
    fontWeight: FontWeight.w700,
    height: 0.12,
    letterSpacing: -0.01,
  );
}
