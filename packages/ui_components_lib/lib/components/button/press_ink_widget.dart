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
    this.squircleRadius = 0,
    this.pressStateColor,
  });

  /// Child that must have ink effect
  final Widget? child;

  /// Color of ink effect, default [ColorsPalette.backgroundPrimary] 0.8 opacity
  final Color? pressStateColor;

  /// Pressed callback
  final VoidCallback? onPressed;

  /// Long pressed callback
  final VoidCallback? onLongPress;

  /// Radius for [SquircleShapeBorder], default 0
  final double squircleRadius;

  @override
  Widget build(BuildContext context) {
    final presState = pressStateColor ??
        context.themeStyle.colors.backgroundPrimary.withAlpha(0.8.toByteInt());

    assert(debugCheckHasMaterial(context), 'No Material above PressInkWidget');

    return InkResponse(
      customBorder: SquircleShapeBorder(cornerRadius: squircleRadius),
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: presState,
      highlightShape: BoxShape.rectangle,
      onLongPress: onLongPress,
      onTap: onPressed,
      child: child,
    );
  }
}
