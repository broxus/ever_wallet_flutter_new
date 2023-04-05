import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const primaryButtonHeight = 50.0;

/// Default button in the app with background.
/// Typically you do not need to specify text style or background color. It is
/// picked up from theme.
///
/// Simple usages:
/// ```
/// CommonButton.primary(text: 'MyButton', onPressed: (){})
/// ```dart
class CommonButton extends StatelessWidget {
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
    this.radius,
    this.backgroundColor,
    this.height = primaryButtonHeight,
    this.padding,
    this.fillWidth = true,
    this.splashColor,
    this.border,
    super.key,
  });

  factory CommonButton.primary({
    String? text,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    Widget? leading,
    Widget? trailing,
    FocusNode? focusNode,
    bool fillWidth = false,
  }) =>
      CommonButton(
        text: text,
        onPressed: onPressed,
        onLongPress: onLongPress,
        leading: leading,
        trailing: trailing,
        focusNode: focusNode,
        fillWidth: fillWidth,
      );

  factory CommonButton.secondary({
    String? text,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    Widget? leading,
    Widget? trailing,
    FocusNode? focusNode,
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
        fillWidth: fillWidth,
      );

  factory CommonButton.tertiary({
    String? text,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    Widget? leading,
    Widget? trailing,
    FocusNode? focusNode,
    bool fillWidth = false,
  }) =>
      CommonButton(
        buttonType: EverButtonType.tertiary,
        text: text,
        onPressed: onPressed,
        onLongPress: onLongPress,
        leading: leading,
        trailing: trailing,
        focusNode: focusNode,
        fillWidth: fillWidth,
      );

  factory CommonButton.ghost({
    String? text,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    Widget? leading,
    Widget? trailing,
    FocusNode? focusNode,
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
        fillWidth: fillWidth,
      );

  factory CommonButton.ghostNoPadding({
    String? text,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    Widget? leading,
    Widget? trailing,
    FocusNode? focusNode,
    bool fillWidth = false,
  }) =>
      CommonButton(
        buttonType: EverButtonType.ghostNoPadding,
        text: text,
        onPressed: onPressed,
        onLongPress: onLongPress,
        leading: leading,
        trailing: trailing,
        focusNode: focusNode,
        fillWidth: fillWidth,
        height: 24,
      );

  factory CommonButton.attention({
    String? text,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    Widget? leading,
    Widget? trailing,
    FocusNode? focusNode,
    bool fillWidth = false,
  }) =>
      CommonButton(
        buttonType: EverButtonType.attention,
        text: text,
        onPressed: onPressed,
        onLongPress: onLongPress,
        leading: leading,
        trailing: trailing,
        focusNode: focusNode,
        fillWidth: fillWidth,
      );

  /// Type of the button that is used to identify colors
  final EverButtonType buttonType;

  /// Text that will be used in Text widget with [style], if [style] not
  /// specified, style from theme will be used.
  /// If you want display custom widget, use [child].
  final String? text;
  final TextStyle? style;

  /// Button tap and long tap callbacks
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;

  /// Widgets that could be used around [text].
  /// Typically, use CommonButtonIconWidget that provides you color
  final Widget? leading;
  final Widget? trailing;

  /// Alternative option to display custom widget instead of [text]
  final Widget? child;

  final FocusNode? focusNode;

  /// If button should fill all width
  final bool fillWidth;

  /// UI based params
  final BorderRadius? radius;
  final double height;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final Color? splashColor;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    final styles = context.themeStyle.styles;
    final buttonStyle = styles.buttonsStyle[buttonType]!;

    final isDisabled = onPressed == null && onLongPress == null;

    final contentColor = isDisabled
        ? buttonStyle.contentDisabledColor ?? buttonStyle.contentColor
        : buttonStyle.contentColor;
    final textStyle =
        style ?? styles.buttonTextStyle.copyWith(color: contentColor);
    final bgColor = backgroundColor ??
        (isDisabled
            ? buttonStyle.disabledBackgroundColor
            : buttonStyle.backgroundColor);
    final splash = splashColor ?? buttonStyle.splashColor;
    final bord = border ??
        (isDisabled ? buttonStyle.disabledBorder : buttonStyle.border);

    Widget child;
    if (this.child == null) {
      final textWidget = Text(text ?? '', style: textStyle);
      child = Padding(
        padding: padding ?? buttonStyle.contentPadding,
        child: leading == null && trailing == null
            ? textWidget
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leading != null) ...[
                    leading!,
                    const SizedBox(width: 10),
                  ],
                  textWidget,
                  if (trailing != null) ...[
                    const SizedBox(width: 10),
                    trailing!,
                  ],
                ],
              ),
      );
    } else {
      child = this.child!;
    }

    return EverButtonStyleProvider(
      style: buttonStyle,
      isDisabled: isDisabled,
      child: SizedBox(
        height: height,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: radius ?? BorderRadius.zero,
            border: bord,
          ),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.all(bord?.top.width ?? 0),
              child: InkWell(
                hoverColor: Colors.transparent,
                focusNode: focusNode,
                customBorder: RoundedRectangleBorder(
                  borderRadius: radius ?? BorderRadius.zero,
                ),
                splashColor: splash,
                highlightColor: splash,
                onTap: onPressed,
                onLongPress: onLongPress,
                child: fillWidth
                    ? Center(child: child)
                    : Row(mainAxisSize: MainAxisSize.min, children: [child]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
