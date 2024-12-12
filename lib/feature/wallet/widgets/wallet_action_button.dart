import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class WalletActionButton extends StatelessWidget {
  const WalletActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.badge,
    super.key,
  });

  final String label;
  final IconData icon;
  final bool? badge;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onPressed,
      child: SizedBox(
        width: 88,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(DimensSizeV2.d18),
              child: Icon(icon, size: DimensSizeV2.d20),
            ),
            Text(
              label,
              style: theme.textStyles.labelXSmall.copyWith(
                color: theme.colors.content3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
