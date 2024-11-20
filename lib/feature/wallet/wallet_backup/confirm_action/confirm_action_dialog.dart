import 'package:app/feature/wallet/wallet_backup/confirm_action/confirm_action_data.dart';
import 'package:app/feature/wallet/wallet_backup/confirm_action/confirm_action_wm.dart';
import 'package:app/feature/wallet/widgets/account_info.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';
import 'package:ui_components_lib/v2/widgets/modals/primary_bottom_sheet.dart';

void showConfirmActionDialog(
  BuildContext context,
  KeyAccount? currentAccount,
  VoidCallback finishedBackupCallback,
) {
  showPrimaryBottomSheet(
    context: context,
    content: ContentConfirmAction(
      finishedBackupCallback: finishedBackupCallback,
      account: currentAccount,
    ),
  );
}

class ContentConfirmAction extends ElementaryWidget<ConfirmActionWidgetModel> {
  ContentConfirmAction({
    required VoidCallback finishedBackupCallback,
    Key? key,
    WidgetModelFactory<ConfirmActionWidgetModel>? wmFactory,
    KeyAccount? account,
  }) : super(
          wmFactory ??
              (context) => defaultConfirmActionWidgetModelFactory(
                    context,
                    account,
                    finishedBackupCallback,
                  ),
          key: key,
        );

  @override
  Widget build(ConfirmActionWidgetModel wm) {
    final theme = wm.themeStyle;
    return EntityStateNotifierBuilder<ConfirmActionData?>(
      listenableEntityState: wm.screenState,
      builder: (_, data) {
        return Column(
          children: [
            Text(
              LocaleKeys.confirmAction.tr(),
              style: theme.textStyles.headingMedium,
            ),
            const SizedBox(height: DimensSizeV2.d24),
            if (wm.account != null)
              AccountInfo(
                account: wm.account!,
                color: theme.colors.background2,
              ),
            const SizedBox(height: DimensSizeV2.d16),
            SecureTextField(
              textEditingController: wm.passwordController,
              validator: (_) => data?.error,
              isAutofocus: true,
              hintText: LocaleKeys.enterYourPassword.tr(),
            ),
            const SizedBox(height: DimensSizeV2.d28),
            AccentButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.confirm.tr(),
              isLoading: data?.isLoading ?? false,
              onPressed: wm.onClickConfirm,
            ),
            StateNotifierBuilder(
              listenableState: wm.availableBiometry,
              builder: (_, value) {
                if (value?.contains(BiometricType.face) ?? false) {
                  return Padding(
                    padding: const EdgeInsets.only(top: DimensSizeV2.d8),
                    child: PrimaryButton(
                      buttonShape: ButtonShape.pill,
                      title: LocaleKeys.useFaceID.tr(),
                      icon: LucideIcons.scanFace,
                      onPressed: wm.onUseBiometry,
                    ),
                  );
                }

                if (value?.isNotEmpty ?? false) {
                  return Padding(
                    padding: const EdgeInsets.only(top: DimensSizeV2.d8),
                    child: PrimaryButton(
                      buttonShape: ButtonShape.pill,
                      title: LocaleKeys.useFingerprint.tr(),
                      icon: LucideIcons.fingerprint,
                      onPressed: wm.onUseBiometry,
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        );
      },
    );
  }
}
