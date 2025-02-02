import 'package:app/app/router/app_route.dart';
import 'package:app/feature/wallet/new_account/add_account/add_account_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AddAccountView extends ElementaryWidget<AddAccountWidgetModel> {
  const AddAccountView({
    Key? key,
    WidgetModelFactory wmFactory = defaultAddAccountWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(AddAccountWidgetModel wm) {
    final theme = wm.theme;
    return DoubleSourceBuilder(
      firstSource: wm.list,
      secondSource: wm.currentAccount,
      builder: (context, list, currentSeed) {
        return PrimaryCard(
          color: theme.colors.background2,
          borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
          padding: EdgeInsets.zero,
          margin: const EdgeInsets.only(top: DimensSizeV2.d16),
          child: SeparatedColumn(
            mainAxisSize: MainAxisSize.min,
            separator: const CommonDivider(),
            children: [
              GestureDetector(
                onTap: wm.onSelect,
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
        );
      },
    );
  }
}
