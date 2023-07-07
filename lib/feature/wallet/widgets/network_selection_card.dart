import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Button that allows to select network from wallet screen
class NetworkSelectionCard extends StatelessWidget {
  const NetworkSelectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return PressScaleWidget(
      // ignore: no-empty-block
      onPressed: () {},
      child: CommonCard(
        padding: EdgeInsets.zero,
        leadingChild: Container(
          padding: const EdgeInsets.all(DimensSize.d12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colors.backgroundSecondary,
          ),
          child: CommonIconWidget.svg(
            avoidContentColor: true,
            svg: Assets.images.sparxLogoSmall.path,
          ),
        ),
        width: null,
        backgroundColor: Colors.transparent,
        topSubtitleText: LocaleKeys.networkWord.tr(),
        titleChild: SeparatedRow(
          separatorSize: DimensSize.d4,
          children: [
            Flexible(
              child: Text(
                'Mainnet',
                style: StyleRes.button.copyWith(color: colors.textPrimary),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
              ),
            ),
            CommonIconWidget.svg(
              svg: Assets.images.caretDown.path,
              color: colors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
