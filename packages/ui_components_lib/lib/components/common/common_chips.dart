import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Type of chip that allows specify colors of chip
enum CommonChipsType {
  success,
  warning,
  note,
  secondary;

  Color contentColor(ColorsPalette colors) => switch (this) {
        CommonChipsType.success => colors.apply,
        CommonChipsType.warning => colors.labelOrange,
        CommonChipsType.note => colors.labelYellow,
        CommonChipsType.secondary => colors.textSecondary,
      };

  Color backgroundColor(ColorsPalette colors) => switch (this) {
        CommonChipsType.success => colors.lightGreen,
        CommonChipsType.warning => colors.lightRed,
        CommonChipsType.note => colors.lightOrange,
        CommonChipsType.secondary => colors.appBackground,
      };
}

/// Widget that displays small piece of information in a beautiful container
class CommonChips extends StatelessWidget {
  const CommonChips({
    required this.title,
    required this.type,
    this.leading,
    super.key,
  });

  final String title;
  final Widget? leading;
  final CommonChipsType type;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return Material(
      shape: const SquircleShapeBorder(cornerRadius: DimensRadius.small),
      color: type.backgroundColor(colors),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DimensSize.d8,
          vertical: DimensSize.d4,
        ),
        child: EverButtonStyleProvider(
          contentColor: type.contentColor(colors),
          child: SeparatedRow(
            separatorSize: DimensSize.d4,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leading != null) leading!,
              Text(
                title,
                style: StyleRes.addRegular.copyWith(
                  color: type.contentColor(colors),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
