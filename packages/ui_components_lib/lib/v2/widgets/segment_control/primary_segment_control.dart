import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';
import 'package:ui_components_lib/v2/widgets/segment_control/segment_control.dart';

//if you need to select segment, pass SegmentControlState.selected
//example state : user.id == client.id ? SegmentControlState.selected :
// SegmentControlState.normal
class PrimarySegmentControl extends StatelessWidget {
  const PrimarySegmentControl({
    required this.state,
    required this.icon,
    this.size = SegmentControlSize.large,
    this.title,
    this.value,
    super.key,
  });

  final SegmentControlSize size;
  final SegmentControlState state;
  final IconData icon;
  final String? title;
  final String? value;

  double get _iconSize {
    switch (size) {
      case SegmentControlSize.large:
        return DimensSizeV2.d20;
      case SegmentControlSize.medium:
        return DimensSizeV2.d16;
      case SegmentControlSize.small:
        return DimensSizeV2.d16;
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
    }
  }

  double get _borderRadius {
    switch (size) {
      case SegmentControlSize.large:
        return DimensRadiusV2.radius16;
      case SegmentControlSize.medium:
        return DimensRadiusV2.radius12;
      case SegmentControlSize.small:
        return DimensRadiusV2.radius8;
    }
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
        children: [
          Icon(
            icon,
            color: style.iconColor,
            size: _iconSize,
          ),
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(left: DimensSize.d8),
              child: Text(
                title!,
                style: style.titleTextStyle,
              ),
            ),
          if (value != null)
            Padding(
              padding: const EdgeInsets.only(left: DimensSize.d8),
              child: Text(
                value!,
                style: style.valueTextStyle,
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
