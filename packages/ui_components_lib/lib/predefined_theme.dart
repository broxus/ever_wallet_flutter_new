import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Default theme for ever app with light brightness
ThemeData everPredefinedLightTheme() {
  const colors = ColorsPalette(
    textPrimary: ColorsRes.black,
    textSecondary: ColorsRes.grey,
    textContrast: ColorsRes.white,
    appBackground: ColorsRes.whiteF7F7F7,
    backgroundPrimary: ColorsRes.black,
    backgroundSecondary: ColorsRes.white,
    loading: ColorsRes.greyE4E4E4,
    strokePrimary: ColorsRes.greyE2E2E2,
    strokeSecondary: ColorsRes.whiteF3F3F3,
    strokeContrast: ColorsRes.black,
    alert: ColorsRes.redLight,
    apply: ColorsRes.greenLight,
    blue: ColorsRes.blue,
    blueSecond: ColorsRes.blueSecond,
    labelYellow: ColorsRes.yellow,
    labelOrange: ColorsRes.orange,
    lightBlue: ColorsRes.blueEAF6F9,
    lightGreen: ColorsRes.greenE5F5E3,
    lightOrange: ColorsRes.orangeFCF3E3,
    lightRed: ColorsRes.redFDEDE5,
    gradient: ColorsRes.gradientLight,
  );

  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: colors.appBackground,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    extensions: [
      ThemeStyle(
        colors: colors,
        styles: StylesPalette(
          buttonTextStyle: StyleRes.button,
          buttonsStyle: _mapButtonStyle(colors),
        ),
      ),
    ],
  );
}

/// Default theme for ever app with dark brightness
ThemeData everPredefinedDarkTheme() {
  const colors = ColorsPalette(
    textPrimary: ColorsRes.white,
    textSecondary: ColorsRes.grey898989,
    textContrast: ColorsRes.black,
    appBackground: ColorsRes.black,
    backgroundPrimary: ColorsRes.white,
    backgroundSecondary: ColorsRes.black303030,
    loading: ColorsRes.grey3C3C3C,
    strokePrimary: ColorsRes.black454545,
    strokeSecondary: ColorsRes.black3C3C3C,
    strokeContrast: ColorsRes.white,
    alert: ColorsRes.redDark,
    apply: ColorsRes.greenDark,
    blue: ColorsRes.blue,
    blueSecond: ColorsRes.blueSecond,
    labelYellow: ColorsRes.yellow,
    labelOrange: ColorsRes.orange,
    lightBlue: ColorsRes.blue344347,
    lightGreen: ColorsRes.green374236,
    lightOrange: ColorsRes.orange463D2D,
    lightRed: ColorsRes.red443926,
    gradient: ColorsRes.gradientDark,
  );

  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: colors.appBackground,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    extensions: [
      ThemeStyle(
        colors: colors,
        styles: StylesPalette(
          buttonTextStyle: StyleRes.button,
          buttonsStyle: _mapButtonStyle(colors),
        ),
      ),
    ],
  );
}

ThemeStyle getEverDefaultTheme() {
  const colors = ColorsPalette(
    textPrimary: ColorsRes.white,
    textSecondary: ColorsRes.grey898989,
    textContrast: ColorsRes.black,
    appBackground: ColorsRes.black,
    backgroundPrimary: ColorsRes.white,
    backgroundSecondary: ColorsRes.black303030,
    loading: ColorsRes.grey3C3C3C,
    strokePrimary: ColorsRes.black454545,
    strokeSecondary: ColorsRes.black3C3C3C,
    strokeContrast: ColorsRes.white,
    alert: ColorsRes.redDark,
    apply: ColorsRes.greenDark,
    blue: ColorsRes.blue,
    blueSecond: ColorsRes.blueSecond,
    labelYellow: ColorsRes.yellow,
    labelOrange: ColorsRes.orange,
    lightBlue: ColorsRes.blue344347,
    lightGreen: ColorsRes.green374236,
    lightOrange: ColorsRes.orange463D2D,
    lightRed: ColorsRes.red443926,
    gradient: ColorsRes.gradientDark,
  );

  return ThemeStyle(
    colors: colors,
    styles: StylesPalette(
      buttonTextStyle: StyleRes.button,
      buttonsStyle: _mapButtonStyle(colors),
    ),
  );
}

Map<EverButtonType, EverButtonStyle> _mapButtonStyle(ColorsPalette colors) {
  return {
    EverButtonType.primary: EverButtonStyle(
      backgroundColor: colors.backgroundPrimary,
      backgroundDisabledColor: colors.backgroundPrimary.withAlpha(
        Opac.medium.toByteInt(),
      ),
      contentColor: colors.textContrast,
      contentPressedColor: colors.textSecondary,
      contentDisabledColor: colors.textContrast,
    ),
    EverButtonType.secondary: EverButtonStyle(
      backgroundColor: colors.backgroundSecondary,
      backgroundDisabledColor:
          colors.backgroundSecondary.withAlpha(Opac.medium.toByteInt()),
      contentColor: colors.textPrimary,
      contentDisabledColor: colors.textPrimary.withAlpha(
        Opac.medium.toByteInt(),
      ),
      contentPressedColor: colors.textSecondary,
    ),
    EverButtonType.ghost: EverButtonStyle(
      backgroundColor: ColorsRes.transparent,
      contentColor: colors.textPrimary,
      contentDisabledColor: colors.textPrimary.withAlpha(
        Opac.medium.toByteInt(),
      ),
      backgroundDisabledColor: ColorsRes.transparent,
      contentPressedColor: colors.textSecondary,
    ),
  };
}
