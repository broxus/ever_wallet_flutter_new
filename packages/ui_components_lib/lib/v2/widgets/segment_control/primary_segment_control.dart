import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/segment_control/segment_control.dart';

//if you need to select segment, pass SegmentControlState.selected
//example state : user.id == client.id ? SegmentControlState.selected :
// SegmentControlState.normal
class PrimarySegmentControl<T> extends StatelessWidget {
  const PrimarySegmentControl({
    required this.state,
    required this.value,
    this.icon,
    this.size = SegmentControlSize.large,
    this.title,
    super.key,
  });

  final SegmentControlSize size;
  final SegmentControlState state;
  final IconData? icon;
  final String? title;
  final T value;

  double get _iconSize {
    switch (size) {
      case SegmentControlSize.large:
        return DimensSizeV2.d20;
      case SegmentControlSize.medium:
        return DimensSizeV2.d16;
      case SegmentControlSize.small:
        return DimensSizeV2.d16;
      case SegmentControlSize.xsmall:
        return DimensSizeV2.d12;
    }
  }

  EdgeInsets get _padding {
    switch (size) {
      case SegmentControlSize.large:
        return const EdgeInsets.symmetric(
          vertical: DimensSizeV2.d16,
          horizontal: DimensSizeV2.d32,
        );
      case SegmentControlSize.medium:
        return const EdgeInsets.symmetric(
          vertical: DimensSizeV2.d16,
          horizontal: DimensSizeV2.d24,
        );
      case SegmentControlSize.small:
        return const EdgeInsets.symmetric(
          vertical: DimensSizeV2.d16,
          horizontal: DimensSizeV2.d16,
        );
      case SegmentControlSize.xsmall:
        return const EdgeInsets.symmetric(
          vertical: DimensSizeV2.d12,
          horizontal: DimensSizeV2.d12,
        );
    }
  }

  double get _borderRadius {
    switch (size) {
      case SegmentControlSize.large:
        return DimensRadiusV2.radius16;
      case SegmentControlSize.medium:
        return DimensRadiusV2.radius12;
      case SegmentControlSize.small:
      case SegmentControlSize.xsmall:
        return DimensRadiusV2.radius8;
    }
  }

  PrimarySegmentControl<T> copyWith({
    SegmentControlSize? size,
    SegmentControlState? state,
    IconData? icon,
    String? title,
    T? value,
  }) {
    return PrimarySegmentControl<T>(
      size: size ?? this.size,
      state: state ?? this.state,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      value: value ?? this.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;
    final style = _getSegmentStyle(themeStyle);
    return Container(
      padding: _padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderRadius),
        color: style.backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: style.iconColor,
              size: _iconSize,
            ),
          if (title != null)
            Padding(
              padding: icon != null
                  ? const EdgeInsets.only(left: DimensSize.d8)
                  : EdgeInsets.zero,
              child: Text(
                title!,
                style: style.titleTextStyle,
              ),
            ),
        ],
      ),
    );
  }

  SegmentControlStyle _getSegmentStyle(ThemeStyleV2 theme) {
    switch (state) {
      case SegmentControlState.normal:
        return SegmentControlStyle.normal(
          theme.colors,
          theme.textStyles,
          size,
        );
      case SegmentControlState.selected:
        return SegmentControlStyle.selected(
          theme.colors,
          theme.textStyles,
          size,
        );
      case SegmentControlState.disabled:
        return SegmentControlStyle.disabled(
          theme.colors,
          theme.textStyles,
          size,
        );
    }
  }
}
