import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template simple_button}
/// Default customizable button without predifined sizes
/// for internal puroses only.
///
/// Simple usages:
/// ```dart
/// SimpleButton(text: 'MyButton', height: 56, onPressed: (){})
/// ```
/// {@endtemplate}
class SimpleButton extends StatefulWidget {
  /// {@macro simple_button}
  const SimpleButton({
    required this.height,
    this.buttonType = EverButtonType.primary,
    this.text,
    this.onPressed,
    this.onLongPress,
    this.style,
    this.child,
    this.squircleRadius = defaultSquircleRadius,
    this.backgroundColor,
    this.padding,
    this.fillWidth = true,
    this.backgroundDisabledColor,
    this.contentColor,
    this.contentPressedColor,
    this.contentDisabledColor,
    this.textAlign,
    super.key,
  });

  /// Type of the button that is used to identify colors
  final EverButtonType buttonType;

  /// Text that will be used in Text widget with [style], if [style] not
  /// specified, style from theme will be used.
  /// If you want display custom widget, use [child].
  final String? text;

  /// Text style that will be used in Text widget.
  /// By default, used from style
  final TextStyle? style;

  /// Button tap and long tap callbacks
  final VoidCallback? onPressed;

  /// Long tap callback
  final VoidCallback? onLongPress;

  /// Alternative option to display custom widget instead of [text]
  final Widget? child;

  /// If button should fill all width
  final bool fillWidth;

  /// Radius of [SquircleShapeBorder], default 100
  final double squircleRadius;

  /// Height of the button
  final double height;

  /// Padding of the button content.
  /// Content default is horizontal: 20, loading default is horizontal: 50.
  final EdgeInsets? padding;

  /// Background color of the button, default is taken from style
  final Color? backgroundColor;

  /// Background color of the button when it is disabled, default is taken from
  /// style
  final Color? backgroundDisabledColor;

  /// Color of the button content, default is taken from style
  final Color? contentColor;

  /// Color of the button content when it is pressed, default is taken from
  final Color? contentPressedColor;

  /// Color of the button content when it is disabled, default is taken from
  final Color? contentDisabledColor;

  /// Alignment for text of button
  final TextAlign? textAlign;

  @override
  State<SimpleButton> createState() => _SimpleButtonState();
}

class _SimpleButtonState extends State<SimpleButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final styles = context.themeStyle.styles;
    final buttonStyle = styles.buttonsStyle[widget.buttonType]!;

    final isDisabled = widget.onPressed == null && widget.onLongPress == null;

    final contentColor = isDisabled
        ? (widget.contentDisabledColor ?? buttonStyle.contentDisabledColor)
        : isPressed
            ? (widget.contentPressedColor ?? buttonStyle.contentPressedColor)
            : (widget.contentColor ?? buttonStyle.contentColor);
    final textStyle = widget.style ?? styles.buttonTextStyle;
    final bgColor = isDisabled
        ? (widget.backgroundDisabledColor ??
            buttonStyle.backgroundDisabledColor)
        : (widget.backgroundColor ?? buttonStyle.backgroundColor);

    final child = widget.child ?? _textChild(textStyle, contentColor);

    return EverButtonStyleProvider(
      contentColor: contentColor,
      child: SizedBox(
        height: widget.height,
        child: Material(
          color: bgColor,
          shape: SquircleShapeBorder(cornerRadius: widget.squircleRadius),
          child: InkWell(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onHighlightChanged: _onHighlightChanged,
            onTap: widget.onPressed,
            onLongPress: widget.onLongPress,
            child: widget.fillWidth
                ? Center(child: child)
                : Row(mainAxisSize: MainAxisSize.min, children: [child]),
          ),
        ),
      ),
    );
  }

  void _onHighlightChanged(bool isPressed) {
    if (isPressed != this.isPressed) {
      setState(() => this.isPressed = isPressed);
    }
  }

  Widget _textChild(TextStyle textStyle, Color contentColor) {
    final textWidget = AnimatedColor(
      color: contentColor,
      duration: kThemeAnimationDuration,
      builder: (_, color) => Text(
        widget.text ?? '',
        textAlign: widget.textAlign,
        style: textStyle.copyWith(color: color),
      ),
    );

    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: textWidget,
    );
  }
}
