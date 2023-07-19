import 'package:app/generated/generated.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserBottomMenuCommon extends StatelessWidget {
  const BrowserBottomMenuCommon({
    required this.onBackPressed,
    required this.onForwardPressed,
    required this.onAddTabPressed,
    required this.onTabsPressed,
    required this.onOverflowPressed,
    super.key,
  });

  static const height = DimensSize.d64;

  final VoidCallback? onBackPressed;
  final VoidCallback? onForwardPressed;
  final VoidCallback? onAddTabPressed;
  final VoidCallback? onTabsPressed;
  final VoidCallback? onOverflowPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return ColoredBox(
      color: colors.appBackground,
      child: SizedBox(
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonIconButton.svg(
              svg: Assets.images.navigateBack.path,
              buttonType: EverButtonType.ghost,
              onPressed: onBackPressed,
            ),
            CommonIconButton.svg(
              svg: Assets.images.navigateForward.path,
              buttonType: EverButtonType.ghost,
              onPressed: onForwardPressed,
            ),
            CommonIconButton.svg(
              svg: Assets.images.plusCircled.path,
              buttonType: EverButtonType.ghost,
              onPressed: onAddTabPressed,
            ),
            CommonIconButton.svg(
              svg: Assets.images.plusCircled.path,
              buttonType: EverButtonType.ghost,
              onPressed: onTabsPressed,
            ),
            CommonIconButton.svg(
              svg: Assets.images.dots.path,
              buttonType: EverButtonType.ghost,
              onPressed: onOverflowPressed,
            ),
          ],
        ),
      ),
    );
  }
}
