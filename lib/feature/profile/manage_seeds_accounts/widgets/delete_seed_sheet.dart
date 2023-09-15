import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper method that shows the [DeleteSeedSheet] bottom sheet.
ModalRoute<void> deleteSeedSheetRoute(PublicKey publicKey) {
  return commonBottomSheetRoute<void>(
    title: LocaleKeys.deleteSeedPhrase.tr(),
    subtitle: LocaleKeys.deleteSeedPhraseDescription.tr(),
    useAppBackgroundColor: true,
    body: (_, __) => DeleteSeedSheet(publicKey: publicKey),
  );
}

/// Widget that allows to delete seed.
class DeleteSeedSheet extends StatelessWidget {
  const DeleteSeedSheet({
    required this.publicKey,
    super.key,
  });

  final PublicKey publicKey;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    final seed = inject<NekotonRepository>().seedList.findSeed(publicKey);

    return SeparatedColumn(
      children: [
        if (seed != null)
          Expanded(
            child: SingleChildScrollView(
              child: ShapedContainerColumn(
                margin: EdgeInsets.zero,
                separatorSize: DimensSize.d16,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _sectionItem(
                    LocaleKeys.seedPhrase.tr(),
                    [
                      CommonListTile(
                        leading: CommonBackgroundedIconWidget.svg(
                          svg: Assets.images.sparxLogoSmall.path,
                        ),
                        titleText: seed.name,
                        subtitleText: LocaleKeys.publicKeysWithData.plural(
                          seed.allKeys.length,
                          args: ['${seed.allKeys.length}'],
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                  if (seed.subKeys.isNotEmpty) const CommonDivider(),
                  if (seed.subKeys.isNotEmpty)
                    _sectionItem(
                      LocaleKeys.keysWord.tr(),
                      seed.subKeys
                          .map(
                            (key) => CommonListTile(
                              leading: CommonBackgroundedIconWidget.svg(
                                svg: Assets.images.key.path,
                              ),
                              titleText: key.name,
                              subtitleText: LocaleKeys.accountsWithData.plural(
                                key.accountList.allAccounts.length,
                                args: ['${key.accountList.allAccounts.length}'],
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          )
                          .toList(),
                    ),
                ],
              ),
            ),
          ),
        if (seed != null)
          CommonButton(
            buttonType: EverButtonType.secondary,
            contentColor: colors.alert,
            text: LocaleKeys.deleteWord.tr(),
            onPressed: () {
              inject<NekotonRepository>()
                  .seedList
                  .findSeed(publicKey)
                  ?.remove();
              Navigator.of(context).pop();
            },
          ),
        CommonButton.secondary(
          fillWidth: true,
          text: LocaleKeys.cancelWord.tr(),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  Widget _sectionItem(String title, List<Widget> keys) {
    return Builder(
      builder: (context) {
        return SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          separatorSize: DimensSize.d12,
          children: [
            Text(
              title,
              style: StyleRes.h2.copyWith(
                color: context.themeStyle.colors.textPrimary,
              ),
            ),
            ...keys,
          ],
        );
      },
    );
  }
}
