import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class AccountSettingsButton extends StatelessWidget {
  const AccountSettingsButton({
    required this.label,
    required this.onTap,
    this.icon,
    this.iconWidget,
    this.color,
    super.key,
  });

  final String label;
  final IconData? icon;
  final Widget? iconWidget;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        height: DimensSizeV2.d56,
        padding: const EdgeInsets.symmetric(
          horizontal: DimensSizeV2.d24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: theme.textStyles.labelMedium.copyWith(
                color: color ?? theme.colors.content0,
              ),
            ),
            if (icon != null)
              Icon(
                icon,
                size: DimensSizeV2.d20,
                color: color ?? theme.colors.content0,
              ),
            if (iconWidget != null) iconWidget!,
          ],
        ),
      ),
    );
  }
}
