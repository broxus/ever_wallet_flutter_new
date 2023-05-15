import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template press_ink_widget}
/// Ink effect for default widgets with ink response
/// {@endtemplate}
class PressInkWidget extends StatelessWidget {
  /// {@macro press_ink_widget}
  const PressInkWidget({
    super.key,
    this.onPressed,
    this.child,
    this.onLongPress,
    this.borderRadius = BorderRadius.zero,
    this.pressStateColor,
  });

  /// Child that must have ink effect
  final Widget? child;

  /// Color of ink effect, default [ColorsPalette.accentSecondaryPressed]
  final Color? pressStateColor;

  /// Pressed callback
  final VoidCallback? onPressed;

  /// Long pressed callback
  final VoidCallback? onLongPress;

  /// Radius of the ink effect, default 0
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final presState =
        pressStateColor ?? context.themeStyle.colors.accentSecondaryPressed;

    assert(debugCheckHasMaterial(context), 'No Material above PressInkWidget');

    return InkResponse(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: presState,
      highlightShape: BoxShape.rectangle,
      onLongPress: onLongPress,
      onTap: onPressed,
      borderRadius: borderRadius,
      child: child,
    );
  }
}
