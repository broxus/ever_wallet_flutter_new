import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserModalItem extends StatelessWidget {
  const BrowserModalItem({
    required this.titleText,
    required this.onPressed,
    required this.trailing,
    this.contentColor,
    super.key,
  });

  final String titleText;
  final VoidCallback onPressed;
  final Widget trailing;
  final Color? contentColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return CommonListTile(
      titleChild: Text(
        titleText,
        style: theme.textStyles.labelMedium.copyWith(color: contentColor),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: DimensSizeV2.d24,
      ),
      onPressed: onPressed,
      backgroundColor: theme.colors.background2,
      trailing: trailing,
      contentColor: contentColor,
    );
  }
}
