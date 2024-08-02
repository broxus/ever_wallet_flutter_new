import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

///This class should be deleted after refactoring enter seed v2
class CommonInputStyleV2 {
  CommonInputStyleV2(
    ThemeStyleV2 themeStyleV2,
  )   : borderColor = themeStyleV2.colors.borderFocus,
        borderSuggestionColor = themeStyleV2.colors.borderAlpha,
        labelTextStyle = themeStyleV2.textStyles.labelSmall;

  final Color borderColor;
  final Color borderSuggestionColor;
  final TextStyle labelTextStyle;
}
