import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that shows [SeedSettingsSheet]
void showSeedSettingsSheet(
  BuildContext context,
  PublicKey publicKey,
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

  final PublicKey publicKey;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;
    final currentKeyService = inject<CurrentKeyService>();

    final currentKey = currentKeyService.currentKey;

    return ShapedContainerColumn(
      color: colors.background2,
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
              color: colors.content0,
            ),
          ),
        CommonListTile(
          onPressed: () => Navigator.of(context)
            ..pop()
            ..push(showRenameSheet(context, publicKey, renameSeed: true)),
          titleText: LocaleKeys.renameWord.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.edit.path,
            color: colors.content0,
          ),
        ),
        CommonListTile(
          onPressed: () => Navigator.of(context)
            ..pop()
            ..push(exportSeedSheetRoute(publicKey)),
          titleText: LocaleKeys.exportWord.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.exportFill.path,
            color: colors.content0,
          ),
        ),
        CommonListTile(
          onPressed: () => Navigator.of(context)
            ..pop()
            ..push(changeSeedPasswordSheetRoute(publicKey)),
          titleText: LocaleKeys.changePassword.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.lock.path,
            color: colors.content0,
          ),
        ),
        if (publicKey != currentKey)
          CommonListTile(
            onPressed: () => Navigator.of(context)
              ..pop()
              ..push(deleteSeedSheetRoute(publicKey)),
            contentColor: colors.contentNegative,
            titleText: LocaleKeys.deleteWord.tr(),
            trailing: CommonIconWidget.svg(svg: Assets.images.trash.path),
          ),
      ],
    );
  }
}
