import 'package:flutter/material.dart';

/// Type of button that could be used in app.
/// If you add new type, don't forget to add it to style mapper
enum EverButtonType {
  /// Button with primary style
  primary,

  /// Button with secondary style
  secondary,

  /// Button with ghost style
  ghost,
}

/// {@template button_style}
/// Style of colors in button for <CommonButton>
/// {@endtemplate}
class EverButtonStyle {
  /// {@macro button_style}
  const EverButtonStyle({
    required this.backgroundColor,
    required this.backgroundDisabledColor,
    required this.contentColor,
    required this.contentDisabledColor,
    required this.contentPressedColor,
  });

  /// Color for button when it's enabled
  final Color backgroundColor;

  /// Color for button when it's disabled
  final Color backgroundDisabledColor;

  /// Color of button content when it's enabled (text and icons)
  final Color contentColor;

  /// Color of button content when button is pressed
  final Color contentPressedColor;

  /// Color of button content when button is disabled
  final Color contentDisabledColor;
}

/// {@template button_style_mapper}
/// Widget that provided EverButtonStyle down to the tree, used inside
/// of <CommonButton>
/// {@endtemplate}
class EverButtonStyleProvider extends InheritedWidget {
  /// {@macro button_style_mapper}
  const EverButtonStyleProvider({
    required super.child,
    required this.contentColor,
    super.key,
  });

  /// Style of button
  final Color contentColor;

  /// Get information about button style from context
  static EverButtonStyleProvider of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<EverButtonStyleProvider>();
    assert(
      result != null,
      'No EverButtonStyleProvider found in context',
    );

    return result!;
  }

  /// Get information about button style from context if it provided
  static EverButtonStyleProvider? ofNullable(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<EverButtonStyleProvider>();
  }

  @override
  bool updateShouldNotify(EverButtonStyleProvider oldWidget) =>
      oldWidget.contentColor != contentColor;
}
