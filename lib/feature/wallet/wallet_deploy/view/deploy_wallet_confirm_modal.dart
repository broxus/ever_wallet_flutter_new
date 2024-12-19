// ignore_for_file: inference_failure_on_function_return_type
import 'package:app/feature/wallet/wallet_deploy/view/deploy_wallet_confirm_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';
import 'package:ui_components_lib/v2/widgets/modals/primary_bottom_sheet.dart';

void showDeployConfirmModal(
  BuildContext context,
  Function(String) password,
) {
  showPrimaryBottomSheet(
    context: context,
    content: DeployWalletConfirmModal(
      password: password,
    ),
  );
}

class DeployWalletConfirmModal
    extends ElementaryWidget<DeployWalletConfirmWidgetModel> {
  DeployWalletConfirmModal({
    required Function(String) password,
    Key? key,
    WidgetModelFactory<DeployWalletConfirmWidgetModel>? wmFactory,
  }) : super(
          wmFactory ??
              (context) => defaultDeployWalletConfirmWidgetModelFactory(
                    context,
                    password,
                  ),
          key: key,
        );

  @override
  Widget build(DeployWalletConfirmWidgetModel wm) {
    final theme = wm.themeStyle;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
          child: Text(
            LocaleKeys.enterPasswordTo.tr(
              args: [LocaleKeys.deployWallet.tr().toLowerCase()],
            ),
            style: theme.textStyles.headingLarge,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: DimensSizeV2.d16),
        SecureTextField(
          textEditingController: wm.passwordController,
          isAutofocus: true,
          hintText: LocaleKeys.enterYourPassword.tr(),
        ),
        const SizedBox(height: DimensSizeV2.d28),
        AccentButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.confirm.tr(),
          onPressed: wm.onClickConfirm,
        ),
        StateNotifierBuilder(
          listenableState: wm.availableBiometry,
          builder: (_, value) {
            if (value == null) return const SizedBox.shrink();
            if (value.contains(BiometricType.face)) {
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

            if (value.isNotEmpty) {
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
  }
}
