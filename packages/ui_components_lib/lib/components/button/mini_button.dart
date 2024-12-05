import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class MiniButton<T> extends StatelessWidget {
  const MiniButton({
    required this.title,
    required this.onTap,
    required this.value,
    required this.currentValue,
    super.key,
  });

  final String title;
  final VoidCallback onTap;
  final T value;
  final T currentValue;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final isSelected = currentValue == value;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: DimensSizeV2.d4),
        padding: const EdgeInsets.symmetric(vertical: DimensSizeV2.d4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DimensRadiusV2.radius24),
          border: Border.all(
            color: isSelected ? theme.colors.background3 : theme.colors.border1,
          ),
          color: isSelected ? theme.colors.background3 : Colors.transparent,
        ),
        width: DimensSizeV2.d50,
        child: Text(
          title,
          style: theme.textStyles.labelSmall.copyWith(
            color: isSelected ? theme.colors.content0 : theme.colors.content1,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
