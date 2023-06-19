import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/manage_seeds_accounts/widgets/widgets.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that shows [SeedSettingsSheet]
void showSeedSettingsSheet(
  BuildContext context,
  String publicKey,
) {
  showCommonBottomSheet<void>(
    context: context,
    useAppBackgroundColor: true,
    title: LocaleKeys.settingsOfSeed.tr(),
    body: (_, __) => SeedSettingsSheet(publicKey: publicKey),
  );
}

/// This is a widget that displays settings of seed
class SeedSettingsSheet extends StatelessWidget {
  const SeedSettingsSheet({
    required this.publicKey,
    super.key,
  });

  final String publicKey;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    final currentKeyService = inject<CurrentKeyService>();

    final currentKey = currentKeyService.currentKey;

    return ShapedContainerColumn(
      margin: EdgeInsets.zero,
      mainAxisSize: MainAxisSize.min,
      separator: const CommonDivider(),
      children: [
        if (publicKey != currentKey)
          CommonListTile(
            onPressed: () {
              currentKeyService.changeCurrentKey(publicKey);
              Navigator.of(context).pop();
            },
            titleText: LocaleKeys.useThisSeed.tr(),
            trailing: CommonIconWidget.svg(
              svg: Assets.images.checkSquare.path,
              color: colors.textPrimary,
            ),
          ),
        CommonListTile(
          onPressed: () => Navigator.of(context)
            ..pop()
            ..push(showRenameSheet(publicKey)),
          titleText: LocaleKeys.renameWord.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.edit.path,
            color: colors.textPrimary,
          ),
        ),
        CommonListTile(
          onPressed: () => Navigator.of(context)
            ..pop()
            ..push(exportSeedSheetRoute(publicKey)),
          titleText: LocaleKeys.exportWord.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.exportFill.path,
            color: colors.textPrimary,
          ),
        ),
        CommonListTile(
          // ignore: no-empty-block
          onPressed: () {},
          titleText: LocaleKeys.changePassword.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.lock.path,
            color: colors.textPrimary,
          ),
        ),
        if (publicKey != currentKey)
          CommonListTile(
            onPressed: () {
              inject<NekotonRepository>()
                  .seedList
                  .findSeed(publicKey)
                  ?.remove();
              Navigator.of(context).pop();
            },
            contentColor: colors.alert,
            titleText: LocaleKeys.deleteWord.tr(),
            trailing: CommonIconWidget.svg(svg: Assets.images.trash.path),
          ),
      ],
    );
  }
}
