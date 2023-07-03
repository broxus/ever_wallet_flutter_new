import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that shows [KeySettingsSheet]
/// if [isMaster] true, then delete action will be blocked, use seed delete.
void showKeySettingsSheet({
  required BuildContext context,
  required String publicKey,
  required bool isMaster,
}) {
  showCommonBottomSheet<void>(
    context: context,
    useAppBackgroundColor: true,
    title: LocaleKeys.settingsOfKey.tr(),
    body: (_, __) => KeySettingsSheet(
      publicKey: publicKey,
      isMaster: isMaster,
    ),
  );
}

/// This is a widget that displays settings of key
class KeySettingsSheet extends StatelessWidget {
  const KeySettingsSheet({
    required this.publicKey,
    required this.isMaster,
    super.key,
  });

  final String publicKey;
  final bool isMaster;

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
            titleText: LocaleKeys.useThisKey.tr(),
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
          onPressed: () {
            inject<MessengerService>().show(
              Message.successful(
                message: LocaleKeys.valueCopiedExclamation.tr(
                  args: [publicKey.ellipsePublicKey()],
                ),
              ),
            );
            Clipboard.setData(ClipboardData(text: publicKey));
            Navigator.of(context).pop();
          },
          titleText: LocaleKeys.copyKey.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.copy.path,
            color: colors.textPrimary,
          ),
        ),
        if (publicKey != currentKey && !isMaster)
          CommonListTile(
            onPressed: () => Navigator.of(context)
              ..pop()
              ..push(deleteKeySheetRoute(publicKey)),
            contentColor: colors.alert,
            titleText: LocaleKeys.deleteWord.tr(),
            trailing: CommonIconWidget.svg(svg: Assets.images.trash.path),
          ),
      ],
    );
  }
}
