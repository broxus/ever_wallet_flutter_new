import 'dart:ui';

/// {@template colors_palette}
/// The palette of colors in the project.
/// This colors really used in app by appointment.
/// {@endtemplate}
class ColorsPalette {
  /// {@macro colors_palette}
  const ColorsPalette({
    required this.textPrimary,
    required this.textSecondary,
    required this.textContrast,
    required this.appBackground,
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.strokePrimary,
    required this.strokeSecondary,
    required this.strokeContrast,
    required this.alert,
    required this.apply,
    required this.blue,
    required this.blueSecond,
  });

  /// Text
  final Color textPrimary;
  final Color textSecondary;
  final Color textContrast;

  /// Background
  final Color appBackground;
  final Color backgroundPrimary;
  final Color backgroundSecondary;

  final Color strokePrimary;
  final Color strokeSecondary;
  final Color strokeContrast;

  final Color alert;
  final Color apply;
  final Color blue;
  final Color blueSecond;
}

/// List of all colors from nekoton's palette.
class ColorsRes {
  const ColorsRes._();

  static const transparent = Color(0x00000000);

  static const black = Color(0xFF222222);
  static const black343333 = Color(0xFF343333);
  static const black303030 = Color(0xFF303030);
  static const black454545 = Color(0xFF454545);
  static const black3C3C3C = Color(0xFF3C3C3C);

  static const white = Color(0xFFFFFFFF);
  static const whiteF3F3F3 = Color(0xFFF3F3F3);
  static const whiteF7F7F7 = Color(0xFFF7F7F7);
  static const whiteF4F2F2 = Color(0xFFF4F2F2);

  static const grey = Color(0xFFB3B3B3);
  static const grey898989 = Color(0xFF898989);
  static const greyE2E2E2 = Color(0xFFE2E2E2);

  static const redLight = Color(0xFFF32929);
  static const redDark = Color(0xFFEC4C4C);
  static const greenLight = Color(0xFF27B21A);
  static const greenDark = Color(0xFF26CC17);
  static const blue = Color(0xFF52B6D3);
  static const blueSecond = Color(0xFFA0C1C9);
}
