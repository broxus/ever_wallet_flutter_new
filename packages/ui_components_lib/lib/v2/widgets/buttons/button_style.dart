import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

//This class has some named constructors, every constructor has different
// value of fields, which will be used in BaseButton
class AppButtonStyle {
  AppButtonStyle.ghost(ColorsPaletteV2 colors, TextStylesV2 textStyles)
      : backgroundColor = ColorsResV2.transparent,
        iconColor = colors.content0,
        buttonTextStyle = textStyles.labelMedium,
        borderColor = colors.borderFocus.withOpacity(OpacV2.opac50);

  AppButtonStyle.accent(ColorsPaletteV2 colors, TextStylesV2 textStyles)
      : backgroundColor = colors.backgroundAccent,
        iconColor = colors.content0,
        buttonTextStyle = textStyles.labelMedium,
        borderColor = colors.borderFocus.withOpacity(OpacV2.opac50);

  AppButtonStyle.primary(ColorsPaletteV2 colors, TextStylesV2 textStyles)
      : backgroundColor = colors.background3,
        iconColor = colors.content0,
        buttonTextStyle = textStyles.labelMedium,
        borderColor = colors.borderFocus.withOpacity(OpacV2.opac50);

  AppButtonStyle.float(ColorsPaletteV2 colors, TextStylesV2 textStyles)
      : backgroundColor = colors.backgroundAlpha,
        iconColor = colors.content0,
        buttonTextStyle = textStyles.labelMedium,
        borderColor = colors.borderFocus.withOpacity(OpacV2.opac50);

  AppButtonStyle.destructive(ColorsPaletteV2 colors, TextStylesV2 textStyles)
      : backgroundColor = colors.backgroundNegative,
        iconColor = colors.content0,
        buttonTextStyle = textStyles.labelMedium,
        borderColor = colors.borderFocus.withOpacity(OpacV2.opac50);

  final Color backgroundColor;
  final Color iconColor;
  final TextStyle buttonTextStyle;
  final Color borderColor;
}
