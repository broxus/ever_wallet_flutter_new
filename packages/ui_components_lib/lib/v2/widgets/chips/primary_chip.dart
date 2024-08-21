import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';
import 'package:ui_components_lib/v2/widgets/chips/chips.dart';

class PrimaryChip extends StatelessWidget {
  const PrimaryChip({
    required this.text,
    required this.iconData,
    required this.type,
    super.key,
  });

  final String text;
  final IconData iconData;
  final ChipsType type;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DimensRadiusV2.radius8),
        color: _getColorBackground(theme, type),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: DimensSizeV2.d8,
        vertical: DimensSizeV2.d6,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: _getColorContent(theme, type),
            size: DimensSizeV2.d16,
          ),
          const SizedBox(width: DimensSizeV2.d4),
          Text(
            text,
            style: theme.textStyles.labelXSmall.copyWith(
              color: _getColorContent(
                theme,
                type,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorContent(ThemeStyleV2 theme, ChipsType type) {
    switch (type) {
      case ChipsType.normal:
        return theme.colors.content1;
      case ChipsType.warning:
        return theme.colors.contentWarning;
      case ChipsType.error:
        return theme.colors.contentNegative;
      case ChipsType.success:
        return theme.colors.contentPositive;
    }
  }

  Color _getColorBackground(ThemeStyleV2 theme, ChipsType type) {
    switch (type) {
      case ChipsType.normal:
        return theme.colors.backgroundAlpha;
      case ChipsType.warning:
        return theme.colors.backgroundWarning;
      case ChipsType.error:
        return theme.colors.backgroundNegative;
      case ChipsType.success:
        return theme.colors.backgroundPositive;
    }
  }
}
