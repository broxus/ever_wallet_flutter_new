import 'package:flutter/material.dart';
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
    strokePrimary: ColorsRes.greyE2E2E2,
    strokeSecondary: ColorsRes.whiteF3F3F3,
    strokeContrast: ColorsRes.black,
    alert: ColorsRes.redLight,
    apply: ColorsRes.greenLight,
    blue: ColorsRes.blue,
    blueSecond: ColorsRes.blueSecond,
  );
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: colors.appBackground,
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
    strokePrimary: ColorsRes.black454545,
    strokeSecondary: ColorsRes.black3C3C3C,
    strokeContrast: ColorsRes.white,
    alert: ColorsRes.redDark,
    apply: ColorsRes.greenDark,
    blue: ColorsRes.blue,
    blueSecond: ColorsRes.blueSecond,
  );
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: colors.appBackground,
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

Map<EverButtonType, EverButtonStyle> _mapButtonStyle(ColorsPalette colors) {
  return {
    EverButtonType.primary: EverButtonStyle(
      backgroundColor: colors.backgroundPrimary,
      backgroundDisabledColor: colors.backgroundPrimary.withOpacity(0.5),
      contentColor: colors.textContrast,
      contentPressedColor: colors.textSecondary,
      contentDisabledColor: colors.textContrast,
    ),
    EverButtonType.secondary: EverButtonStyle(
      backgroundColor: colors.backgroundSecondary,
      backgroundDisabledColor: colors.backgroundSecondary.withOpacity(0.5),
      contentColor: colors.textPrimary,
      contentDisabledColor: colors.textPrimary.withOpacity(0.5),
      contentPressedColor: colors.textSecondary,
    ),
    EverButtonType.ghost: EverButtonStyle(
      backgroundColor: ColorsRes.transparent,
      contentColor: colors.textPrimary,
      contentDisabledColor: colors.textPrimary.withOpacity(0.5),
      backgroundDisabledColor: ColorsRes.transparent,
      contentPressedColor: colors.textSecondary,
    ),
  };
}
