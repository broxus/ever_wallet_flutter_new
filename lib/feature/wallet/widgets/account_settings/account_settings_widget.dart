import 'package:app/feature/wallet/widgets/account_settings/account_settings_wm.dart';
import 'package:app/feature/wallet/widgets/account_settings/info_card.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AccountSettingsWidget
    extends ElementaryWidget<AccountSettingsWidgetModel> {
  const AccountSettingsWidget({
    required this.account,
    required this.scrollController,
    Key? key,
    WidgetModelFactory wmFactory = defaultAccountSettingsWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final KeyAccount account;
  final ScrollController scrollController;

  @override
  Widget build(AccountSettingsWidgetModel wm) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AccountSettingsInfoCard(account: account),
        const SizedBox(height: DimensSizeV2.d16),
        StateNotifierBuilder(
          listenableState: wm.displayAccounts,
          builder: (_, list) => _ButtonsCard(
            onViewInExplorer: wm.onViewInExplorer,
            onCopyAddress: wm.onCopyAddress,
            onRename: wm.onRename,
            onHideAccount: (list?.length ?? 0) > 1 ? wm.onHideAccount : null,
          ),
        ),
        // TODO(knightforce): not released
        // PrimaryButton(
        //   buttonShape: ButtonShape.pill,
        //   title: LocaleKeys.advancedSettings.tr(),
        //   postfixIcon: LucideIcons.chevronRight,
        //   onPressed: wm.onAdvancedSettings,
        // ),
      ],
    );
  }
}

class _ButtonsCard extends StatelessWidget {
  const _ButtonsCard({
    required this.onViewInExplorer,
    required this.onRename,
    required this.onCopyAddress,
    required this.onHideAccount,
  });

  final VoidCallback onViewInExplorer;
  final VoidCallback onRename;
  final VoidCallback onCopyAddress;
  final VoidCallback? onHideAccount;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return PrimaryCard(
      color: theme.colors.background2,
      borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
      padding: EdgeInsets.zero,
      child: SeparatedColumn(
        mainAxisSize: MainAxisSize.min,
        separator: Divider(
          height: DimensStroke.small,
          thickness: DimensStroke.small,
          color: theme.colors.borderAlpha,
        ),
        children: [
          _Button(
            label: LocaleKeys.viewInExplorer.tr(),
            icon: LucideIcons.globe,
            onTap: onViewInExplorer,
          ),
          _Button(
            label: LocaleKeys.renameWord.tr(),
            icon: LucideIcons.pencilLine,
            onTap: onRename,
          ),
          _Button(
            label: LocaleKeys.copyAddress.tr(),
            icon: LucideIcons.copy,
            onTap: onCopyAddress,
          ),
          if (onHideAccount != null)
            _Button(
              label: LocaleKeys.hideAccount.tr(),
              icon: LucideIcons.eyeOff,
              color: theme.colors.contentNegative,
              onTap: onHideAccount!,
            ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.label,
    required this.icon,
    required this.onTap,
    this.color,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        height: DimensSizeV2.d56,
        padding: const EdgeInsets.symmetric(
          horizontal: DimensSizeV2.d24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: theme.textStyles.labelMedium.copyWith(
                color: color ?? theme.colors.content0,
              ),
            ),
            Icon(
              icon,
              size: DimensSizeV2.d20,
              color: color ?? theme.colors.content0,
            ),
          ],
        ),
      ),
    );
  }
}
