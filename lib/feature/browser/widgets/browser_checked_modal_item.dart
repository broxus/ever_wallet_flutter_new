import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserCheckedModalItem extends StatelessWidget {
  const BrowserCheckedModalItem({
    required this.titleText,
    required this.svgUri,
    this.subtitleText,
    this.onPressed,
    this.isSelected = false,
    this.contentColor,
    super.key,
  });

  final String titleText;
  final String? subtitleText;
  final String svgUri;
  final VoidCallback? onPressed;
  final bool isSelected;
  final Color? contentColor;

  @override
  Widget build(BuildContext context) {
    final color = context.themeStyleV2.colors;

    return CommonListTile(
      titleText: titleText,
      subtitleText: subtitleText,
      padding: EdgeInsets.zero,
      height: null,
      leading: CommonBackgroundedIconWidget.svg(
        svg: svgUri,
        backgroundColor: color.backgroundAlpha,
        iconColor: color.content0,
      ),
      trailing: CommonCheckbox(
        checked: isSelected,
        color: color.content0,
      ),
      onPressed: onPressed,
      contentColor: contentColor,
    );
  }
}
