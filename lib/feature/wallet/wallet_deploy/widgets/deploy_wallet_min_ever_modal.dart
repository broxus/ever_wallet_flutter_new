import 'package:app/feature/wallet/widgets/account_settings/info_card.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/widgets/modals/primary_bottom_sheet.dart';

void showDeployMinEverModal({
  required BuildContext context,
  required KeyAccount account,
  required BigInt minAmount,
  required String symbol,
}) {
  showPrimaryBottomSheet(
    context: context,
    title: LocaleKeys.deployWalletModalTitle.tr(),
    subtitle: LocaleKeys.deployWalletModalSubtitle.tr(
      args: [(minAmount / BigInt.from(1000000000)).toString(), symbol],
    ),
    assetsPath: Assets.images.icExplamationMark.path,
    content: AccountSettingsInfoCard(
      account: account,
      isShowingKey: false,
    ),
  );
}
