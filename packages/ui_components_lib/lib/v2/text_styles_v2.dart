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
        height: 64 / 52,
      ),
      displayMedium: TextStyle(
        color: colors.content0,
        fontSize: 44,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 52 / 44,
      ),
      displaySmall: TextStyle(
        color: colors.content0,
        fontSize: 36,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 44 / 36,
      ),
      headingXXLarge: TextStyle(
        color: colors.content0,
        fontSize: 36,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 44 / 36,
      ),
      headingXLarge: TextStyle(
        color: colors.content0,
        fontSize: 32,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 40 / 32,
      ),
      headingLarge: TextStyle(
        color: colors.content0,
        fontSize: 24,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 32 / 24,
      ),
      headingMedium: TextStyle(
        color: colors.content0,
        fontSize: 18,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 18,
      ),
      headingSmall: TextStyle(
        color: colors.content0,
        fontSize: 16,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 16,
      ),
      headingXSmall: TextStyle(
        color: colors.content0,
        fontSize: 14,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 14,
      ),
      labelLarge: TextStyle(
        color: colors.content0,
        fontSize: 18,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w500,
        height: 24 / 18,
      ),
      labelMedium: TextStyle(
        color: colors.content0,
        fontSize: 16,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w500,
        height: 20 / 16,
      ),
      labelSmall: TextStyle(
        color: colors.content0,
        fontSize: 14,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w500,
        height: 16 / 14,
      ),
      labelXSmall: TextStyle(
        color: colors.content0,
        fontSize: 12,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w500,
        height: 16 / 12,
      ),
      paragraphLarge: TextStyle(
        color: colors.content1,
        fontSize: 18,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w400,
        height: 24 / 18,
      ),
      paragraphMedium: TextStyle(
        color: colors.content1,
        fontSize: 16,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
      ),
      paragraphSmall: TextStyle(
        color: colors.content1,
        fontSize: 14,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
      ),
      paragraphXSmall: TextStyle(
        color: colors.content1,
        fontSize: 12,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w400,
        height: 20 / 12,
      ),
    );
