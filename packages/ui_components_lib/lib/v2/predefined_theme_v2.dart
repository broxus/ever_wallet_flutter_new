import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Default theme for ever app with light brightness
ThemeData everPredefinedLightTheme() {
  final colors = ColorsPaletteV2(
    primaryA: ColorsResV2.n100,
    primaryB: ColorsResV2.n10,
    accent: ColorsResV2.p70,
    negative: ColorsResV2.e70,
    warning: ColorsResV2.w70,
    positive: ColorsResV2.s75,
    background0: ColorsResV2.n10,
    background1: ColorsResV2.n20,
    background2: ColorsResV2.n30,
    background3: ColorsResV2.n35,
    content0: ColorsResV2.n100,
    content1: ColorsResV2.n70,
    content2: ColorsResV2.n65,
    content3: ColorsResV2.n60,
    border0: ColorsResV2.n35,
    border1: ColorsResV2.n40,
    border2: ColorsResV2.n50,
    borderAlpha: ColorsResV2.n100.withOpacity(OpacV2.opac10),
    borderFocus: ColorsResV2.p75,
    backgroundOverlay: ColorsResV2.n10.withOpacity(OpacV2.opac80),
    backgroundNegative: ColorsResV2.e30.withOpacity(OpacV2.opac50),
    backgroundWarning: ColorsResV2.w70,
    backgroundPositive: ColorsResV2.s45,
    contentNegative: ColorsResV2.e70.withOpacity(OpacV2.opac50),
    contentWarning: ColorsResV2.w30,
    contentPositive: ColorsResV2.s20,
    borderNegative: ColorsResV2.e40,
    borderWarning: ColorsResV2.w60,
    borderPositive: ColorsResV2.s55,
  );

  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: colors.background0,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    extensions: [
      ThemeStyleV2(
        colors: colors,
      ),
    ],
  );
}

/// Default theme for ever app with dark brightness
ThemeData everPredefinedDarkTheme() {
  final colors = ColorsPaletteV2(
    primaryA: ColorsResV2.n100,
    primaryB: ColorsResV2.n10,
    accent: ColorsResV2.p70,
    negative: ColorsResV2.e70,
    warning: ColorsResV2.w70,
    positive: ColorsResV2.s75,
    background0: ColorsResV2.n10,
    background1: ColorsResV2.n20,
    background2: ColorsResV2.n30,
    background3: ColorsResV2.n35,
    content0: ColorsResV2.n100,
    content1: ColorsResV2.n70,
    content2: ColorsResV2.n65,
    content3: ColorsResV2.n60,
    border0: ColorsResV2.n35,
    border1: ColorsResV2.n40,
    border2: ColorsResV2.n50,
    borderAlpha: ColorsResV2.n100.withOpacity(OpacV2.opac10),
    borderFocus: ColorsResV2.p75,
    backgroundOverlay: ColorsResV2.n10.withOpacity(OpacV2.opac80),
    backgroundNegative: ColorsResV2.e30.withOpacity(OpacV2.opac50),
    backgroundWarning: ColorsResV2.w70,
    backgroundPositive: ColorsResV2.s45,
    contentNegative: ColorsResV2.e70.withOpacity(OpacV2.opac50),
    contentWarning: ColorsResV2.w30,
    contentPositive: ColorsResV2.s20,
    borderNegative: ColorsResV2.e40,
    borderWarning: ColorsResV2.w60,
    borderPositive: ColorsResV2.s55,
  );

  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: colors.background0,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    extensions: [
      ThemeStyleV2(
        colors: colors,
      ),
    ],
  );
}
