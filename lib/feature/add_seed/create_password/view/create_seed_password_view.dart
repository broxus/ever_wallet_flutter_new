import 'package:app/feature/add_seed/create_password/create_password.dart';
import 'package:app/generated/assets.gen.dart';
import 'package:app/l10n/l10n.dart';
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
    final localization = context.l10n;

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
                            localization.createPassword,
                            style:
                                StyleRes.h1.copyWith(color: colors.textPrimary),
                          ),
                          const SizedBox(height: DimensSize.d16),
                          Text(
                            localization.createPasswordDescription,
                            style: StyleRes.primaryRegular
                                .copyWith(color: colors.textPrimary),
                          ),
                          const SizedBox(height: DimensSize.d32),
                          CommonInput(
                            titleText: localization.yourPassword,
                            subtitleText: localization.passwordDescription,
                            obscureText: state.obscurePassword,
                            controller: cubit.passwordController,
                            focusNode: cubit.passwordFocus,
                            hintText: localization.randomPassword,
                            onSubmitted: (_) =>
                                cubit.confirmFocus.requestFocus(),
                            validator: (_) =>
                                _validatePassword(cubit, localization),
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
                            titleText: localization.confirmPassword,
                            subtitleText: localization.passwordDescription,
                            obscureText: state.obscureConfirm,
                            controller: cubit.confirmController,
                            focusNode: cubit.confirmFocus,
                            hintText: localization.randomPassword,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => cubit.nextAction(),
                            validator: (_) =>
                                _validateRepeatPassword(cubit, localization),
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
                    text: localization.createWord,
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
    AppLocalizations localization,
  ) {
    if (cubit.passwordController.text.length >= _minPasswordLength) {
      return null;
    }

    return localization.passwordLength;
  }

  String? _validateRepeatPassword(
    CreateSeedPasswordCubit cubit,
    AppLocalizations localization,
  ) {
    if (cubit.confirmController.text == cubit.passwordController.text) {
      return null;
    }

    return localization.passwordsMatch;
  }
}
