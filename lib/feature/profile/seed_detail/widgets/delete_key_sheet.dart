import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Helper method that shows the [DeleteKeySheet] bottom sheet.
ModalRoute<void> deleteKeySheetRoute(
  BuildContext context,
  PublicKey publicKey,
) {
  return commonBottomSheetRoute<void>(
    title: LocaleKeys.deleteKey.tr(),
    subtitle: LocaleKeys.deleteKeyDescription.tr(),
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    body: (_, __) => DeleteKeySheet(publicKey: publicKey),
  );
}

/// Widget that allows to delete key.
class DeleteKeySheet extends StatelessWidget {
  const DeleteKeySheet({
    required this.publicKey,
    super.key,
  });

  final PublicKey publicKey;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;
    final key = inject<NekotonRepository>().seedList.findSeedKey(publicKey);

    return SeparatedColumn(
      children: [
        if (key != null)
          Expanded(
            child: SingleChildScrollView(
              child: ShapedContainerColumn(
                margin: EdgeInsets.zero,
                color: colors.background2,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _sectionItem(
                    LocaleKeys.publicKey.tr(),
                    [
                      CommonListTile(
                        leading: CommonBackgroundedIconWidget.svg(
                          svg: Assets.images.key.path,
                          backgroundColor: colors.backgroundAlpha,
                        ),
                        titleText: key.name,
                        subtitleText: LocaleKeys.accountsWithData.plural(
                          key.accountList.allAccounts.length,
                          args: ['${key.accountList.allAccounts.length}'],
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                  if (key.accountList.allAccounts.isNotEmpty)
                    const CommonDivider(),
                  if (key.accountList.allAccounts.isNotEmpty)
                    _sectionItem(
                      LocaleKeys.myAccounts.tr(),
                      key.accountList.allAccounts
                          .map(
                            (account) => CommonListTile(
                              leading: CommonBackgroundedIconWidget.svg(
                                svg: Assets.images.person.path,
                                backgroundColor: colors.backgroundAlpha,
                              ),
                              titleText: account.name,
                              subtitleText: account.name,
                              padding: EdgeInsets.zero,
                            ),
                          )
                          .toList(),
                    ),
                ],
              ),
            ),
          ),
        if (key != null)
          DestructiveButton(
            buttonShape: ButtonShape.pill,
            title: LocaleKeys.deleteWord.tr(),
            onPressed: () {
              inject<NekotonRepository>()
                  .seedList
                  .findSeedKey(publicKey)
                  ?.remove();
              Navigator.of(context).pop();
            },
          ),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.cancelWord.tr(),
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
              style: context.themeStyleV2.textStyles.headingLarge,
            ),
            ...keys,
          ],
        );
      },
    );
  }
}
