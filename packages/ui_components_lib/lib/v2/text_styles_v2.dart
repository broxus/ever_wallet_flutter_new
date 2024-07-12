import 'package:flutter/material.dart';

import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

const _interFamily = 'Inter';

class TextStylesV2 {
  TextStylesV2({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headingXXLarge,
    required this.headingXLarge,
    required this.headingLarge,
    required this.headingMedium,
    required this.headingSmall,
    required this.headingXSmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
    required this.labelXSmall,
    required this.paragraphLarge,
    required this.paragraphMedium,
    required this.paragraphSmall,
    required this.paragraphXSmall,
  });

  factory TextStylesV2.defaultTextStyles(ColorsPaletteV2 colors) {
    return _defaultTextStyles(colors);
  }

  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle headingXXLarge;
  final TextStyle headingXLarge;
  final TextStyle headingLarge;
  final TextStyle headingMedium;
  final TextStyle headingSmall;
  final TextStyle headingXSmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;
  final TextStyle labelXSmall;
  final TextStyle paragraphLarge;
  final TextStyle paragraphMedium;
  final TextStyle paragraphSmall;
  final TextStyle paragraphXSmall;
}

TextStylesV2 _defaultTextStyles(ColorsPaletteV2 colors) => TextStylesV2(
      displayLarge: TextStyle(
        color: colors.content0,
        fontSize: 52,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 0.02,
        letterSpacing: -0.88,
      ),
      displayMedium: TextStyle(
        color: colors.content0,
        fontSize: 44,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 0.03,
        letterSpacing: -0.75,
      ),
      displaySmall: TextStyle(
        color: colors.content0,
        fontSize: 36,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 0.03,
        letterSpacing: -0.61,
      ),
      headingXXLarge: TextStyle(
        color: colors.content0,
        fontSize: 36,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 0.03,
        letterSpacing: -0.58,
      ),
      headingXLarge: TextStyle(
        color: colors.content0,
        fontSize: 32,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 0.04,
        letterSpacing: -0.51,
      ),
      headingLarge: TextStyle(
        color: colors.content0,
        fontSize: 24,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 0.06,
        letterSpacing: -0.34,
      ),
      headingMedium: TextStyle(
        color: colors.content0,
        fontSize: 18,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 0.07,
        letterSpacing: -0.22,
      ),
      headingSmall: TextStyle(
        color: colors.content0,
        fontSize: 16,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 0.09,
        letterSpacing: -0.10,
      ),
      headingXSmall: TextStyle(
        color: colors.content0,
        fontSize: 14,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 0.12,
        letterSpacing: -0.01,
      ),
      labelLarge: TextStyle(
        color: colors.content0,
        fontSize: 14,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w500,
        height: 0.12,
        letterSpacing: -0.01,
      ),
      labelMedium: TextStyle(
        color: colors.content0,
        fontSize: 18,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w500,
        height: 0.07,
        letterSpacing: -0.22,
      ),
      labelSmall: TextStyle(
        color: colors.content0,
        fontSize: 16,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w500,
        height: 0.09,
        letterSpacing: -0.10,
      ),
      labelXSmall: TextStyle(
        color: colors.content0,
        fontSize: 14,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w500,
        height: 0.12,
        letterSpacing: -0.01,
      ),
      paragraphLarge: TextStyle(
        color: colors.content0,
        fontSize: 14,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 0.12,
        letterSpacing: -0.01,
      ),
      paragraphMedium: TextStyle(
        color: colors.content0,
        fontSize: 18,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 0.07,
        letterSpacing: -0.22,
      ),
      paragraphSmall: TextStyle(
        color: colors.content0,
        fontSize: 16,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 0.09,
        letterSpacing: -0.10,
      ),
      paragraphXSmall: TextStyle(
        color: colors.content0,
        fontSize: 14,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 0.12,
        letterSpacing: -0.01,
      ),
    );
