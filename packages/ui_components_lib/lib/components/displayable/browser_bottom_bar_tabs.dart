import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserBottomBarTabs extends StatelessWidget {
  const BrowserBottomBarTabs({
    super.key,
    this.plusSvg,
    this.closeAllText,
    this.doneText,
    this.onPlusPressed,
    this.onCloseAllPressed,
    this.onDonePressed,
  });

  final String? plusSvg;
  final VoidCallback? onPlusPressed;
  final VoidCallback? onCloseAllPressed;
  final VoidCallback? onDonePressed;
  final String? closeAllText;
  final String? doneText;

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
              child: Center(
                // TODO(Odrin): this button should be red
                child: SmallButton.ghost(
                  text: closeAllText ?? 'Close All',
                  onPressed: onCloseAllPressed,
                ),
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
              child: Center(
                child: SmallButton.ghost(
                  text: doneText ?? 'Done',
                  onPressed: onDonePressed,
                ),
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
    String? svg,
    IconData icondata,
    VoidCallback? onPressed,
  ) {
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
