import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

class SwitcherSegmentControls<T> extends StatelessWidget {
  const SwitcherSegmentControls({
    required this.currentValue,
    required this.values,
    required this.onTabChanged,
    this.fullWidth = true,
    super.key,
  });

  final T currentValue;
  final List<PrimarySegmentControl<T>> values;
  final bool fullWidth;
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
        mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
        children: [
          for (final segment in values)
            Flexible(
              fit: fullWidth ? FlexFit.tight : FlexFit.loose,
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
