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

  static const height = DimensSize.d48;

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
    final colors = context.themeStyleV2.colors;

    return ColoredBox(
      color: colors.background1,
      child: SizedBox(
        height: height,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimensSize.d24,
          ),
          child: Row(
            children: [
              Expanded(
                child: _IconButton(
                  svg: backSvg,
                  iconData: Icons.arrow_back_ios,
                  onPressed: onBackPressed,
                ),
              ),
              Expanded(
                child: _IconButton(
                  svg: forwardSvg,
                  iconData: Icons.arrow_forward_ios,
                  onPressed: onForwardPressed,
                ),
              ),
              Expanded(
                child: _IconButton(
                  svg: plusSvg,
                  iconData: Icons.add_circle,
                  onPressed: onPlusPressed,
                ),
              ),
              Expanded(
                child: tabCount == 0
                    ? _IconButton(
                        svg: historySvg,
                        iconData: Icons.watch_later_outlined,
                        onPressed: onHistoryPressed,
                      )
                    : Center(
                        child: CountIndicator(
                          count: tabCount,
                          onPressed: onCountIndicatorPressed,
                        ),
                      ),
              ),
              Expanded(
                child: _IconButton(
                  svg: dotsSvg,
                  iconData: Icons.menu,
                  onPressed: onDotsPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO(Odrin): we should add all the icons in the ui kit library
class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.svg,
    required this.iconData,
    required this.onPressed,
  });

  final String? svg;
  final IconData iconData;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DimensSize.d4),
      child: svg != null
          ? CommonIconButton.svg(
              size: CommonIconButtonSize.small,
              svg: svg!,
              buttonType: EverButtonType.ghost,
              padding: EdgeInsets.zero,
              onPressed: onPressed,
            )
          : CommonIconButton.icon(
              size: CommonIconButtonSize.small,
              icon: iconData,
              buttonType: EverButtonType.ghost,
              padding: EdgeInsets.zero,
              onPressed: onPressed,
            ),
    );
  }
}
