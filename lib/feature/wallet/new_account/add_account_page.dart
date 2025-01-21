import 'package:app/app/router/router.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/cards/primary_card.dart';

class AddAccountPage extends StatelessWidget {
  const AddAccountPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Scaffold(
      appBar: DefaultAppBar(
        titleText: LocaleKeys.newAccount.tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
        child: PrimaryCard(
          color: theme.colors.background2,
          borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.only(top: DimensSizeV2.d16),
          child: SeparatedColumn(
            mainAxisSize: MainAxisSize.min,
            separator: const CommonDivider(),
            children: [
              GestureDetector(
                onTap: () {
                  context.goFurther(
                    AppRoute.walletSelectSeed.path,
                  );
                },
                behavior: HitTestBehavior.translucent,
                child: SizedBox(
                  height: DimensSizeV2.d64,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimensSizeV2.d16,
                    ),
                    child: SeparatedRow(
                      separatorSize: DimensSizeV2.d12,
                      children: [
                        const Icon(LucideIcons.plus, size: DimensSizeV2.d20),
                        Expanded(
                          child: Text(
                            LocaleKeys.createNewAccount.tr(),
                            style: theme.textStyles.labelMedium,
                          ),
                        ),
                        const Icon(
                          LucideIcons.chevronRight,
                          size: DimensSizeV2.d20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.goFurther(
                    AppRoute.walletNewExternalAccount.path,
                  );
                },
                child: SizedBox(
                  height: DimensSizeV2.d64,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimensSizeV2.d16,
                    ),
                    child: SeparatedRow(
                      separatorSize: DimensSizeV2.d12,
                      children: [
                        const Icon(
                          LucideIcons.import,
                          size: DimensSizeV2.d20,
                        ),
                        Expanded(
                          child: Text(
                            LocaleKeys.addExternalAccount.tr(),
                            style: theme.textStyles.labelMedium,
                          ),
                        ),
                        const Icon(
                          LucideIcons.chevronRight,
                          size: DimensSizeV2.d20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
