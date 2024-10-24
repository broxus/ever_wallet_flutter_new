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
                child: _getIconButton(
                  backSvg,
                  Icons.arrow_back_ios,
                  onBackPressed,
                ),
              ),
              Expanded(
                child: _getIconButton(
                  forwardSvg,
                  Icons.arrow_forward_ios,
                  onForwardPressed,
                ),
              ),
              Expanded(
                child: _getIconButton(
                  plusSvg,
                  Icons.add_circle,
                  onPlusPressed,
                ),
              ),
              Expanded(
                child: tabCount == 0
                    ? _getIconButton(
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
                  dotsSvg,
                  Icons.menu,
                  onDotsPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // TODO(Odrin): we should add all the icons in the ui kit library
  // and get rid of this method
  Widget _getIconButton(
    String? svg,
    IconData icondata,
    VoidCallback? onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.all(DimensSize.d4),
      child: svg != null
          ? CommonIconButton.svg(
              size: CommonIconButtonSize.small,
              svg: svg,
              buttonType: EverButtonType.ghost,
              padding: EdgeInsets.zero,
              onPressed: onPressed,
            )
          : CommonIconButton.icon(
              size: CommonIconButtonSize.small,
              icon: icondata,
              buttonType: EverButtonType.ghost,
              padding: EdgeInsets.zero,
              onPressed: onPressed,
            ),
    );
  }
}
