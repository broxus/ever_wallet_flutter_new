import 'package:app/feature/add_seed/create_password/create_password.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const _minPasswordLength = 8;

/// {@template create_password_widget}
/// Screen that allows user set password for specified seed phrase.
/// This is a final screen in phrase creation flow and in the end seed phrase
/// automatically adds to keystore and flow will be closed.
/// {@endtemplate}
class CreateSeedPasswordView extends StatelessWidget {
  /// {@macro create_password_widget}
  const CreateSeedPasswordView({
    required this.needBiometryIfPossible,
    super.key,
  });

  /// If true, then biometry will be requested if possible
  final bool needBiometryIfPossible;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    final cubit = context.read<CreateSeedPasswordCubit>();

    return SafeArea(
      minimum: const EdgeInsets.only(bottom: DimensSize.d16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
        child: Form(
          key: cubit.formKey,
          child: BlocBuilder<CreateSeedPasswordCubit, CreateSeedPasswordState>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.createPassword.tr(),
                            style:
                                StyleRes.h1.copyWith(color: colors.textPrimary),
                          ),
                          const SizedBox(height: DimensSize.d16),
                          Text(
                            LocaleKeys.createPasswordDescription.tr(),
                            style: StyleRes.primaryRegular
                                .copyWith(color: colors.textPrimary),
                          ),
                          const SizedBox(height: DimensSize.d32),
                          CommonInput(
                            keyboardType: TextInputType.visiblePassword,
                            titleText: LocaleKeys.yourPassword.tr(),
                            subtitleText: LocaleKeys.passwordDescription.tr(),
                            obscureText: state.obscurePassword,
                            controller: cubit.passwordController,
                            focusNode: cubit.passwordFocus,
                            hintText: LocaleKeys.randomPassword.tr(),
                            onSubmitted: (_) =>
                                cubit.confirmFocus.requestFocus(),
                            validator: (_) => _validatePassword(cubit),
                            suffixIcon: CommonIconButton.svg(
                              color: colors.textSecondary,
                              svg: state.obscurePassword
                                  ? Assets.images.openedEye.path
                                  : Assets.images.closedEye.path,
                              buttonType: EverButtonType.ghost,
                              onPressed: () {
                                if (state.obscurePassword) {
                                  cubit.showPassword();
                                } else {
                                  cubit.hidePassword();
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: DimensSize.d12),
                          CommonInput(
                            keyboardType: TextInputType.visiblePassword,
                            titleText: LocaleKeys.confirmPassword.tr(),
                            subtitleText: LocaleKeys.passwordDescription.tr(),
                            obscureText: state.obscureConfirm,
                            controller: cubit.confirmController,
                            focusNode: cubit.confirmFocus,
                            hintText: LocaleKeys.randomPassword.tr(),
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => cubit.nextAction(),
                            validator: (_) => _validateRepeatPassword(cubit),
                            suffixIcon: CommonIconButton.svg(
                              color: colors.textSecondary,
                              svg: state.obscureConfirm
                                  ? Assets.images.openedEye.path
                                  : Assets.images.closedEye.path,
                              buttonType: EverButtonType.ghost,
                              onPressed: () {
                                if (state.obscureConfirm) {
                                  cubit.showConfirm();
                                } else {
                                  cubit.hideConfirm();
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: DimensSize.d12),
                        ],
                      ),
                    ),
                  ),
                  CommonButton.primary(
                    text: LocaleKeys.createWord.tr(),
                    onPressed: cubit.nextAction,
                    fillWidth: true,
                    isLoading: state.isLoading,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  String? _validatePassword(
    CreateSeedPasswordCubit cubit,
  ) {
    if (cubit.passwordController.text.length >= _minPasswordLength) {
      return null;
    }

    return LocaleKeys.passwordLength.tr();
  }

  String? _validateRepeatPassword(
    CreateSeedPasswordCubit cubit,
  ) {
    // Should not validate second field if first is invalid
    if (_validatePassword(cubit) != null) {
      return null;
    }

    if (cubit.confirmController.text == cubit.passwordController.text) {
      return null;
    }

    return LocaleKeys.passwordsMatch.tr();
  }
}
