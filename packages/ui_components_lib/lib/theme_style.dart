import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Main theme in the application that must be used in all components.
///
/// To provide it to application, add it to default theme:
/// ```
/// ThemeData(
///   extensions: [ThemeStyle(...)],
/// )
/// ```dart
class ThemeStyle extends ThemeExtension<ThemeStyle> {
  ThemeStyle({
    required this.colors,
    required this.styles,
  });

  final ColorsPalette colors;
  final StylesPalette styles;

  /// Do not supported
  @override
  ThemeExtension<ThemeStyle> copyWith() => this;

  /// Do not supported
  @override
  ThemeExtension<ThemeStyle> lerp(
    ThemeExtension<ThemeStyle>? other,
    double t,
  ) =>
      this;
}

extension ThemeContextExtension on BuildContext {
  ThemeStyle get themeStyle {
    return Theme.of(this).extension<ThemeStyle>()!;
  }
}
