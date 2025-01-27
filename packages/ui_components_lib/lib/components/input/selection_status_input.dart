import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/opac_v2.dart';

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
    final theme = context.themeStyleV2;
    Color? backgroundColor;
    Color? borderColor;
    Color contentColor;

    switch (widget.status) {
      case SelectionStatus.unfocus:
        borderColor = theme.colors.borderFocus.withAlpha(
          OpacV2.opac25.toByteInt(),
        );
        contentColor = isPressed
            ? theme.colors.content3.withAlpha(OpacV2.opac50.toByteInt())
            : theme.colors.content3.withAlpha(OpacV2.opac50.toByteInt());
      case SelectionStatus.focus:
        borderColor = theme.colors.borderFocus;
        contentColor =
            isPressed ? theme.colors.content3 : theme.colors.content3;
      case SelectionStatus.completed:
        backgroundColor = theme.colors.backgroundAccent;
        contentColor =
            isPressed ? theme.colors.content0 : theme.colors.content0;
    }

    return EverButtonStyleProvider(
      contentColor: contentColor,
      child: SizedBox(
        width: double.infinity,
        height: commonButtonHeight,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(DimensRadiusV2.theBiggest),
            border: Border.fromBorderSide(
              BorderSide(color: borderColor ?? Colors.transparent),
            ),
          ),
          child: InkWell(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onHighlightChanged: _triggerPressed,
            onTap: widget.onPressed,
            child: SeparatedRow(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedColor(
                  color: contentColor,
                  duration: kThemeAnimationDuration,
                  builder: (_, color) {
                    return Text(
                      widget.title,
                      style: theme.textStyles.labelSmall
                          .copyWith(color: contentColor),
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
