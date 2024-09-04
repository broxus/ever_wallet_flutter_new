import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Default theme for ever app with light brightness
ThemeData getPredefinedLightTheme() {
  final colors = ColorsPaletteV2(
    primaryA: ColorsResV2.n100,
    primaryB: ColorsResV2.n10,
    accent: ColorsResV2.p60,
    negative: ColorsResV2.e70,
    warning: ColorsResV2.w70,
    positive: ColorsResV2.s75,
    background0: ColorsResV2.n10,
    background1: ColorsResV2.n20,
    background2: ColorsResV2.n30,
    background3: ColorsResV2.n35,
    backgroundAccent: ColorsResV2.p60,
    backgroundAlpha: ColorsResV2.n100.withOpacity(OpacV2.opac10),
    backgroundNegativeAlpha: ColorsResV2.e30.withOpacity(OpacV2.opac50),
    backgroundWarningAlpha: ColorsResV2.w40.withOpacity(OpacV2.opac50),
    backgroundPositiveAlpha: ColorsResV2.s25.withOpacity(OpacV2.opac50),
    content0: ColorsResV2.n100,
    content1: ColorsResV2.n70,
    content2: ColorsResV2.n65,
    content3: ColorsResV2.n60,
    border0: ColorsResV2.n35,
    border1: ColorsResV2.n40,
    border2: ColorsResV2.n50,
    borderAlpha: ColorsResV2.n100.withOpacity(OpacV2.opac10),
    borderFocus: ColorsResV2.n70.withOpacity(OpacV2.opac50),
    borderDisabled: ColorsResV2.n70.withOpacity(OpacV2.opac50),
    backgroundOverlay: ColorsResV2.n10.withOpacity(OpacV2.opac80),
    backgroundNegative: ColorsResV2.e30,
    backgroundWarning: ColorsResV2.w40,
    backgroundPositive: ColorsResV2.s25,
    contentNegative: ColorsResV2.e70,
    contentNegative1: ColorsResV2.e80,
    contentWarning: ColorsResV2.w70,
    contentWarning1: ColorsResV2.w80,
    contentPositive: ColorsResV2.s75,
    contentPositive1: ColorsResV2.s65,
    borderNegative: ColorsResV2.e40,
    borderWarning: ColorsResV2.w65,
    borderPositive: ColorsResV2.s40,
  );

  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: colors.background0,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(colors.primaryA),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return colors.accent;
        return colors.backgroundAlpha;
      }),
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
    extensions: [
      ThemeStyleV2(
        colors: colors,
        textStyles: TextStylesV2.defaultTextStyles(colors),
      ),
    ],
  );
}

/// Default theme for ever app with dark brightness
ThemeData getPredefinedDarkTheme() {
  final colors = ColorsPaletteV2(
    primaryA: ColorsResV2.n100,
    primaryB: ColorsResV2.n10,
    accent: ColorsResV2.p60,
    negative: ColorsResV2.e70,
    warning: ColorsResV2.w70,
    positive: ColorsResV2.s75,
    background0: ColorsResV2.n10,
    background1: ColorsResV2.n20,
    background2: ColorsResV2.n30,
    background3: ColorsResV2.n35,
    backgroundAccent: ColorsResV2.p60,
    backgroundAlpha: ColorsResV2.n100.withOpacity(OpacV2.opac10),
    backgroundNegativeAlpha: ColorsResV2.e30.withOpacity(OpacV2.opac50),
    backgroundWarningAlpha: ColorsResV2.w40.withOpacity(OpacV2.opac50),
    backgroundPositiveAlpha: ColorsResV2.s25.withOpacity(OpacV2.opac50),
    content0: ColorsResV2.n100,
    content1: ColorsResV2.n70,
    content2: ColorsResV2.n65,
    content3: ColorsResV2.n60,
    border0: ColorsResV2.n35,
    border1: ColorsResV2.n40,
    border2: ColorsResV2.n50,
    borderAlpha: ColorsResV2.n100.withOpacity(OpacV2.opac10),
    borderFocus: ColorsResV2.n70.withOpacity(OpacV2.opac50),
    borderDisabled: ColorsResV2.n70.withOpacity(OpacV2.opac50),
    backgroundOverlay: ColorsResV2.n10.withOpacity(OpacV2.opac80),
    backgroundNegative: ColorsResV2.e30,
    backgroundWarning: ColorsResV2.w40,
    backgroundPositive: ColorsResV2.s25,
    contentNegative: ColorsResV2.e70,
    contentNegative1: ColorsResV2.e80,
    contentWarning: ColorsResV2.w70,
    contentWarning1: ColorsResV2.w80,
    contentPositive: ColorsResV2.s75,
    contentPositive1: ColorsResV2.s65,
    borderNegative: ColorsResV2.e40,
    borderWarning: ColorsResV2.w65,
    borderPositive: ColorsResV2.s40,
  );

  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: colors.background0,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStatePropertyAll(colors.primaryA),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return colors.accent;
        return colors.backgroundAlpha;
      }),
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
    extensions: [
      ThemeStyleV2(
        colors: colors,
        textStyles: TextStylesV2.defaultTextStyles(colors),
      ),
    ],
  );
}

ThemeStyleV2 getDefaultTheme() {
  final colors = ColorsPaletteV2(
    primaryA: ColorsResV2.n100,
    primaryB: ColorsResV2.n10,
    accent: ColorsResV2.p60,
    negative: ColorsResV2.e70,
    warning: ColorsResV2.w70,
    positive: ColorsResV2.s75,
    background0: ColorsResV2.n10,
    background1: ColorsResV2.n20,
    background2: ColorsResV2.n30,
    background3: ColorsResV2.n35,
    backgroundAccent: ColorsResV2.p60,
    backgroundAlpha: ColorsResV2.n100.withOpacity(OpacV2.opac10),
    backgroundNegativeAlpha: ColorsResV2.e30.withOpacity(OpacV2.opac50),
    backgroundWarningAlpha: ColorsResV2.w40.withOpacity(OpacV2.opac50),
    backgroundPositiveAlpha: ColorsResV2.s25.withOpacity(OpacV2.opac50),
    content0: ColorsResV2.n100,
    content1: ColorsResV2.n70,
    content2: ColorsResV2.n65,
    content3: ColorsResV2.n60,
    border0: ColorsResV2.n35,
    border1: ColorsResV2.n40,
    border2: ColorsResV2.n50,
    borderAlpha: ColorsResV2.n100.withOpacity(OpacV2.opac10),
    borderFocus: ColorsResV2.n70.withOpacity(OpacV2.opac50),
    borderDisabled: ColorsResV2.n70.withOpacity(OpacV2.opac50),
    backgroundOverlay: ColorsResV2.n10.withOpacity(OpacV2.opac80),
    backgroundNegative: ColorsResV2.e30,
    backgroundWarning: ColorsResV2.w40,
    backgroundPositive: ColorsResV2.s25,
    contentNegative: ColorsResV2.e70,
    contentNegative1: ColorsResV2.e80,
    contentWarning: ColorsResV2.w70,
    contentWarning1: ColorsResV2.w80,
    contentPositive: ColorsResV2.s75,
    contentPositive1: ColorsResV2.s65,
    borderNegative: ColorsResV2.e40,
    borderWarning: ColorsResV2.w65,
    borderPositive: ColorsResV2.s40,
  );

  return ThemeStyleV2(
    colors: colors,
    textStyles: TextStylesV2.defaultTextStyles(colors),
  );
}
