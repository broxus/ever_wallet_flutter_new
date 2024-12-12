import 'package:app/feature/wallet/widgets/account_settings/account_settings_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

Future<void> showAccountSettingsModal({
  required BuildContext context,
  required KeyAccount account,
  required List<PublicKey>? custodians,
}) {
  return showCommonBottomSheet<void>(
    context: context,
    title: LocaleKeys.accountSettings.tr(),
    titleMargin: const EdgeInsets.only(
      top: DimensSizeV2.d52,
      bottom: DimensSizeV2.d40,
    ),
    centerTitle: true,
    body: (_, scrollController) => AccountSettingsWidget(
      account: account,
      scrollController: scrollController,
      custodians: custodians,
    ),
  );
}
