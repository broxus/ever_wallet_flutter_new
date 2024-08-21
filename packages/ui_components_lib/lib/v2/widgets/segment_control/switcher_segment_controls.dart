import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

class SwitcherSegmentControls<T> extends StatelessWidget {
  const SwitcherSegmentControls({
    required this.currentValue,
    required this.values,
    required this.onTabChanged,
    super.key,
  });

  final T currentValue;
  final List<PrimarySegmentControl<T>> values;
  final ValueChanged<T> onTabChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Container(
      decoration: BoxDecoration(
        color: theme.colors.background0,
        borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
      ),
      padding: const EdgeInsets.all(DimensSizeV2.d4),
      child: Row(
        children: [
          for (final segment in values)
            Expanded(
              child: GestureDetector(
                onTap: () => onTabChanged(segment.value),
                child: segment.copyWith(
                  state: segment.value == currentValue
                      ? SegmentControlState.selected
                      : SegmentControlState.normal,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
