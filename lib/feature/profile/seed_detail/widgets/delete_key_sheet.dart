import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper method that shows the [DeleteKeySheet] bottom sheet.
ModalRoute<void> deleteKeySheetRoute(PublicKey publicKey) {
  return commonBottomSheetRoute<void>(
    title: LocaleKeys.deleteKey.tr(),
    subtitle: LocaleKeys.deleteKeyDescription.tr(),
    useAppBackgroundColor: true,
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
    final colors = context.themeStyle.colors;
    final key = inject<NekotonRepository>().seedList.findSeedKey(publicKey);

    return SeparatedColumn(
      children: [
        if (key != null)
          Expanded(
            child: SingleChildScrollView(
              child: ShapedContainerColumn(
                margin: EdgeInsets.zero,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _sectionItem(
                    LocaleKeys.publicKey.tr(),
                    [
                      CommonListTile(
                        leading: CommonBackgroundedIconWidget.svg(
                          svg: Assets.images.key.path,
                        ),
                        titleText: key.name,
                        subtitleText: LocaleKeys.accountsWithData.plural(
                          key.accountList.allAccounts.length,
                          args: [
                            '${key.accountList.allAccounts.length}',
                            '0 USD',
                          ],
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
                              ),
                              titleText: account.name,
                              subtitleText:
                                  LocaleKeys.accountAddressWithData.tr(
                                args: [
                                  account.name,
                                  '0 USD',
                                ],
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
        if (key != null)
          CommonButton(
            buttonType: EverButtonType.secondary,
            contentColor: colors.alert,
            text: LocaleKeys.deleteWord.tr(),
            onPressed: () {
              inject<NekotonRepository>()
                  .seedList
                  .findSeedKey(publicKey)
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
