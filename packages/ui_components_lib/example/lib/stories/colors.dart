import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page with all colors
class ColorsStory extends StatelessWidget {
  const ColorsStory({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Colors (based on theme)'),
      ),
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            /// Order for colors same as in ColorsPalette
            _ColorItem(
              color: colors.backgroundPrimary,
              name: 'backgroundPrimary',
            ),
            _ColorItem(
              color: colors.backgroundOverlay,
              name: 'backgroundOverlay',
            ),
            _ColorItem(
              color: colors.textPrimary,
              name: 'textPrimary',
            ),
            _ColorItem(
              color: colors.textButtonPrimary,
              name: 'textButtonPrimary',
            ),
            _ColorItem(
              color: colors.textButtonSecondary,
              name: 'textButtonSecondary',
            ),
            _ColorItem(
              color: colors.textNegative,
              name: 'textNegative',
            ),
            _ColorItem(
              color: colors.textPositive,
              name: 'textPositive',
            ),
            _ColorItem(
              color: colors.textButtonPressed,
              name: 'textButtonPressed',
            ),
            _ColorItem(
              color: colors.textButtonDisabled,
              name: 'textButtonDisabled',
            ),
            _ColorItem(
              color: colors.accentPrimary,
              name: 'accentPrimary',
            ),
            _ColorItem(
              color: colors.accentPrimaryPressed,
              name: 'accentPrimaryPressed',
            ),
            _ColorItem(
              color: colors.accentPrimaryDisabled,
              name: 'accentPrimaryDisabled',
            ),
            _ColorItem(
              color: colors.accentSecondary,
              name: 'accentSecondary',
            ),
            _ColorItem(
              color: colors.accentSecondaryPressed,
              name: 'accentSecondaryPressed',
            ),
            _ColorItem(
              color: colors.accentSecondaryDisabled,
              name: 'accentSecondaryDisabled',
            ),
            _ColorItem(
              color: colors.accentTertiary,
              name: 'accentTertiary',
            ),
            _ColorItem(
              color: colors.accentTertiaryPressed,
              name: 'accentTertiaryPressed',
            ),
            _ColorItem(
              color: colors.accentTertiaryDisabled,
              name: 'accentTertiaryDisabled',
            ),
            _ColorItem(
              color: colors.accentWarning,
              name: 'accentWarning',
            ),
            _ColorItem(
              color: colors.accentWarningPressed,
              name: 'accentWarningPressed',
            ),
            _ColorItem(
              color: colors.accentWarningDisabled,
              name: 'accentWarningDisabled',
            ),
            _ColorItem(
              color: colors.fillingPrimary,
              name: 'fillingPrimary',
            ),
            _ColorItem(
              color: colors.fillingSecondary,
              name: 'fillingSecondary',
            ),
            _ColorItem(
              color: colors.fillingTertiary,
              name: 'fillingTertiary',
            ),
            _ColorItem(
              color: colors.fillingPressed,
              name: 'fillingHover',
            ),
            _ColorItem(
              color: colors.statusPositiveTitle,
              name: 'statusPositiveTitle',
            ),
            _ColorItem(
              color: colors.statusPositiveBackground,
              name: 'statusPositiveBackground',
            ),
            _ColorItem(
              color: colors.statusMediumTitle,
              name: 'statusMediumTitle',
            ),
            _ColorItem(
              color: colors.statusMediumBackground,
              name: 'statusMediumBackground',
            ),
            _ColorItem(
              color: colors.statusNegativeTitle,
              name: 'statusNegativeTitle',
            ),
            _ColorItem(
              color: colors.statusNegativeBackground,
              name: 'statusNegativeBackground',
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorItem extends StatelessWidget {
  const _ColorItem({
    required this.color,
    required this.name,
  });

  final Color color;
  final String name;

  @override
  Widget build(BuildContext context) {
    final isBackgroundLight =
        Theme.of(context).scaffoldBackgroundColor.computeLuminance() > 0.7;
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          Container(
            width: 150,
            height: 100,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
              border: Border.all(
                color: isBackgroundLight ? Colors.black : Colors.white,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isBackgroundLight ? Colors.black : Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
