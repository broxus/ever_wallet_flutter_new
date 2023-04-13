import 'package:flutter/material.dart';

/// Type of button that could be used in app.
/// If you add new type, don't forget to add it to style mapper
enum EverButtonType {
  /// Button with primary style
  primary,

  /// Button with secondary style
  secondary,

  /// Button with tertiary style
  tertiary,

  /// Button with ghost style
  ghost,

  /// Button with ghost style without padding
  ghostNoPadding,

  /// Button that if used as delete action or something like that
  attention,
}

/// {@template button_style}
/// Style of colors in button for <CommonButton>
/// {@endtemplate}
class EverButtonStyle {
  /// {@macro button_style}
  const EverButtonStyle({
    required this.backgroundColor,
    required this.splashColor,
    required this.disabledBackgroundColor,
    required this.contentColor,
    this.contentDisabledColor,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.border,
    this.disabledBorder,
  });

  /// Color for button when it's enabled
  final Color backgroundColor;

  /// Color for button when it's disabled (no any press events
  final Color disabledBackgroundColor;

  /// Color of splash when button is pressed
  final Color splashColor;

  /// Padding for button content
  final EdgeInsets contentPadding;

  /// Border for button when it's enabled
  final BoxBorder? border;

  /// Border for button when it's disabled
  final BoxBorder? disabledBorder;

  /// Color of button content when it's enabled (text and icons)
  final Color contentColor;

  /// If color not specified, [contentColor] will be used
  final Color? contentDisabledColor;
}

/// {@template button_style_mapper}
/// Widget that provided EverButtonStyle down to the tree, used inside
/// of <CommonButton>
/// {@endtemplate}
class EverButtonStyleProvider extends InheritedWidget {
  /// {@macro button_style_mapper}
  const EverButtonStyleProvider({
    required super.child,
    required this.style,
    required this.isDisabled,
    super.key,
  });

  /// Style of button
  final EverButtonStyle style;

  /// If button is disabled that moment
  final bool isDisabled;

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

  @override
  bool updateShouldNotify(EverButtonStyleProvider oldWidget) =>
      oldWidget.style != style && oldWidget.isDisabled != isDisabled;
}
