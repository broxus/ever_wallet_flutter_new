import 'package:app/generated/generated.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserBottomMenuTabs extends StatelessWidget {
  const BrowserBottomMenuTabs({
    required this.onCloseAllPressed,
    required this.onAddTabPressed,
    required this.onDonePressed,
    super.key,
  });

  final VoidCallback? onCloseAllPressed;
  final VoidCallback? onAddTabPressed;
  final VoidCallback? onDonePressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return ColoredBox(
      color: colors.appBackground,
      child: SizedBox(
        height: DimensSize.d64,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: CommonButton.ghost(
                  size: CommonButtonSize.small,
                  text: LocaleKeys.browserCloseAll.tr(),
                  onPressed: onCloseAllPressed,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: CommonIconButton.svg(
                  svg: Assets.images.plusCircled.path,
                  buttonType: EverButtonType.ghost,
                  onPressed: onAddTabPressed,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: CommonButton.ghost(
                  size: CommonButtonSize.small,
                  text: LocaleKeys.browserDone.tr(),
                  onPressed: onDonePressed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
