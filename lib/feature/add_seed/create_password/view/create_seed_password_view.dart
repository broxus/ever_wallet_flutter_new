import 'package:app/feature/add_seed/create_password/cubit/create_seed_password_cubit.dart';
import 'package:app/feature/add_seed/create_password/model/password_status.dart';
import 'package:app/feature/add_seed/create_password/widgets/icon_eye_widget.dart';
import 'package:app/feature/add_seed/create_password/widgets/password_info_section.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class CreateSeedPasswordView extends StatelessWidget {
  const CreateSeedPasswordView({
    required this.needBiometryIfPossible,
    super.key,
  });

  /// If true, then biometry will be requested if possible
  final bool needBiometryIfPossible;

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;
    final cubit = context.read<CreateSeedPasswordCubit>();

    return SafeArea(
      minimum: const EdgeInsets.only(bottom: DimensSize.d16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
        child: BlocBuilder<CreateSeedPasswordCubit, CreateSeedPasswordState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            LocaleKeys.confirmPasswordTitle.tr(),
                            style: themeStyle.textStyles.headingLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: DimensSize.d8),
                        PrimaryText(LocaleKeys.confirmPasswordSubtitle.tr()),
                        const SizedBox(height: DimensSize.d24),
                        PrimaryTextField(
                          keyboardType: TextInputType.visiblePassword,
                          hintText: LocaleKeys.confirmSetPasswordHint.tr(),
                          suffixes: [
                            IconEyeWidget(
                              onPressed: () {
                                if (state.obscurePassword) {
                                  cubit.showPassword();
                                } else {
                                  cubit.hidePassword();
                                }
                              },
                              isTurnedOn: !state.obscurePassword,
                            ),
                          ],
                          isObscureText: state.obscurePassword,
                          textEditingController: cubit.passwordController,
                        ),
                        const SizedBox(height: DimensSize.d8),
                        PrimaryTextField(
                          keyboardType: TextInputType.visiblePassword,
                          hintText: LocaleKeys.confirmRepeatPasswordHint.tr(),
                          suffixes: [
                            IconEyeWidget(
                              onPressed: () {
                                if (state.obscureConfirm) {
                                  cubit.showConfirm();
                                } else {
                                  cubit.hideConfirm();
                                }
                              },
                              isTurnedOn: !state.obscureConfirm,
                            ),
                          ],
                          isObscureText: state.obscureConfirm,
                          textEditingController: cubit.confirmController,
                          textInputAction: TextInputAction.done,
                        ),
                        const SizedBox(height: DimensSize.d24),
                        PasswordInfoSection(
                          themeStyle: themeStyle,
                          status: state.status,
                        ),
                        const SizedBox(height: DimensSize.d12),
                      ],
                    ),
                  ),
                ),
                AccentButton(
                  title: LocaleKeys.continueWord.tr(),
                  onPressed: state.status == PasswordStatus.match
                      ? cubit.nextAction
                      : null,
                  isLoading: state.isLoading,
                  buttonShape: ButtonShape.pill,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
