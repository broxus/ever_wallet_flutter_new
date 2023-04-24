// ignore_for_file: public_member_api_docs
// ignore_for_file: unused_field
import 'dart:ui';

/// {@template colors_palette}
/// The palette of colors in the project.
/// This colors really used in app by appointment.
/// {@endtemplate}
class ColorsPalette {
  /// {@macro colors_palette}
  const ColorsPalette({
    required this.primaryTappableColor,
    required this.secondaryTappableColor,
  });

  /// Default color for buttons and tappable elements
  final Color primaryTappableColor;

  /// Secondary color for buttons and tappable elements
  final Color secondaryTappableColor;
}

class ColorsRes {
  static const transparent = _Colors.transparent;

  /// Background color for light theme
  static const lightBackgroundPrimary = _Colors.white;
  static const lightBackgroundOverlay = _Colors.neutral300Opacity60;

  /// Text color for light theme
  static const lightTextPrimary = _Colors.black;
  static const lightTextSecondary = _Colors.neutral300;
  static const lightTextTertiary = _Colors.neutral600;
  static const lightTextButtonPrimary = _Colors.white;
  static const lightTextButtonSecondary = _Colors.bluePrimary;
  static const lightTextNegative = _Colors.redPrimary;
  static const lightTextPositive = _Colors.greenPrimary;
  static const lightTextButtonPressed = _Colors.blue200;
  static const lightTextButtonDisabled = _Colors.blue800;

  /// Accent color for light theme
  static const lightAccentPrimary = _Colors.bluePrimary;
  static const lightAccentPrimaryPressed = _Colors.blue200;
  static const lightAccentPrimaryDisabled = _Colors.blue900;
  static const lightAccentSecondary = _Colors.blue950;
  static const lightAccentSecondaryPressed = _Colors.blue850;
  static const lightAccentSecondaryDisabled = _Colors.blue970;
  static const lightAccentTertiary = _Colors.blue950;
  static const lightAccentTertiaryPressed = _Colors.blue950;
  static const lightAccentTertiaryDisabled = _Colors.blue950;
  static const lightAccentWarning = _Colors.redPrimary;
  static const lightAccentWarningPressed = _Colors.red200;
  static const lightAccentWarningDisabled = _Colors.red900;

  /// Fill color for light theme
  static const lightFillingPrimary = _Colors.neutral600;
  static const lightFillingSecondary = _Colors.blue950;
  static const lightFillingIcons = _Colors.neutral600;
  static const lightFillingHover = _Colors.neutral900;

  /// Status color for light theme
  static const lightStatusPositiveTitle = _Colors.green300;
  static const lightStatusPositiveBackground = _Colors.green900;
  static const lightStatusMediumTitle = _Colors.yellow300;
  static const lightStatusMediumBackground = _Colors.yellow900;
  static const lightStatusNegativeTitle = _Colors.red300;
  static const lightStatusNegativeBackground = _Colors.red900;
}

/// List of all colors from nekoton's palette.
class _Colors {
  const _Colors._();

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const almostBlack = Color(0xFF010101);
  static const transparent = Color(0x00000000);
  static const almostTransparentWhite = Color(0x10000000);

  /// Yellow
  static const yellow300 = Color(0xFFB28501);
  static const yellowPrimary = Color(0xFFE6AC00);
  static const yellow900 = Color(0xFFFEF2CD);

  /// Green
  static const green300 = Color(0xFF398A39);
  static const greenPrimary = Color(0xFF4AB44A);
  static const green900 = Color(0xFFDEF1DE);

  /// Red
  static const red200 = Color(0xFF762331);
  static const red300 = Color(0xFFA53045);
  static const redPrimary = Color(0xFFD83F5A);
  static const red900 = Color(0xFFF7D7DD);

  /// Neutral
  static const neutral300 = Color(0xFF6C7078);
  static const neutral300Opacity60 = Color(0x996C7078);
  static const neutralPrimary = Color(0xFF8B909A);
  static const neutral600 = Color(0xFFA6AAB2);
  static const neutral900 = Color(0xFFF0F1F5);
  static const neutral950 = Color(0xFFF7F7F9);

  /// Blue
  static const blue200 = Color(0xFF183784);
  static const bluePrimary = Color(0xFF2B63F1);
  static const blue700 = Color(0xFF7D9FF7);
  static const blue800 = Color(0xFF96B2F9);
  static const blue850 = Color(0xFFB1C5FA);
  static const blue900 = Color(0xFFDAE4FD);
  static const blue950 = Color(0xFFECF1FE);
  static const blue970 = Color(0xFFF9FAFF);
}
