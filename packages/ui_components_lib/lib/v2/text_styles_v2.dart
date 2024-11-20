import 'package:flutter/material.dart';
import 'package:ui_components_lib/dimens.dart';
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
        fontSize: 52.spp,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 64 / 52,
        letterSpacing: -1.7,
      ),
      displayMedium: TextStyle(
        color: colors.content0,
        fontSize: 44.spp,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 52 / 44,
        letterSpacing: -1.7,
      ),
      displaySmall: TextStyle(
        color: colors.content0,
        fontSize: 36.spp,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 44 / 36,
        letterSpacing: -1.7,
      ),
      headingXXLarge: TextStyle(
        color: colors.content0,
        fontSize: 36.spp,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 44 / 36,
        letterSpacing: -1.6,
      ),
      headingXLarge: TextStyle(
        color: colors.content0,
        fontSize: 32.spp,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 40 / 32,
        letterSpacing: -1.6,
      ),
      headingLarge: TextStyle(
        color: colors.content0,
        fontSize: 24.spp,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 32 / 24,
        letterSpacing: -1.4,
      ),
      headingMedium: TextStyle(
        color: colors.content0,
        fontSize: 18.spp,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 18,
        letterSpacing: -1.2,
      ),
      headingSmall: TextStyle(
        color: colors.content0,
        fontSize: 16.spp,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 16,
        letterSpacing: -0.6,
      ),
      headingXSmall: TextStyle(
        color: colors.content0,
        fontSize: 14.spp,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w700,
        height: 24 / 14,
        letterSpacing: -0.1,
      ),
      labelLarge: TextStyle(
        color: colors.content0,
        fontSize: 18.spp,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w500,
        height: 24 / 18,
        letterSpacing: -0.9,
      ),
      labelMedium: TextStyle(
        color: colors.content0,
        fontSize: 16.spp,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w500,
        height: 20 / 16,
        letterSpacing: -0.6,
      ),
      labelSmall: TextStyle(
        color: colors.content0,
        fontSize: 14.spp,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w500,
        height: 16 / 14,
        letterSpacing: -0.1,
      ),
      labelXSmall: TextStyle(
        color: colors.content0,
        fontSize: 12.spp,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w500,
        height: 16 / 12,
        letterSpacing: 0,
      ),
      paragraphLarge: TextStyle(
        color: colors.content1,
        fontSize: 18.spp,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w400,
        height: 24 / 18,
        letterSpacing: -0.9,
      ),
      paragraphMedium: TextStyle(
        color: colors.content1,
        fontSize: 16.spp,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w400,
        height: 24 / 16,
        letterSpacing: -0.6,
      ),
      paragraphSmall: TextStyle(
        color: colors.content1,
        fontSize: 14.spp,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w400,
        height: 20 / 14,
        letterSpacing: -0.1,
      ),
      paragraphXSmall: TextStyle(
        color: colors.content1,
        fontSize: 12.spp,
        fontFamily: _interFamily,
        fontWeight: FontWeight.w400,
        height: 20 / 12,
        letterSpacing: 0,
      ),
    );
