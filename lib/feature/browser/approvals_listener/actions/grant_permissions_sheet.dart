import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:string_extensions/string_extensions.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that allows show sheet to grant [permissions] for [account]
Future<Permissions?> showGrantPermissionsSheet({
  required BuildContext context,
  required Uri origin,
  required List<Permission> permissions,
  required KeyAccount account,
}) {
  return showCommonBottomSheet(
    context: context,
    useAppBackgroundColor: true,
    title: LocaleKeys.grantPermissions.tr(),
    body: (_, scrollController) => GrantPermissionsSheet(
      origin: origin,
      permissions: permissions,
      account: account,
      scrollController: scrollController,
    ),
  );
}

/// Sheet that allows grant permissions for [account] to interact with browser.
///
/// Selected permissions will be automatically saved to [PermissionsService].
class GrantPermissionsSheet extends StatelessWidget {
  const GrantPermissionsSheet({
    required this.origin,
    required this.permissions,
    required this.account,
    required this.scrollController,
    super.key,
  });

  final Uri origin;
  final List<Permission> permissions;
  final KeyAccount account;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return SeparatedColumn(
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: ShapedContainerColumn(
              margin: EdgeInsets.zero,
              children: [
                CommonListTile(
                  invertTitleSubtitleStyles: true,
                  titleText: LocaleKeys.originWord.tr(),
                  subtitleText: origin.host,
                ),
                CommonListTile(
                  invertTitleSubtitleStyles: true,
                  titleText: LocaleKeys.requestedPermissions.tr(),
                  subtitleText:
                      permissions.map((e) => e.name.capitalize).join(', '),
                ),
                CommonListTile(
                  height: null,
                  invertTitleSubtitleStyles: true,
                  titleText: LocaleKeys.accountAddress.tr(),
                  onPressed: () => copyValue(
                    account.address.address,
                    account.address.toEllipseString(),
                  ),
                  subtitleChild: Text(
                    account.address.address,
                    style: StyleRes.button.copyWith(color: colors.blue),
                  ),
                  trailing: CommonIconWidget.svg(
                    svg: Assets.images.copy.path,
                    color: colors.blue,
                  ),
                ),
                CommonListTile(
                  height: null,
                  invertTitleSubtitleStyles: true,
                  titleText: LocaleKeys.accountPublicKey.tr(),
                  onPressed: () => copyValue(
                    account.publicKey.publicKey,
                    account.publicKey.toEllipseString(),
                  ),
                  subtitleChild: Text(
                    account.publicKey.publicKey,
                    style: StyleRes.button.copyWith(color: colors.blue),
                  ),
                  trailing: CommonIconWidget.svg(
                    svg: Assets.images.copy.path,
                    color: colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
        SeparatedRow(
          children: [
            Expanded(
              child: CommonButton.ghost(
                fillWidth: true,
                text: LocaleKeys.rejectWord.tr(),
                onPressed: Navigator.of(context).pop,
              ),
            ),
            Expanded(
              child: CommonButton.primary(
                fillWidth: true,
                text: LocaleKeys.allowWord.tr(),
                onPressed: () => onAllowPressed(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void onAllowPressed(BuildContext context) {
    var result = const Permissions();

    for (final permission in permissions) {
      switch (permission) {
        case Permission.basic:
          result = result.copyWith(basic: true);
        case Permission.accountInteraction:
          result = result.copyWith(
            accountInteraction: AccountInteraction(
              address: account.address,
              publicKey: account.publicKey,
              contractType: account.account.tonWallet.contract.toContractType(),
            ),
          );
      }
    }

    inject<PermissionsService>()
        .setPermissions(origin: origin, permissions: result);

    Navigator.of(context).pop(result);
  }

  void copyValue(String value, String copyText) {
    Clipboard.setData(ClipboardData(text: value));
    inject<MessengerService>().show(
      Message.successful(
        message: LocaleKeys.valueCopiedExclamation.tr(args: [copyText]),
      ),
    );
  }
}
