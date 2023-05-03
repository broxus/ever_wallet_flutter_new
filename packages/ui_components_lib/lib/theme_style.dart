import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template theme_style}
/// Main theme in the application that must be used in all components.
///
/// To provide it to application, add it to default theme:
/// ```
/// ThemeData(
///   extensions: [ThemeStyle(...)],
/// )
/// ```dart
///
///
/// If you need to change theme in some direct place in the app (single screen
/// or widget) it would be better to override flutter tree theme
/// by wrapping your widget with [Theme] :
/// ```
/// Theme(
///   data: everPredefinedDarkTheme(),
///   child: MyScreenWithOtherTheme(),
/// );
/// ```dart
/// {@endtemplate}
class ThemeStyle extends ThemeExtension<ThemeStyle> {
  /// {@macro theme_style}
  ThemeStyle({
    required this.colors,
    required this.styles,
  });

  /// The palette of colors in the project.
  final ColorsPalette colors;

  /// The palette of styles in the project.
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

/// Getting theme style from context
extension ThemeContextExtension on BuildContext {
  /// Getter for [ThemeStyle]
  ThemeStyle get themeStyle {
    return Theme.of(this).extension<ThemeStyle>()!;
  }
}
