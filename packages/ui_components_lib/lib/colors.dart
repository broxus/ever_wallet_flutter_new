import 'dart:ui';

/// The palette of colors in the project.
/// This colors really used in app by appointment.
class ColorsPalette {
  const ColorsPalette({
    required this.primaryTappableColor,
    required this.secondaryTappableColor,
  });

  /// Default color for buttons and tappable elements
  final Color primaryTappableColor;
  final Color secondaryTappableColor;
}

/// List of all colors from nekoton's palette
class ColorsRes {
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const transparent = Color(0x00000000);

  /// Yellow
  static const yellowPrimary = Color(0xFFE6AC00);

  /// Green
  static const greenPrimary = Color(0xFF4AB44A);

  /// Red
  static const red200 = Color(0xFF762331);
  static const redPrimary = Color(0xFFD83F5A);
  static const red900 = Color(0xFFF7D7DD);

  /// Neutral
  static const neutralPrimary = Color(0xFF8B909A);

  /// Blue
  static const blue200 = Color(0xFF183784);
  static const bluePrimary = Color(0xFF2B63F1);
  static const blue800 = Color(0xFF96B2F9);
  static const blue850 = Color(0xFFB1C5FA);
  static const blue900 = Color(0xFFDAE4FD);
  static const blue950 = Color(0xFFECF1FE);
  static const blue970 = Color(0xFFF9FAFF);
}
