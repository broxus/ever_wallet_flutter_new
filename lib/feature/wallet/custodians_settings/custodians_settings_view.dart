import 'package:app/feature/wallet/custodians_settings/custodian_data.dart';
import 'package:app/feature/wallet/custodians_settings/custodians_settings_view_model.dart';
import 'package:app/feature/wallet/custodians_settings/rename_custodian_modal.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class CustodiansSettingsView
    extends ElementaryWidget<CustodianSettingsWidgetModel> {
  CustodiansSettingsView({
    required List<String> custodians,
    Key? key,
    WidgetModelFactory<CustodianSettingsWidgetModel>? wmFactory,
  }) : super(
          wmFactory ??
              (context) => defaultCustodianSettingsWidgetModelFactory(
                    context,
                    custodians,
                  ),
          key: key,
        );

  @override
  Widget build(CustodianSettingsWidgetModel wm) {
    final theme = wm.theme;

    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            LocaleKeys.custodiansSettingsLabel.tr(),
            style: theme.textStyles.paragraphMedium,
          ),
          const SizedBox(height: DimensSizeV2.d24),
          StateNotifierBuilder<List<CustodianData>>(
            listenableState: wm.custodians,
            builder: (_, custodians) {
              if (custodians == null) {
                return const SizedBox.shrink();
              }

              final items = <Widget>[];
              for (var i = 0; i < custodians.length; i++) {
                items.add(
                  _CustodianItem(custodians[i], () {
                    if (wm.contextSafe != null) {
                      showRenameCustodianModal(wm.contextSafe!, (value) {
                        wm.renameCustodian(custodians[i].key, value);
                      });
                    }
                  }),
                );
                if (i < custodians.length - 1) {
                  items.add(const CommonDivider());
                }
              }

              return Container(
                decoration: BoxDecoration(
                  color: theme.colors.background2,
                  borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
                ),
                child: Column(
                  children: items,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CustodianItem extends StatelessWidget {
  const _CustodianItem(this.item, this.onTap);

  final CustodianData item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DimensSizeV2.d24,
          vertical: DimensSizeV2.d12,
        ),
        child: Row(
          children: [
            Icon(LucideIcons.usersRound, color: theme.colors.content0),
            const SizedBox(width: DimensSizeV2.d12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: theme.textStyles.labelMedium),
                  const SizedBox(height: DimensSizeV2.d4),
                  Text(
                    item.key.toEllipseString(),
                    style: theme.textStyles.labelSmall.copyWith(
                      color: theme.colors.content3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: DimensSizeV2.d12,
            ),
            Icon(LucideIcons.pencilLine, color: theme.colors.content0),
          ],
        ),
      ),
    );
  }
}
