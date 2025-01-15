import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Default height of the common button
const commonButtonHeight = DimensSize.d56;
const defaultSquircleRadius = DimensSize.d100;

/// {@template common_button}
/// Default button in the app with background.
/// Typically you do not need to specify text style or background color. It is
/// picked up from theme.
///
/// Simple usages:
/// ```
/// CommonButton.primary(text: 'MyButton', onPressed: (){})
/// ```dart
/// {@endtemplate}
class CommonButton extends StatefulWidget {
  /// {@macro common_button}
  const CommonButton({
    this.buttonType = EverButtonType.primary,
    this.text,
    this.onPressed,
    this.onLongPress,
    this.leading,
    this.trailing,
    this.style,
    this.child,
    this.focusNode,
    this.squircleRadius = defaultSquircleRadius,
    this.backgroundColor,
    this.height = commonButtonHeight,
    this.padding,
    this.fillWidth = true,
    this.isLoading = false,
    this.backgroundDisabledColor,
    this.contentColor,
    this.contentPressedColor,
    this.contentDisabledColor,
    this.textAlign,
    super.key,
  });

  /// CommonButton with primary style
  factory CommonButton.primary({
    String? text,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    Widget? leading,
    Widget? trailing,
    FocusNode? focusNode,
    bool isLoading = false,
    bool fillWidth = false,
  }) =>
      CommonButton(
        text: text,
        onPressed: onPressed,
        onLongPress: onLongPress,
        leading: leading,
        trailing: trailing,
        focusNode: focusNode,
        isLoading: isLoading,
        fillWidth: fillWidth,
      );

  /// CommonButton with secondary style
  factory CommonButton.secondary({
    String? text,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    Widget? leading,
    Widget? trailing,
    FocusNode? focusNode,
    bool isLoading = false,
    bool fillWidth = false,
  }) =>
      CommonButton(
        buttonType: EverButtonType.secondary,
        text: text,
        onPressed: onPressed,
        onLongPress: onLongPress,
        leading: leading,
        trailing: trailing,
        focusNode: focusNode,
        isLoading: isLoading,
        fillWidth: fillWidth,
      );

  /// CommonButton with ghost style
  factory CommonButton.ghost({
    String? text,
    EdgeInsets? padding,
    double? height,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    Widget? leading,
    Widget? trailing,
    FocusNode? focusNode,
    bool isLoading = false,
    bool fillWidth = false,
  }) =>
      CommonButton(
        buttonType: EverButtonType.ghost,
        text: text,
        onPressed: onPressed,
        onLongPress: onLongPress,
        leading: leading,
        trailing: trailing,
        focusNode: focusNode,
        isLoading: isLoading,
        fillWidth: fillWidth,
        height: height ?? commonButtonHeight,
        padding: padding,
      );

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

  /// Widgets that could be used before [text].
  /// Typically, use [CommonButtonIconWidget] that provides you color
  final Widget? leading;

  /// Widgets that could be used after [text].
  /// Typically, use [CommonButtonIconWidget] that provides you color
  final Widget? trailing;

  /// If button should display loading indicator instead of child, default false
  /// If true, callbacks won't work, but style will look like enabled.
  final bool isLoading;

  /// Alternative option to display custom widget instead of [text]
  final Widget? child;

  /// Focus node for button that could be used in [FocusScope]
  final FocusNode? focusNode;

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
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
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

    final child = widget.child == null
        ? (widget.isLoading
            ? _loadingChild(contentColor)
            : _textChild(textStyle, contentColor))
        : widget.child!;

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
            focusNode: widget.focusNode,
            onTap: widget.isLoading ? null : widget.onPressed,
            onLongPress: widget.isLoading ? null : widget.onLongPress,
            child: widget.fillWidth
                ? Center(child: child)
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [Flexible(child: child)],
                  ),
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

  Widget _loadingChild(Color contentColor) {
    return Padding(
      padding: widget.padding ??
          const EdgeInsets.symmetric(horizontal: DimensSize.d48),
      child: SizedBox(
        width: DimensSize.d20,
        height: DimensSize.d20,
        child: CircularProgressIndicator(
          color: contentColor,
          strokeWidth: DimensStroke.medium,
        ),
      ),
    );
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
      padding: widget.padding ??
          const EdgeInsets.symmetric(
            horizontal: DimensSize.d20,
          ),
      child: widget.leading == null && widget.trailing == null
          ? textWidget
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.leading != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      right: DimensSize.d8,
                    ),
                    child: widget.leading,
                  ),
                Flexible(child: textWidget),
                if (widget.trailing != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: DimensSize.d8,
                    ),
                    child: widget.trailing,
                  ),
              ],
            ),
    );
  }
}
