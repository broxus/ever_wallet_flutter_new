import 'package:app/feature/add_seed/create_password/model/password_status.dart';
import 'package:app/feature/add_seed/create_password/widgets/password_info_section.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class CreateSeedPasswordView extends StatelessWidget {
  const CreateSeedPasswordView({
    required this.needBiometryIfPossible,
    required this.passwordController,
    required this.confirmController,
    required this.onPressedNext,
    required this.isLoading,
    this.passwordStatus,
    super.key,
  });

  /// If true, then biometry will be requested if possible
  final bool needBiometryIfPossible;
  final TextEditingController passwordController;
  final TextEditingController confirmController;
  final VoidCallback onPressedNext;
  final PasswordStatus? passwordStatus;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;

    return SafeArea(
      minimum: const EdgeInsets.only(bottom: DimensSize.d16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.confirmPasswordTitle.tr(),
                      style: themeStyle.textStyles.headingLarge,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: DimensSize.d8),
                    PrimaryText(
                      LocaleKeys.confirmPasswordSubtitle.tr(),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: DimensSize.d24),
                    SecureTextField(
                      hintText: LocaleKeys.confirmSetPasswordHint.tr(),
                      textEditingController: passwordController,
                    ),
                    const SizedBox(height: DimensSize.d8),
                    SecureTextField(
                      hintText: LocaleKeys.confirmRepeatPasswordHint.tr(),
                      textEditingController: confirmController,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: DimensSize.d24),
                    PasswordInfoSection(
                      themeStyle: themeStyle,
                      status: passwordStatus ?? PasswordStatus.initial,
                    ),
                    const SizedBox(height: DimensSize.d12),
                  ],
                ),
              ),
            ),
            AccentButton(
              title: LocaleKeys.continueWord.tr(),
              onPressed:
                  passwordStatus == PasswordStatus.match ? onPressedNext : null,
              isLoading: isLoading,
              buttonShape: ButtonShape.pill,
            ),
          ],
        ),
      ),
    );
  }
}
