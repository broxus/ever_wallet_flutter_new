import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Default inner padding (from icon to border)
const defaultCommonIconButtonInnerPadding = DimensSize.d20;

/// Default full size of icon button (*2 because EdgeInsets.all)
const defaultCommonIconButtonSize =
    defaultCommonIconSize + defaultCommonIconButtonInnerPadding * 2;

/// {@template common_icon_button}
/// This is a common button with icon inside
/// {@endtemplate}
class CommonIconButton extends StatefulWidget {
  /// {@macro common_icon_button}
  const CommonIconButton({
    required this.buttonType,
    this.onPressed,
    this.onLongPress,
    this.focusNode,
    super.key,
    this.icon,
    this.svg,
    this.size,
    this.color,
    this.backgroundColor,
    this.outerPadding,
    this.innerPadding,
  }) : assert(
          icon != null || svg != null,
          'IconData or Svg path must be specified',
        );

  /// Factory that allows create button with svg asset
  factory CommonIconButton.svg({
    required String svg,
    required EverButtonType buttonType,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    FocusNode? focusNode,
    Key? key,
    double? size,
    Color? color,
    EdgeInsets? outerPadding,
    EdgeInsets? innerPadding,
  }) =>
      CommonIconButton(
        buttonType: buttonType,
        onPressed: onPressed,
        onLongPress: onLongPress,
        focusNode: focusNode,
        key: key,
        svg: svg,
        size: size,
        color: color,
        outerPadding: outerPadding,
        innerPadding: innerPadding,
      );

  /// Factory that allows create button with [IconData]
  factory CommonIconButton.icon({
    required IconData icon,
    required EverButtonType buttonType,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    FocusNode? focusNode,
    Key? key,
    double? size,
    Color? color,
    EdgeInsets? outerPadding,
    EdgeInsets? innerPadding,
  }) =>
      CommonIconButton(
        buttonType: buttonType,
        onPressed: onPressed,
        onLongPress: onLongPress,
        focusNode: focusNode,
        key: key,
        icon: icon,
        size: size,
        color: color,
        outerPadding: outerPadding,
        innerPadding: innerPadding,
      );

  /// Style that will be used to get colors
  final EverButtonType buttonType;

  /// Callback when user tap button
  final VoidCallback? onPressed;

  /// Callback when user long pressed button
  final VoidCallback? onLongPress;

  /// Focus node for button that could be used in [FocusScope]
  final FocusNode? focusNode;

  /// Data of icon that is used in [Icon]
  final IconData? icon;

  /// Path in assets directory to svg image
  final String? svg;

  /// Size for image
  final double? size;

  /// Color of icon, if not specified, then color from [EverButtonStyle]
  /// is used.
  final Color? color;

  /// Color of background, if not specified, then color from [EverButtonStyle]
  /// is used.
  final Color? backgroundColor;

  /// Padding around ink effect, default 0
  final EdgeInsets? outerPadding;

  /// Padding around icon but inside ink effect, default is
  /// [defaultCommonIconButtonInnerPadding]
  final EdgeInsets? innerPadding;

  @override
  State<CommonIconButton> createState() => _CommonIconButtonState();
}

class _CommonIconButtonState extends State<CommonIconButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final styles = context.themeStyle.styles;
    final buttonStyle = styles.buttonsStyle[widget.buttonType]!;
    final isDisabled = widget.onPressed == null && widget.onLongPress == null;
    final backgroundColor = widget.backgroundColor ??
        (isDisabled
            ? buttonStyle.backgroundDisabledColor
            : buttonStyle.backgroundColor);
    final contentColor = widget.color ??
        (isDisabled
            ? buttonStyle.contentDisabledColor
            : isPressed
                ? buttonStyle.contentPressedColor
                : buttonStyle.contentColor);

    return EverButtonStyleProvider(
      contentColor: contentColor,
      child: Padding(
        padding: widget.outerPadding ?? EdgeInsets.zero,
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DimensRadius.max),
          ),
          color: backgroundColor,
          child: InkWell(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            borderRadius: BorderRadius.circular(DimensRadius.max),
            onTap: widget.onPressed,
            onLongPress: widget.onLongPress,
            focusNode: widget.focusNode,
            onHighlightChanged: _onHighlightChanged,
            child: Padding(
              padding: widget.innerPadding ??
                  const EdgeInsets.all(defaultCommonIconButtonInnerPadding),
              child: CommonButtonIconWidget(
                icon: widget.icon,
                svg: widget.svg,
                size: widget.size,
              ),
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
}
