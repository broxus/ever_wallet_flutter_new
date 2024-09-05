import 'package:app/feature/wallet/widgets/account_settings/account_settings_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

Future<void> showAccountSettingsSheet({
  required BuildContext context,
  required KeyAccount account,
}) {
  return showCommonBottomSheet<void>(
    context: context,
    title: LocaleKeys.accountSettings.tr(),
    centerTitle: true,
    body: (_, scrollController) => AccountSettingsWidget(
      account: account,
      scrollController: scrollController,
    ),
  );
}
