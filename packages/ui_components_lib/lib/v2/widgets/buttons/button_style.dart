import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button.dart';

enum ButtonStyleType { ghost, accent, primary, float, destructive }

class AppButtonStyle {
  AppButtonStyle.ghost(ColorsPaletteV2 colors, TextStylesV2 textStyles)
      : backgroundColor = colors.backgroundAlpha,
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
        iconColor = colors.contentNegative,
        buttonTextStyle = textStyles.labelMedium,
        borderColor = colors.borderFocus.withOpacity(OpacV2.opac50);

  final Color backgroundColor;
  final Color iconColor;
  final TextStyle buttonTextStyle;
  final Color borderColor;
}

extension TypeToStyle on BaseButton {
  AppButtonStyle getButtonStyle(ThemeStyleV2 theme) {
    switch (runtimeType) {
      case GhostButton:
        return AppButtonStyle.ghost(theme.colors, theme.textStyles);
      case AccentButton:
        return AppButtonStyle.accent(theme.colors, theme.textStyles);
      case PrimaryButton:
        return AppButtonStyle.primary(theme.colors, theme.textStyles);
      case FloatButton:
        return AppButtonStyle.float(theme.colors, theme.textStyles);
      case DestructiveButton:
        return AppButtonStyle.destructive(theme.colors, theme.textStyles);
      default:
        return AppButtonStyle.ghost(theme.colors, theme.textStyles);
    }
  }
}
