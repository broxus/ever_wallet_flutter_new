import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserBottomBarTabs extends StatelessWidget {
  const BrowserBottomBarTabs({
    required this.closeAllText,
    required this.doneText,
    this.plusSvg,
    this.onPlusPressed,
    this.onCloseAllPressed,
    this.onDonePressed,
    super.key,
  });

  final String? plusSvg;
  final VoidCallback? onPlusPressed;
  final VoidCallback? onCloseAllPressed;
  final VoidCallback? onDonePressed;
  final String closeAllText;
  final String doneText;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;

    return ColoredBox(
      color: colors.background1,
      child: SizedBox(
        height: DimensSizeV2.d64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: _TextButton(
                title: closeAllText,
                onPressed: onCloseAllPressed,
                color: colors.contentNegative,
              ),
            ),
            _PlusButton(
              svgUri: plusSvg,
              iconData: Icons.add_circle,
              onPressed: onPlusPressed,
            ),
            Expanded(
              child: _TextButton(
                title: doneText,
                onPressed: onDonePressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlusButton extends StatelessWidget {
  const _PlusButton({
    required this.iconData,
    required this.onPressed,
    this.svgUri,
  });

  final String? svgUri;
  final IconData iconData;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DimensSize.d8),
      child: svgUri != null
          ? CommonIconButton.svg(
              size: CommonIconButtonSize.small,
              svg: svgUri!,
              buttonType: EverButtonType.ghost,
              onPressed: onPressed,
            )
          : CommonIconButton.icon(
              size: CommonIconButtonSize.small,
              icon: iconData,
              buttonType: EverButtonType.ghost,
              onPressed: onPressed,
            ),
    );
  }
}

class _TextButton extends StatelessWidget {
  const _TextButton({
    required this.title,
    this.onPressed,
    this.color,
  });

  final String title;
  final VoidCallback? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;

    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: Text(
          title,
          // TODO(knightforce): check style from designer
          style: themeStyle.textStyles.labelSmall.copyWith(
            fontWeight: FontWeight.w600,
            color: color,
            height: 1,
          ),
        ),
      ),
    );
  }
}
