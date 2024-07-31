import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button.dart';

class AddExistingWalletView extends StatelessWidget {
  const AddExistingWalletView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SafeArea(
      minimum: const EdgeInsets.only(bottom: DimensSize.d24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
        child: Column(
          children: [
            const Spacer(),
            Text('Add an existing wallet',
                style: theme.textStyles.headingLarge),
            const SizedBox(height: DimensSizeV2.d8),
            Text(
              'Choose how you’d like to import your existing '
              'wallet into Sparx.',
              style: theme.textStyles.paragraphMedium,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            PrimaryButton(
              buttonShape: ButtonShape.pill,
              title: 'Use '
                  'secret recovery phrase',
              onPressed: () {},
              icon: LucideIcons.textCursorInput,
            ),
          ],
        ),
      ),
    );
  }
}
