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
    required this.loading,
    required this.strokePrimary,
    required this.strokeSecondary,
    required this.strokeContrast,
    required this.alert,
    required this.apply,
    required this.blue,
    required this.blueSecond,
    required this.labelYellow,
    required this.labelOrange,
    required this.lightBlue,
    required this.lightGreen,
    required this.lightOrange,
    required this.lightRed,
    required this.gradient,
  });

  /// Text
  final Color textPrimary;
  final Color textSecondary;
  final Color textContrast;

  /// Background
  final Color appBackground;
  final Color backgroundPrimary;
  final Color backgroundSecondary;
  final Color loading;

  /// Stroke
  final Color strokePrimary;
  final Color strokeSecondary;
  final Color strokeContrast;

  /// Additional, like accent
  final Color alert;
  final Color apply;
  final Color blue;
  final Color blueSecond;

  /// Info colors
  final Color labelYellow;
  final Color labelOrange;

  final Color lightBlue;
  final Color lightGreen;
  final Color lightOrange;
  final Color lightRed;

  /// Gradient
  final List<Color> gradient;
}

/// List of all colors from nekoton's palette.
class ColorsRes {
  const ColorsRes._();

  static const transparent = Color(0x00000000);

  static const gradientLight = <Color>[
    Color(0x00F7F7F7),
    Color(0xFFF7F7F7),
  ];
  static const gradientDark = <Color>[
    Color(0x00222222),
    Color(0xFF222222),
  ];

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
  static const greyE4E4E4 = Color(0xFFE4E4E4);
  static const grey3C3C3C = Color(0xFF3C3C3C);

  static const redLight = Color(0xFFF32929);
  static const redDark = Color(0xFFEC4C4C);
  static const redFDEDE5 = Color(0xFFFDEDE5);
  static const red443926 = Color(0xFF443926);

  static const greenLight = Color(0xFF27B21A);
  static const greenDark = Color(0xFF26CC17);
  static const greenE5F5E3 = Color(0xFFE5F5E3);
  static const green374236 = Color(0xFF374236);

  static const blue = Color(0xFF52B6D3);
  static const blueSecond = Color(0xFFA0C1C9);
  static const blueEAF6F9 = Color(0xFFEAF6F9);
  static const blue344347 = Color(0xFF344347);

  static const yellow = Color(0xFFE7A017);
  static const orange = Color(0xFFED6220);
  static const orangeFCF3E3 = Color(0xFFFCF3E3);
  static const orange463D2D = Color(0xFF463D2D);
}
