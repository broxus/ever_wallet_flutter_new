import 'package:app/feature/wallet/widgets/account_settings/account_settings_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:barcode_widget/barcode_widget.dart';
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
    return SeparatedColumn(
      separatorSize: DimensSizeV2.d16,
      mainAxisSize: MainAxisSize.min,
      children: [
        _InfoCard(account: account),
        StateNotifierBuilder(
          listenableState: wm.displayAccounts,
          builder: (_, list) => _ButtonsCard(
            onViewInExplorer: wm.onViewInExplorer,
            onCopyAddress: wm.onCopyAddress,
            onRename: wm.onRename,
            onHideAccount: (list?.length ?? 0) > 1 ? wm.onHideAccount : null,
          ),
        ),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.advancedSettings.tr(),
          postfixIcon: LucideIcons.chevronRight,
          onPressed: wm.onAdvancedSettings,
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.account,
  });

  final KeyAccount account;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return IntrinsicHeight(
      child: PrimaryCard(
        color: theme.colors.background2,
        borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
        padding: EdgeInsets.zero,
        child: SeparatedRow(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          separator: VerticalDivider(
            width: DimensStroke.small,
            thickness: DimensStroke.small,
            color: theme.colors.borderAlpha,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(DimensSizeV2.d12),
              child: Center(
                child: BarcodeWidget(
                  // margin: const EdgeInsets.all(DimensSizeV2.d12),
                  width: DimensSizeV2.d74,
                  height: DimensSizeV2.d74,
                  data: account.address.address,
                  barcode: Barcode.qrCode(),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: SeparatedColumn(
                mainAxisSize: MainAxisSize.min,
                separator: Divider(
                  height: DimensStroke.small,
                  thickness: DimensStroke.small,
                  color: theme.colors.borderAlpha,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(DimensSizeV2.d12),
                    child: SeparatedColumn(
                      separatorSize: DimensSizeV2.d4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          LocaleKeys.addressWord.tr(),
                          style: theme.textStyles.labelXSmall.copyWith(
                            color: theme.colors.content3,
                          ),
                        ),
                        Text(
                          account.address.toString(),
                          style: theme.textStyles.labelXSmall,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(DimensSizeV2.d12),
                    child: SeparatedColumn(
                      separatorSize: DimensSizeV2.d4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          LocaleKeys.publicKey.tr(),
                          style: theme.textStyles.labelXSmall.copyWith(
                            color: theme.colors.content3,
                          ),
                        ),
                        Text(
                          account.publicKey.toString(),
                          style: theme.textStyles.labelXSmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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