import 'package:app/feature/wallet/add_account/add_account_confirm/add_account_confirm_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AddAccountConfirmWidget
    extends ElementaryWidget<AddAccountConfirmWidgetModel> {
  const AddAccountConfirmWidget({
    required this.publicKey,
    Key? key,
    WidgetModelFactory wmFactory = defaultAddAccountConfirmWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final PublicKey publicKey;

  @override
  Widget build(AddAccountConfirmWidgetModel wm) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (wm.account != null)
          AccountInfo(
            account: wm.account!,
            color: wm.theme.colors.background2,
          ),
        const SizedBox(height: DimensSizeV2.d16),
        SecureTextField(
          textEditingController: wm.controller,
          hintText: LocaleKeys.enterYourPassword.tr(),
          isAutofocus: true,
          onSubmit: (_) => wm.onPasswordSubmit(),
        ),
        const SizedBox(height: DimensSizeV2.d28),
        AccentButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.confirm.tr(),
          onPressed: wm.onPasswordSubmit,
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
  }
}
