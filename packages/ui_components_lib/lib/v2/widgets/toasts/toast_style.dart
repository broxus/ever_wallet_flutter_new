import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class ToastStyle {
  ToastStyle.normal(ColorsPaletteV2 colors)
      // TODO(malochka): remove it after redisgn toasts
      : backgroundColor = const Color(0xff606060),
        borderColor = colors.borderAlpha,
        iconColor = colors.content3;

  ToastStyle.error(ColorsPaletteV2 colors)
      : backgroundColor = colors.backgroundNegative,
        borderColor = colors.borderNegative,
        iconColor = colors.contentNegative;

  ToastStyle.warning(ColorsPaletteV2 colors)
      : backgroundColor = colors.backgroundWarning,
        borderColor = colors.borderWarning,
        iconColor = colors.contentWarning;

  ToastStyle.success(ColorsPaletteV2 colors)
      : backgroundColor = colors.backgroundPositive,
        borderColor = colors.borderPositive,
        iconColor = colors.contentPositive;
  final Color backgroundColor;
  final Color iconColor;
  final Color borderColor;
}
