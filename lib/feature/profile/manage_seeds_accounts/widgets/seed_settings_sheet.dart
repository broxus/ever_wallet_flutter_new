import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
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

    void actionWithPop(VoidCallback action) {
      action();
      Navigator.of(context).pop();
    }

    return ShapedContainerColumn(
      margin: EdgeInsets.zero,
      mainAxisSize: MainAxisSize.min,
      separator: const CommonDivider(),
      children: [
        if (publicKey != currentKey)
          CommonListTile(
            onPressed: () => actionWithPop(
              () => currentKeyService.changeCurrentKey(publicKey),
            ),
            titleText: LocaleKeys.useThisSeed.tr(),
            trailing: CommonIconWidget.svg(
              svg: Assets.images.checkRounded.path,
              color: colors.textPrimary,
            ),
          ),
        CommonListTile(
          onPressed: () => actionWithPop(
            // ignore: no-empty-block
            () {},
          ),
          titleText: LocaleKeys.exportWord.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.export.path,
            color: colors.textPrimary,
          ),
        ),
        CommonListTile(
          onPressed: () => actionWithPop(
            // ignore: no-empty-block
            () {},
          ),
          titleText: LocaleKeys.changePassword.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.key.path,
            color: colors.textPrimary,
          ),
        ),
        if (publicKey != currentKey)
          CommonListTile(
            onPressed: () => actionWithPop(
              () => inject<NekotonRepository>()
                  .seedList
                  .findSeed(publicKey)
                  ?.remove(),
            ),
            contentColor: colors.alert,
            titleText: LocaleKeys.deleteWord.tr(),
            trailing: CommonIconWidget.svg(svg: Assets.images.trash.path),
          ),
      ],
    );
  }
}
