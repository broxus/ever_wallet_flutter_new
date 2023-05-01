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
    required this.backgroundPrimary,
    required this.backgroundOverlay,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textButtonPrimary,
    required this.textButtonSecondary,
    required this.textNegative,
    required this.textPositive,
    required this.textButtonPressed,
    required this.textButtonDisabled,
    required this.accentPrimary,
    required this.accentPrimaryPressed,
    required this.accentPrimaryDisabled,
    required this.accentSecondary,
    required this.accentSecondaryPressed,
    required this.accentSecondaryDisabled,
    required this.accentTertiary,
    required this.accentTertiaryPressed,
    required this.accentTertiaryDisabled,
    required this.accentWarning,
    required this.accentWarningPressed,
    required this.accentWarningDisabled,
    required this.fillingPrimary,
    required this.fillingSecondary,
    required this.fillingTertiary,
    required this.fillingPressed,
    required this.statusPositiveTitle,
    required this.statusPositiveBackground,
    required this.statusMediumTitle,
    required this.statusMediumBackground,
    required this.statusNegativeTitle,
    required this.statusNegativeBackground,
  });

  /// Background color for theme
  final Color backgroundPrimary;
  final Color backgroundOverlay;

  /// Text color for theme
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textButtonPrimary;
  final Color textButtonSecondary;
  final Color textNegative;
  final Color textPositive;
  final Color textButtonPressed;
  final Color textButtonDisabled;

  /// Accent color for theme
  final Color accentPrimary;
  final Color accentPrimaryPressed;
  final Color accentPrimaryDisabled;
  final Color accentSecondary;
  final Color accentSecondaryPressed;
  final Color accentSecondaryDisabled;
  final Color accentTertiary;
  final Color accentTertiaryPressed;
  final Color accentTertiaryDisabled;
  final Color accentWarning;
  final Color accentWarningPressed;
  final Color accentWarningDisabled;

  /// Fill color for theme
  final Color fillingPrimary;
  final Color fillingSecondary;
  final Color fillingTertiary;
  final Color fillingPressed;

  /// Status color for theme
  final Color statusPositiveTitle;
  final Color statusPositiveBackground;
  final Color statusMediumTitle;
  final Color statusMediumBackground;
  final Color statusNegativeTitle;
  final Color statusNegativeBackground;
}

/// List of all colors from nekoton's palette.
class ColorsRes {
  const ColorsRes._();

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const transparent = Color(0x00000000);

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
  static const neutral700 = Color(0xFFB7BAC2);
  static const neutral900 = Color(0xFFF0F1F5);
  static const neutral950 = Color(0xFFF7F7F9);

  /// Blue
  static const lightBlue = Color(0xFFC5E4F3);
  static const blue200 = Color(0xFF183784);
  static const bluePrimary = Color(0xFF2B63F1);
  static const blue700 = Color(0xFF7D9FF7);
  static const blue800 = Color(0xFF96B2F9);
  static const blue850 = Color(0xFFB1C5FA);
  static const blue900 = Color(0xFFDAE4FD);
  static const blue950 = Color(0xFFECF1FE);
  static const blue970 = Color(0xFFF9FAFF);

  /// Dark theme
  static const dark060C32 = Color(0xFF060C32);
}
