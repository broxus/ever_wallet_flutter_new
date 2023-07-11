import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page with all colors
class ColorsStory extends StatelessWidget {
  const ColorsStory({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return Scaffold(
      appBar: const DefaultAppBar(titleText: 'Colors (based on theme)'),
      body: SingleChildScrollView(
        child: Center(
          child: Wrap(
            children: [
              /// Order for colors same as in ColorsPalette
              _ColorItem(
                color: colors.textPrimary,
                name: 'textPrimary',
              ),
              _ColorItem(
                color: colors.textSecondary,
                name: 'textSecondary',
              ),
              _ColorItem(
                color: colors.textContrast,
                name: 'textContrast',
              ),
              _ColorItem(
                color: colors.appBackground,
                name: 'appBackground',
              ),
              _ColorItem(
                color: colors.backgroundPrimary,
                name: 'backgroundPrimary',
              ),
              _ColorItem(
                color: colors.backgroundSecondary,
                name: 'backgroundSecondary',
              ),
              _ColorItem(
                color: colors.strokePrimary,
                name: 'strokePrimary',
              ),
              _ColorItem(
                color: colors.strokeSecondary,
                name: 'strokeSecondary',
              ),
              _ColorItem(
                color: colors.strokeContrast,
                name: 'strokeContrast',
              ),
              _ColorItem(
                color: colors.alert,
                name: 'alert',
              ),
              _ColorItem(
                color: colors.apply,
                name: 'apply',
              ),
              _ColorItem(
                color: colors.blue,
                name: 'blue',
              ),
              _ColorItem(
                color: colors.blueSecond,
                name: 'blueSecond',
              ),
              _ColorItem(
                color: colors.labelYellow,
                name: 'labelYellow',
              ),
              _ColorItem(
                color: colors.labelOrange,
                name: 'labelOrange',
              ),
              _ColorItem(
                color: colors.lightBlue,
                name: 'lightBlue',
              ),
              _ColorItem(
                color: colors.lightGreen,
                name: 'lightGreen',
              ),
              _ColorItem(
                color: colors.lightOrange,
                name: 'lightOrange',
              ),
              _ColorItem(
                color: colors.lightRed,
                name: 'lightRed',
              ),
              _ColorItem(
                gradient: colors.gradient,
                name: 'gradient',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorItem extends StatelessWidget {
  const _ColorItem({
    required this.name,
    this.color,
    this.gradient,
  });

  final Color? color;
  final List<Color>? gradient;
  final String name;

  @override
  Widget build(BuildContext context) {
    final isBackgroundLight =
        Theme.of(context).scaffoldBackgroundColor.computeLuminance() > 0.7;

    return SizedBox(
      width: DimensSize.d200,
      child: Column(
        children: [
          Container(
            width: DimensSize.d148,
            height: DimensSize.d100,
            margin: const EdgeInsets.all(DimensSize.d16),
            decoration: BoxDecoration(
              color: color,
              gradient: gradient == null
                  ? null
                  : LinearGradient(
                      colors: gradient!,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
              border: Border.all(
                color: isBackgroundLight ? Colors.black : Colors.white,
              ),
              borderRadius: BorderRadius.circular(DimensRadius.medium),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: StyleRes.primaryRegular.copyWith(
                  color: isBackgroundLight ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
