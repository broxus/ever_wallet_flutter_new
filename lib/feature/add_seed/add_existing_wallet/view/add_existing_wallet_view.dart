import 'package:app/app/router/router.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

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
            Text(
              LocaleKeys.addExistingWalletTitle.tr(),
              style: theme.textStyles.headingLarge,
            ),
            const SizedBox(height: DimensSizeV2.d8),
            PrimaryText(LocaleKeys.addExistingWalletSubtitle.tr()),
            const Spacer(),
            PrimaryButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.useSecretPhraseTitle.tr(),
              onPressed: () {
                context.goFurther(
                  AppRoute.importWallet.path,
                  preserveQueryParams: true,
                );
              },
              icon: LucideIcons.textCursorInput,
            ),
          ],
        ),
      ),
    );
  }
}
