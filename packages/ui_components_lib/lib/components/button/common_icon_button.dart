import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const defaultCommonIconButtonSize = DimensSize.d56;

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
    this.isLoading = false,
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
    CommonIconButtonSize? size,
    Color? color,
    bool? isLoading,
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
        isLoading: isLoading ?? false,
      );

  /// Factory that allows create button with [IconData]
  factory CommonIconButton.icon({
    required IconData icon,
    required EverButtonType buttonType,
    VoidCallback? onPressed,
    VoidCallback? onLongPress,
    FocusNode? focusNode,
    Key? key,
    CommonIconButtonSize? size,
    Color? color,
    bool? isLoading,
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
        isLoading: isLoading ?? false,
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

  /// Size of button, default is [CommonIconButtonSize.medium]
  final CommonIconButtonSize? size;

  /// Color of icon, if not specified, then color from [EverButtonStyle]
  /// is used.
  final Color? color;

  /// Color of background, if not specified, then color from [EverButtonStyle]
  /// is used.
  final Color? backgroundColor;

  /// If circular loading indicator should be displayed
  final bool isLoading;

  @override
  State<CommonIconButton> createState() => _CommonIconButtonState();
}

class _CommonIconButtonState extends State<CommonIconButton> {
  bool isPressed = false;

  EdgeInsets get _innerPadding {
    final size = (widget.size ?? CommonIconButtonSize.medium).value;

    // ignore: no-magic-number
    return EdgeInsets.all((size - defaultCommonIconSize) / 2);
  }

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
      child: AnimatedColor(
        color: backgroundColor,
        duration: kThemeAnimationDuration,
        builder: (context, backColor) {
          return Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(DimensRadius.max),
            ),
            color: backColor,
            child: InkWell(
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              borderRadius: BorderRadius.circular(DimensRadius.max),
              onTap: widget.isLoading ? null : widget.onPressed,
              onLongPress: widget.isLoading ? null : widget.onLongPress,
              focusNode: widget.focusNode,
              onHighlightChanged: _onHighlightChanged,
              child: Padding(
                padding: _innerPadding,
                child: widget.isLoading
                    ? _loadingChild(contentColor)
                    : CommonButtonIconWidget(
                        icon: widget.icon,
                        svg: widget.svg,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _loadingChild(Color contentColor) {
    return SizedBox(
      width: DimensSize.d20,
      height: DimensSize.d20,
      child: CircularProgressIndicator(
        color: contentColor,
        strokeWidth: DimensStroke.medium,
      ),
    );
  }

  void _onHighlightChanged(bool isPressed) {
    if (isPressed != this.isPressed) {
      setState(() => this.isPressed = isPressed);
    }
  }
}

enum CommonIconButtonSize {
  /// 28x28
  xsmall(DimensSize.d28),

  /// 44x44
  small(DimensSize.d44),

  /// 56x56 (default)
  medium(DimensSize.d56);

  const CommonIconButtonSize(this.value);

  final double value;
}
