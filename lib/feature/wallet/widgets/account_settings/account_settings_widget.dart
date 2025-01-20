import 'package:app/feature/wallet/widgets/account_settings/account_settings_wm.dart';
import 'package:app/feature/wallet/widgets/account_settings/info_card.dart';
import 'package:app/feature/wallet/widgets/account_settings/widgets/account_settings_button.dart';
import 'package:app/feature/wallet/widgets/account_settings/widgets/change_color_button/account_settings_change_color_button.dart';
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
    required this.custodians,
    Key? key,
    WidgetModelFactory wmFactory = defaultAccountSettingsWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final KeyAccount account;
  final ScrollController scrollController;
  final List<PublicKey>? custodians;

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
            address: account.address.address,
            custodians: custodians,
            onCustodiansSettings: () =>
                wm.onCustodiansSettings(custodians ?? []),
            onViewInExplorer: wm.onViewInExplorer,
            onRename: wm.onRename,
            onHideAccount: (list?.length ?? 0) > 1 ? wm.onHideAccount : null,
          ),
        ),
      ],
    );
  }
}

class _ButtonsCard extends StatelessWidget {
  const _ButtonsCard({
    required this.address,
    required this.custodians,
    required this.onCustodiansSettings,
    required this.onViewInExplorer,
    required this.onRename,
    required this.onHideAccount,
  });

  final String address;
  final List<PublicKey>? custodians;
  final VoidCallback onCustodiansSettings;
  final VoidCallback onViewInExplorer;
  final VoidCallback onRename;
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
          if ((custodians?.length ?? 0) > 1)
            AccountSettingsButton(
              label: LocaleKeys.custodiansWord.tr(),
              icon: LucideIcons.userRound,
              onTap: onCustodiansSettings,
            ),
          AccountSettingsButton(
            label: LocaleKeys.changeAccountName.tr(),
            icon: LucideIcons.pencilLine,
            onTap: onRename,
          ),
          AccountSettingsChangeColorButton(
            address: address,
          ),
          AccountSettingsButton(
            label: LocaleKeys.seeInExplorer.tr(),
            icon: LucideIcons.globe,
            onTap: onViewInExplorer,
          ),
          if (onHideAccount != null)
            AccountSettingsButton(
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
