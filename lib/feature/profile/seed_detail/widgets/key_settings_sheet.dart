import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that shows [KeySettingsSheet]
/// if [isMaster] true, then delete action will be blocked, use seed delete.
void showKeySettingsSheet({
  required BuildContext context,
  required PublicKey publicKey,
  required bool isMaster,
}) {
  showCommonBottomSheet<void>(
    context: context,
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
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

  final PublicKey publicKey;
  final bool isMaster;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;
    final currentKeyService = inject<CurrentKeyService>();

    final currentKey = currentKeyService.currentKey;

    return ShapedContainerColumn(
      margin: EdgeInsets.zero,
      color: colors.background2,
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
              color: colors.content0,
            ),
          ),
        CommonListTile(
          onPressed: () => Navigator.of(context)
            ..pop()
            ..push(showRenameSheet(context, publicKey)),
          titleText: LocaleKeys.renameWord.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.edit.path,
            color: colors.content0,
          ),
        ),
        CommonListTile(
          onPressed: () {
            inject<MessengerService>().show(
              Message.successful(
                message: LocaleKeys.valueCopiedExclamation.tr(
                  args: [publicKey.toEllipseString()],
                ),
              ),
            );
            Clipboard.setData(ClipboardData(text: publicKey.publicKey));
            Navigator.of(context).pop();
          },
          titleText: LocaleKeys.copyKey.tr(),
          trailing: CommonIconWidget.svg(
            svg: Assets.images.copy.path,
            color: colors.content0,
          ),
        ),
        if (publicKey != currentKey && !isMaster)
          CommonListTile(
            onPressed: () => Navigator.of(context)
              ..pop()
              ..push(deleteKeySheetRoute(context, publicKey)),
            contentColor: colors.contentNegative,
            titleText: LocaleKeys.deleteWord.tr(),
            trailing: CommonIconWidget.svg(svg: Assets.images.trash.path),
          ),
      ],
    );
  }
}
