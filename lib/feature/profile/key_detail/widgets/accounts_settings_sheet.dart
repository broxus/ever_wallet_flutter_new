import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function to show [AccountSettingsSheet].
Future<void> showAccountSettingsSheet({
  required BuildContext context,
  required String address,
  bool showHiding = true,
}) {
  return showCommonBottomSheet(
    context: context,
    useAppBackgroundColor: true,
    title: LocaleKeys.settingsOfAccount.tr(),
    body: (_, __) => AccountSettingsSheet(
      address: address,
      showHiding: showHiding,
    ),
  );
}

/// Sheet that displays settings of account
class AccountSettingsSheet extends StatelessWidget {
  const AccountSettingsSheet({
    required this.address,
    required this.showHiding,
    super.key,
  });

  /// Address of account to show settings for.
  final String address;

  /// Flag if hide/show item should be shown.
  final bool showHiding;

  @override
  Widget build(BuildContext context) {
    final account =
        inject<NekotonRepository>().seedList.findAccountByAddress(address);

    final colors = context.themeStyle.colors;

    return ShapedContainerColumn(
      mainAxisSize: MainAxisSize.min,
      separator: const CommonDivider(),
      margin: EdgeInsets.zero,
      children: account == null
          ? const []
          : [
              if (showHiding)
                CommonListTile(
                  titleText: account.isHidden
                      ? LocaleKeys.showWord.tr()
                      : LocaleKeys.hideWord.tr(),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (account.isHidden) {
                      account.show();
                    } else {
                      account.hide();
                    }
                  },
                  contentColor: colors.textPrimary,
                  trailing: CommonButtonIconWidget.svg(
                    svg: account.isHidden
                        ? Assets.images.openedEye.path
                        : Assets.images.closedEye.path,
                  ),
                ),
              CommonListTile(
                titleText: LocaleKeys.renameWord.tr(),
                onPressed: () {
                  Navigator.of(context)
                    ..pop()
                    ..push(getRenameAccountSheet(address));
                },
                contentColor: colors.textPrimary,
                trailing: CommonButtonIconWidget.svg(
                  svg: Assets.images.edit.path,
                ),
              ),
              CommonListTile(
                titleText: LocaleKeys.deleteWord.tr(),
                contentColor: colors.alert,
                onPressed: () {
                  Navigator.of(context).pop();
                  account.remove();
                },
                trailing: CommonButtonIconWidget.svg(
                  svg: Assets.images.trash.path,
                ),
              ),
            ],
    );
  }
}
