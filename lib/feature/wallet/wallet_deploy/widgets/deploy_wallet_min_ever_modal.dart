import 'package:app/feature/wallet/widgets/account_settings/info_card.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/widgets/modals/primary_bottom_sheet.dart';

void showDeployMinEverModal(
  BuildContext context,
  KeyAccount account,
  String nameConnection,
) {
  showPrimaryBottomSheet(
    context: context,
    title: LocaleKeys.deployWalletModalTitle.tr(),
    subtitle: LocaleKeys.deployWalletModalSubtitle.tr(
      args: [
        '0.1',
        nameConnection.toUpperCase(),
      ],
    ),
    assetsPath: Assets.images.icExplamationMark.path,
    content: AccountSettingsInfoCard(
      account: account,
      isShowingKey: false,
    ),
  );
}
