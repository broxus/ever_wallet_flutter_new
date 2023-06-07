import 'package:flutter/material.dart';

import 'package:ui_components_lib/ui_components_lib.dart';

enum SelectionStatus { unfocus, focus, completed }

/// This is a widget, that allows user interact with selection field.
/// Widget displays different UI depends on [SelectionStatus] and let user
/// know how to interact with it.
class SelectionStatusInput extends StatefulWidget {
  const SelectionStatusInput({
    required this.title,
    required this.onPressed,
    required this.status,
    this.icon,
    super.key,
  });

  final String title;
  final SelectionStatus status;
  final VoidCallback? onPressed;
  final Widget? icon;

  @override
  State<SelectionStatusInput> createState() => _SelectionStatusInputState();
}

class _SelectionStatusInputState extends State<SelectionStatusInput> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    Color? backgroundColor;
    Color? borderColor;
    Color contentColor;

    switch (widget.status) {
      case SelectionStatus.unfocus:
        borderColor = colors.strokePrimary;
        contentColor = isPressed ? colors.textPrimary : colors.textSecondary;
      case SelectionStatus.focus:
        borderColor = colors.strokeContrast;
        contentColor = isPressed ? colors.textSecondary : colors.textPrimary;
      case SelectionStatus.completed:
        backgroundColor = colors.backgroundPrimary;
        contentColor = isPressed ? colors.textSecondary : colors.textContrast;
    }

    return EverButtonStyleProvider(
      contentColor: contentColor,
      child: SizedBox(
        width: double.infinity,
        height: commonButtonHeight,
        child: Material(
          color: backgroundColor ?? Colors.transparent,
          shape: SquircleBoxBorder(
            squircleRadius: DimensRadius.medium,
            borderSide: BorderSide(color: borderColor ?? Colors.transparent),
          ),
          child: InkWell(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onHighlightChanged: _triggerPressed,
            onTap: widget.onPressed,
            child: SeparatedRow(
              separator: const SizedBox(width: DimensSize.d8),
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedColor(
                  color: contentColor,
                  duration: kThemeAnimationDuration,
                  builder: (_, color) {
                    return Text(
                      widget.title,
                      style: StyleRes.button.copyWith(color: color),
                    );
                  },
                ),
                if (widget.icon != null) widget.icon!,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _triggerPressed(bool isPressed) {
    if (isPressed != this.isPressed) {
      setState(() => this.isPressed = isPressed);
    }
  }
}
