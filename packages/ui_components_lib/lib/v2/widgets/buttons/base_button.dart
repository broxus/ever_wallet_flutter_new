import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button.dart';

//It's base class for button, in this button we handle all parameters like
//shape, styles, size
abstract class BaseButton extends StatelessWidget {
  const BaseButton({
    required this.buttonShape,
    this.child,
    this.buttonSize = ButtonSize.large,
    this.title,
    this.onPressed,
    this.width,
    this.isLoading = false,
    this.icon,
    this.postfixIcon,
    super.key,
  });

  final ButtonShape buttonShape;
  final bool isLoading;
  final ButtonSize buttonSize;
  final VoidCallback? onPressed;
  final Widget? child;
  final String? title;
  final double? width;
  final IconData? icon;
  final IconData? postfixIcon;

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;
    final style = getButtonStyleByType(themeStyle!);
    final buttonStyle = getButtonStyle(themeStyle, style);
    final child = this.child ?? Text(title ?? '', textAlign: TextAlign.center);

    return buttonShape == ButtonShape.pill ||
            buttonShape == ButtonShape.rectangle
        ? ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: buttonStyle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: isLoading
                  ? [
                      _ProgressIndicatorWidget(
                        color: style.iconColor,
                        size: _iconSize,
                      ),
                    ]
                  : [
                      if (icon != null) Icon(icon, size: _iconSize),
                      if (icon != null) const SizedBox(width: DimensSizeV2.d8),
                      child,
                      if (postfixIcon != null)
                        const SizedBox(width: DimensSizeV2.d8),
                      if (postfixIcon != null)
                        Icon(postfixIcon, size: _iconSize),
                    ],
            ),
          )
        : SizedBox(
            width: fabSize,
            height: fabSize,
            child: ElevatedButton(
              style: buttonStyle,
              onPressed: isLoading ? null : onPressed,
              child: Icon(icon, size: _iconSize),
            ),
          );
  }

  ButtonStyle getButtonStyle(ThemeStyleV2 themeStyle, AppButtonStyle style) {
    return ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      textStyle: MaterialStateProperty.resolveWith<TextStyle>(
        (Set<MaterialState> states) =>
            _getTextStyle(states, themeStyle.textStyles, buttonSize),
      ),
      shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
        (Set<MaterialState> states) => _getBorder(
          states,
          style,
          buttonShape,
          buttonSize,
        ),
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) => _getColorBackground(states, style),
      ),
      overlayColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) => _getColorOverlay(
          states,
          style,
        ),
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) => _getColorForeground(
          states,
          style,
        ),
      ),
      padding: MaterialStateProperty.resolveWith(
        (_) => EdgeInsets.all(
          paddingByButtonSize,
        ),
      ),
    );
  }

  TextStyle _getTextStyle(
    Set<MaterialState> states,
    TextStylesV2 styles,
    ButtonSize size,
  ) {
    final color = styles.labelMedium.color;
    if (states.contains(MaterialState.pressed)) {
      return _getTextStyleBySize(styles).copyWith(
        color: color?.withOpacity(OpacV2.opac80),
      );
    }
    if (states.contains(MaterialState.disabled)) {
      return _getTextStyleBySize(styles).copyWith(
        color: color?.withOpacity(OpacV2.opac50),
      );
    }
    return _getTextStyleBySize(styles);
  }

  RoundedRectangleBorder _getBorder(
    Set<MaterialState> states,
    AppButtonStyle style,
    ButtonShape shape,
    ButtonSize size,
  ) {
    return RoundedRectangleBorder(
      side: BorderSide(
        color: states.contains(MaterialState.focused)
            ? style.borderColor
            : Colors.transparent,
        width: DimensSizeV2.d2,
      ),
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  Color _getColorBackground(Set<MaterialState> states, AppButtonStyle style) {
    if (states.contains(MaterialState.pressed)) {
      return style.backgroundColor.withOpacity(
        style.backgroundColor.opacity * OpacV2.opac80,
      );
    }
    if (states.contains(MaterialState.disabled)) {
      return style.backgroundColor
          .withOpacity(style.backgroundColor.opacity * OpacV2.opac50);
    }

    return style.backgroundColor;
  }

  Color _getColorForeground(Set<MaterialState> states, AppButtonStyle style) {
    if (states.contains(MaterialState.pressed)) {
      return style.iconColor.withOpacity(OpacV2.opac80);
    }
    if (states.contains(MaterialState.disabled)) {
      return style.iconColor.withOpacity(OpacV2.opac50);
    }
    return style.iconColor;
  }

  Color _getColorOverlay(Set<MaterialState> states, AppButtonStyle style) =>
      style.backgroundColor
          .withOpacity(style.backgroundColor.opacity * OpacV2.opac80);

  double get borderRadius {
    if (buttonShape == ButtonShape.rectangle ||
        buttonShape == ButtonShape.square) {
      switch (buttonSize) {
        case ButtonSize.large:
          return DimensRadiusV2.radius16;
        case ButtonSize.medium:
          return DimensRadiusV2.radius12;
        case ButtonSize.small:
          return DimensRadiusV2.radius8;
      }
    } else {
      return DimensRadiusV2.theBiggest;
    }
  }

  TextStyle _getTextStyleBySize(TextStylesV2 styles) {
    switch (buttonSize) {
      case ButtonSize.large:
        return styles.labelMedium;
      case ButtonSize.medium:
        return styles.labelSmall;
      case ButtonSize.small:
        return styles.labelSmall;
    }
  }

  double get paddingByButtonSize {
    switch (buttonSize) {
      case ButtonSize.large:
        return DimensSizeV2.d18;
      case ButtonSize.medium:
        return DimensSizeV2.d16;
      case ButtonSize.small:
        return DimensSizeV2.d8;
    }
  }

  double get _iconSize {
    switch (buttonSize) {
      case ButtonSize.large:
        return DimensSizeV2.d20;
      case ButtonSize.medium:
        return DimensSizeV2.d16;
      case ButtonSize.small:
        return DimensSizeV2.d16;
    }
  }

  double get fabSize {
    switch (buttonSize) {
      case ButtonSize.large:
        return DimensSizeV2.d56;
      case ButtonSize.medium:
        return DimensSizeV2.d48;
      case ButtonSize.small:
        return DimensSizeV2.d40;
    }
  }

  AppButtonStyle getButtonStyleByType(ThemeStyleV2 theme) {
    switch (runtimeType) {
      case GhostButton:
        return AppButtonStyle.ghost(theme.colors, theme.textStyles);
      case AccentButton:
        return AppButtonStyle.accent(theme.colors, theme.textStyles);
      case PrimaryButton:
        return AppButtonStyle.primary(theme.colors, theme.textStyles);
      case FloatButton:
        return AppButtonStyle.float(theme.colors, theme.textStyles);
      case DestructiveButton:
        return AppButtonStyle.destructive(theme.colors, theme.textStyles);
      default:
        return AppButtonStyle.ghost(theme.colors, theme.textStyles);
    }
  }
}

class _ProgressIndicatorWidget extends StatelessWidget {
  const _ProgressIndicatorWidget({
    required this.color,
    required this.size,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
        color: color.withOpacity(OpacV2.opac50),
      ),
    );
  }
}
