import 'package:flutter/rendering.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template styles_palette}
/// The palette of styles in the project.
/// Text styles do not contains colors for elements, it must be added directly
/// in components.
/// {@endtemplate}
class StylesPalette {
  /// {@macro styles_palette}
  const StylesPalette({
    required this.buttonTextStyle,
    required this.buttonsStyle,
  });

  /// Basic texts
  final TextStyle buttonTextStyle;

  /// Default list of styles for buttons.
  final Map<EverButtonType, EverButtonStyle> buttonsStyle;
}

/// List of all styles from nekoton's typography
class StyleRes {
  /// Landing Title 44/48 Semibold
  static const landingTitle = TextStyle(
    fontFamily: 'Faktum',
    fontSize: 44,
    height: 1.09,
    fontWeight: FontWeight.w600,
  );

  /// Page title 28/32 Semibold
  static const pageTitle = TextStyle(
    fontFamily: 'Faktum',
    fontSize: 28,
    height: 1.14,
    fontWeight: FontWeight.w600,
  );

  /// H2 24/28 Semibold
  static const h2 = TextStyle(
    fontFamily: 'Faktum',
    fontSize: 24,
    height: 1.166,
    fontWeight: FontWeight.w500,
  );

  /// H3 18/24 Medium
  static const h3 = TextStyle(
    fontFamily: 'Faktum',
    fontSize: 18,
    height: 1.33,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  /// Body text 14/20 Regular
  static const bodyText = TextStyle(
    fontFamily: 'PT',
    fontSize: 14,
    height: 1.42,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
  );

  /// -----------------------------------------
  /// Bold group
  /// -----------------------------------------

  /// Bold 20/24
  static const bold20 = TextStyle(
    fontFamily: 'PT',
    fontSize: 20,
    height: 1.2,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.15,
  );

  /// Bold 16/20
  static const bold16 = TextStyle(
    fontFamily: 'PT',
    fontSize: 16,
    height: 1.25,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.25,
  );

  /// Bold 14/20
  static const bold14 = TextStyle(
    fontFamily: 'PT',
    fontSize: 14,
    height: 1.428,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.6,
  );

  /// Bold 12/16
  static const bold12 = TextStyle(
    fontFamily: 'PT',
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.75,
  );

  /// -----------------------------------------
  /// Medium group
  /// -----------------------------------------

  /// Medium 28/32
  static const medium28 = TextStyle(
    fontFamily: 'PT',
    fontSize: 28,
    height: 1.14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
  );

  /// Medium 20/24
  static const medium20 = TextStyle(
    fontFamily: 'PT',
    fontSize: 24,
    height: 1.2,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );

  /// Medium 18/24
  static const medium18 = TextStyle(
    fontFamily: 'PT',
    fontSize: 24,
    height: 1.33,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3,
  );

  /// Medium 16/22
  static const medium16 = TextStyle(
    fontFamily: 'PT',
    fontSize: 16,
    height: 1.375,
    fontWeight: FontWeight.w500,
  );

  /// Medium 14/20
  static const medium14 = TextStyle(
    fontFamily: 'PT',
    fontSize: 14,
    height: 1.428,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  /// Medium 14/20 Tabular
  static const medium14Tabular = TextStyle(
    fontFamily: 'PT',
    fontSize: 14,
    height: 1.428,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  /// Medium 12/16
  static const medium12 = TextStyle(
    fontFamily: 'PT',
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
  );

  /// Medium 12/16 Tabular
  static const medium12Tabular = TextStyle(
    fontFamily: 'PT',
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
  );

  /// -----------------------------------------
  /// Regular group
  /// -----------------------------------------

  /// Regular 24/28
  static const regular24 = TextStyle(
    fontFamily: 'PT',
    fontSize: 24,
    height: 1.16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  );

  /// Regular 20/24
  static const regular20 = TextStyle(
    fontFamily: 'PT',
    fontSize: 20,
    height: 1.2,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  );

  /// Regular 18/24
  static const regular18 = TextStyle(
    fontFamily: 'PT',
    fontSize: 18,
    height: 1.33,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.3,
  );

  /// Regular 16/22
  static const regular16 = TextStyle(
    fontFamily: 'PT',
    fontSize: 16,
    height: 1.375,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  /// Regular 14/20 Tabular
  static const regular14Tabular = TextStyle(
    fontFamily: 'PT',
    fontSize: 16,
    height: 1.428,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
  );

  /// Regular 12/16
  static const regular12 = TextStyle(
    fontFamily: 'PT',
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
  );
}
