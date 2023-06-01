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
              color: colors.textPrimary,
              name: 'textPrimary',
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
