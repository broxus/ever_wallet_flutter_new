import 'package:flutter/material.dart';

import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class ThemeStyleV2 extends ThemeExtension<ThemeStyleV2> {
  /// {@macro theme_style}
  ThemeStyleV2({
    required this.colors,
  });

  /// The palette of colors in the project.
  final ColorsPaletteV2 colors;

  /// Do not supported
  @override
  ThemeExtension<ThemeStyleV2> copyWith() => this;

  /// Do not supported
  @override
  ThemeExtension<ThemeStyleV2> lerp(
    ThemeExtension<ThemeStyleV2>? other,
    double t,
  ) =>
      this;
}

/// Getting theme style from context
extension ThemeContextExtension on BuildContext {
  ThemeStyleV2 get themeStyle {
    return Theme.of(this).extension<ThemeStyleV2>()!;
  }
}
