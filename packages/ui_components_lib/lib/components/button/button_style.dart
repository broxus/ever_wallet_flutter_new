import 'package:flutter/material.dart';

/// Type of button that could be used in app.
/// If you add new type, don't forget to add it to style mapper
enum EverButtonType {
  primary,
  secondary,
  tertiary,
  ghost,
  ghostNoPadding,
  attention,
}

/// Style of colors in button for <CommonButton>
class EverButtonStyle {
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

  final Color backgroundColor;
  final Color disabledBackgroundColor;

  final Color splashColor;
  final EdgeInsets contentPadding;

  final BoxBorder? border;
  final BoxBorder? disabledBorder;

  final Color contentColor;

  /// If color not specified, [contentColor] will be used
  final Color? contentDisabledColor;
}

/// Widget that provided EverButtonStyle down to the tree, used inside
/// of <CommonButton>
class EverButtonStyleProvider extends InheritedWidget {
  const EverButtonStyleProvider({
    required super.child,
    required this.style,
    required this.isDisabled,
    super.key,
  });

  final EverButtonStyle style;
  final bool isDisabled;

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
