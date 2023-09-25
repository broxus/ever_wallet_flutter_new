import 'package:flutter/rendering.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const _interFamily = 'Inter';
const _uiComponentsLib = 'ui_components_lib';

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
  const StyleRes._();

  /// Balance 48 Semibold
  static const balance = TextStyle(
    fontFamily: _interFamily,
    fontSize: 48,
    height: 1,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.06,
    package: _uiComponentsLib,
  );

  /// H1 32 Bold
  static const h1 = TextStyle(
    fontFamily: _interFamily,
    fontSize: 32,
    height: 1,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.06,
    package: _uiComponentsLib,
  );

  /// H2 20 Bold
  static const h2 = TextStyle(
    fontFamily: _interFamily,
    fontSize: 20,
    height: 1,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.06,
    package: _uiComponentsLib,
  );

  /// Primary-Bold 16/24 SemiBold
  static const primaryBold = TextStyle(
    fontFamily: _interFamily,
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.04,
    package: _uiComponentsLib,
  );

  /// Primary-Regular 16/24 Normal
  static const primaryRegular = TextStyle(
    fontFamily: _interFamily,
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.04,
    package: _uiComponentsLib,
  );

  /// Secondary-Regular 14/18 Regular
  static const secondaryRegular = TextStyle(
    fontFamily: _interFamily,
    fontSize: 14,
    height: 1.3,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.04,
    package: _uiComponentsLib,
  );

  /// Secondary-Bold 14/18 SemiBold
  static const secondaryBold = TextStyle(
    fontFamily: _interFamily,
    fontSize: 14,
    height: 1.3,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.04,
    package: _uiComponentsLib,
  );

  /// Add-Bold 12/16 SemiBold
  static const addBold = TextStyle(
    fontFamily: _interFamily,
    fontSize: 12,
    height: 1.3,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.04,
    package: _uiComponentsLib,
  );

  /// Add-Regular 12/16 SemiBold
  static const addRegular = TextStyle(
    fontFamily: _interFamily,
    fontSize: 12,
    height: 1.3,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.04,
    package: _uiComponentsLib,
  );

  /// Button 16 SemiBold
  static const button = TextStyle(
    fontFamily: _interFamily,
    fontSize: 16,
    height: 1,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.04,
    package: _uiComponentsLib,
  );
}
