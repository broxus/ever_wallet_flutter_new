import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page with all colors
class CommonStory extends StatelessWidget {
  const CommonStory({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    return Scaffold(
      appBar: const DefaultAppBar(titleText: 'CommonWidgets'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            DefaultAppBar(
              leading: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.backgroundPrimary,
                ),
                child: Icon(Icons.ac_unit, color: colors.textContrast),
              ),
              titleText: 'Center title',
              subtitleTopText: 'TopSubtitle',
              subtitleBottomText: 'BottomSubtitle',
              actions: [
                CommonButton(
                  height: appBarButtonSize,
                  fillWidth: false,
                  buttonType: EverButtonType.ghost,
                  text: 'Action',
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 30),
            DefaultAppBar(
              leading: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.backgroundPrimary,
                ),
                child: Icon(Icons.ac_unit, color: colors.textContrast),
              ),
              centerTitle: false,
              titleText: 'Not centered title',
              subtitleTopText: 'TopSubtitle',
              subtitleBottomWidget: CommonButton(
                height: 20,
                padding: EdgeInsets.zero,
                buttonType: EverButtonType.ghost,
                fillWidth: false,
                text: 'SubtitleBottom button',
                onPressed: () {},
              ),
              actions: [
                CommonButton(
                  height: appBarButtonSize,
                  fillWidth: false,
                  buttonType: EverButtonType.ghost,
                  text: 'Action',
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
