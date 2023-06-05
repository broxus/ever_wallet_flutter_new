import 'package:app/feature/add_seed/create_password/create_password.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: cubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localization.createPassword,
                style: StyleRes.h1.copyWith(color: colors.textPrimary),
              ),
              const SizedBox(height: 16),
              Text(
                localization.createPasswordDescription,
                style:
                    StyleRes.primaryRegular.copyWith(color: colors.textPrimary),
              ),
              const SizedBox(height: 32),
              CommonInput(
                obscureText: true,
                controller: cubit.passwordController,
                focusNode: cubit.passwordFocus,
                hintText: localization.yourPassword,
                onSubmitted: (_) => cubit.confirmFocus.requestFocus(),
                validator: (_) {
                  if (cubit.passwordController.text.length >= 8) {
                    return null;
                  }
                  return localization.passwordLength;
                },
              ),
              const SizedBox(height: 12),
              CommonInput(
                obscureText: true,
                controller: cubit.confirmController,
                focusNode: cubit.confirmFocus,
                hintText: localization.confirmPassword,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => cubit.nextAction(),
                validator: (_) {
                  if (cubit.confirmController.text ==
                      cubit.passwordController.text) {
                    return null;
                  }

                  return localization.passwordsMatch;
                },
              ),
              const SizedBox(height: 12),
              const Spacer(),
              CommonButton.primary(
                text: localization.next,
                onPressed: cubit.nextAction,
                fillWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
