import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  static final balance = TextStyle(
    fontFamily: _interFamily,
    fontSize: 48.sp,
    height: 1.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.06,
    package: _uiComponentsLib,
  );

  /// H1 32 Bold
  static final h1 = TextStyle(
    fontFamily: _interFamily,
    fontSize: 32.sp,
    height: 1.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.06,
    package: _uiComponentsLib,
  );

  /// H2 20 Bold
  static final h2 = TextStyle(
    fontFamily: _interFamily,
    fontSize: 20.sp,
    height: 1.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.06,
    package: _uiComponentsLib,
  );

  /// Primary-Bold 16/24 SemiBold
  static final primaryBold = TextStyle(
    fontFamily: _interFamily,
    fontSize: 16.sp,
    height: 1.5.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.04,
    package: _uiComponentsLib,
  );

  /// Primary-Regular 16/24 Normal
  static final primaryRegular = TextStyle(
    fontFamily: _interFamily,
    fontSize: 16.sp,
    height: 1.5.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.04,
    package: _uiComponentsLib,
  );

  /// Secondary-Regular 14/18 Regular
  static final secondaryRegular = TextStyle(
    fontFamily: _interFamily,
    fontSize: 14.sp,
    height: 1.3.sp,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.04,
    package: _uiComponentsLib,
  );

  /// Secondary-Bold 14/18 SemiBold
  static final secondaryBold = TextStyle(
    fontFamily: _interFamily,
    fontSize: 14.sp,
    height: 1.3.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.04,
    package: _uiComponentsLib,
  );

  /// Add-Bold 12/16 SemiBold
  static final addBold = TextStyle(
    fontFamily: _interFamily,
    fontSize: 12.sp,
    height: 1.3.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.04,
    package: _uiComponentsLib,
  );

  /// Add-Regular 12/16 SemiBold
  static final addRegular = TextStyle(
    fontFamily: _interFamily,
    fontSize: 12.sp,
    height: 1.3.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.04,
    package: _uiComponentsLib,
  );

  /// Button 16 SemiBold
  static final button = TextStyle(
    fontFamily: _interFamily,
    fontSize: 16.sp,
    height: 1.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.04,
    package: _uiComponentsLib,
  );
}
