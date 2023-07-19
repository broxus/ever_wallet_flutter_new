import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template common_button_icon}
/// Widget of icon that allows you to put SvgPicture or Icon in [CommonButton].
///
/// ```
/// CommonButton(
///   leading: CommonButtonIconWidget.svg(svg: 'assets/star.svg'),
/// )
/// ```dart
/// {@endtemplate}
class CommonButtonIconWidget extends StatelessWidget {
  /// {@macro common_button_icon}
  const CommonButtonIconWidget({
    this.icon,
    this.svg,
    this.size,
    this.useDefaultColor = true,
    super.key,
  }) : assert(
          icon != null || svg != null,
          'IconData or Svg path must be specified',
        );

  /// Factory that allows creating widget with [IconData]
  factory CommonButtonIconWidget.icon({
    required IconData icon,
    CommonButtonIconSize? size,
    Key? key,
  }) =>
      CommonButtonIconWidget(icon: icon, size: size, key: key);

  /// Factory that allows creating widget with svg asset
  factory CommonButtonIconWidget.svg({
    required String svg,
    CommonButtonIconSize? size,
    bool useDefaultColor = true,
    Key? key,
  }) =>
      CommonButtonIconWidget(
        svg: svg,
        size: size,
        useDefaultColor: useDefaultColor,
        key: key,
      );

  /// Data of icon that is used in [Icon]
  final IconData? icon;

  /// Path in assets directory to svg image
  final String? svg;

  /// Size for image
  final CommonButtonIconSize? size;

  /// If true, icon will be colored with [EverButtonStyleProvider.contentColor]
  final bool useDefaultColor;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = EverButtonStyleProvider.of(context);
    final color = useDefaultColor ? buttonStyle.contentColor : null;

    final widget = CommonIconWidget(
      icon: icon,
      svg: svg,
      size: size?.value ?? CommonButtonIconSize.medium.value,
      avoidContentColor: color == null,
    );

    return color == null
        ? widget
        : AnimatedColor(
            color: color,
            duration: kThemeAnimationDuration,
            builder: (context, color) {
              return widget;
            },
          );
  }
}

enum CommonButtonIconSize {
  medium(DimensSize.d20);

  const CommonButtonIconSize(this.value);

  final double value;
}
