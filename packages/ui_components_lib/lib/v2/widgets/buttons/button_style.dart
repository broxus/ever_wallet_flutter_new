import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

//This class has some named constructors, every constructor has different
// value of fields, which will be used in BaseButton
class AppButtonStyle {
  AppButtonStyle.ghost(ColorsPaletteV2 colors, TextStylesV2 textStyles)
      : backgroundColor = ColorsResV2.transparent,
        iconColor = colors.content0,
        buttonTextStyle = textStyles.labelMedium,
        borderColor = colors.borderFocus.withAlpha(OpacV2.opac50.toByteInt());

  AppButtonStyle.accent(ColorsPaletteV2 colors, TextStylesV2 textStyles)
      : backgroundColor = colors.backgroundAccent,
        iconColor = colors.content0,
        buttonTextStyle = textStyles.labelMedium,
        borderColor = colors.borderFocus.withAlpha(OpacV2.opac50.toByteInt());

  AppButtonStyle.primary(ColorsPaletteV2 colors, TextStylesV2 textStyles)
      : backgroundColor = colors.background3,
        iconColor = colors.content0,
        buttonTextStyle = textStyles.labelMedium,
        borderColor = colors.borderFocus.withAlpha(OpacV2.opac50.toByteInt());

  AppButtonStyle.float(ColorsPaletteV2 colors, TextStylesV2 textStyles)
      : backgroundColor = colors.backgroundAlpha,
        iconColor = colors.content0,
        buttonTextStyle = textStyles.labelMedium,
        borderColor = colors.borderFocus.withAlpha(OpacV2.opac50.toByteInt());

  AppButtonStyle.destructive(ColorsPaletteV2 colors, TextStylesV2 textStyles)
      : backgroundColor = colors.backgroundNegative,
        iconColor = colors.content0,
        buttonTextStyle = textStyles.labelMedium,
        borderColor = colors.borderFocus.withAlpha(OpacV2.opac50.toByteInt());

  final Color backgroundColor;
  final Color iconColor;
  final TextStyle buttonTextStyle;
  final Color borderColor;
}
