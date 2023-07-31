import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserBottomBarPrimary extends StatelessWidget {
  const BrowserBottomBarPrimary({
    required this.tabCount,
    super.key,
    this.backSvg,
    this.forwardSvg,
    this.plusSvg,
    this.historySvg,
    this.dotsSvg,
    this.onBackPressed,
    this.onForwardPressed,
    this.onPlusPressed,
    this.onHistoryPressed,
    this.onCountIndicatorPressed,
    this.onDotsPressed,
  });
  static const height = DimensSize.d64;

  final String? backSvg;
  final String? forwardSvg;
  final String? plusSvg;
  final String? historySvg;
  final String? dotsSvg;
  final VoidCallback? onBackPressed;
  final VoidCallback? onForwardPressed;
  final VoidCallback? onPlusPressed;
  final VoidCallback? onHistoryPressed;
  final VoidCallback? onCountIndicatorPressed;
  final VoidCallback? onDotsPressed;
  final int tabCount;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return ColoredBox(
      color: colors.backgroundSecondary,
      child: SizedBox(
        height: DimensSize.d64,
        child: Row(
          children: [
            Expanded(
              child: _getIconButton(
                context,
                backSvg,
                Icons.arrow_back_ios,
                onBackPressed,
              ),
            ),
            Expanded(
              child: _getIconButton(
                context,
                forwardSvg,
                Icons.arrow_forward_ios,
                onForwardPressed,
              ),
            ),
            Expanded(
              child: _getIconButton(
                context,
                plusSvg,
                Icons.add_circle,
                onPlusPressed,
              ),
            ),
            Expanded(
              child: tabCount == 0
                  ? _getIconButton(
                      context,
                      historySvg,
                      Icons.watch_later_outlined,
                      onHistoryPressed,
                    )
                  : Center(
                      child: CountIndicator(
                        count: tabCount,
                        onPressed: onCountIndicatorPressed,
                      ),
                    ),
            ),
            Expanded(
              child: _getIconButton(
                context,
                dotsSvg,
                Icons.menu,
                onDotsPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TODO(Odrin): we should add all the icons in the ui kit library
  // and get rid of this method
  Widget _getIconButton(
    BuildContext context,
    String? svg,
    IconData icondata,
    VoidCallback? onPressed,
  ) {
    final colors = context.themeStyle.colors;

    return Padding(
      padding: const EdgeInsets.all(DimensSize.d8),
      child: svg != null
          ? CommonIconButton.svg(
              size: CommonIconButtonSize.small,
              svg: svg,
              buttonType: EverButtonType.ghost,
              onPressed: onPressed,
            )
          : CommonIconButton.icon(
              size: CommonIconButtonSize.small,
              icon: icondata,
              buttonType: EverButtonType.ghost,
              onPressed: onPressed,
            ),
    );
  }
}
