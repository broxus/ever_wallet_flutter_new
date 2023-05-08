import 'dart:async';

import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Callback that will be called when user enter passwords and creates seed
/// phrase in keystore.
typedef CreatePasswordWidgetNavigationCallback = void Function(
  BuildContext context,
);

/// {@template create_password_widget}
/// Screen that allows user set password for specified seed phrase.
/// This is a final screen in phrase creation flow and in the end seed phrase
/// automatically adds to keystore and flow will be closed.
/// {@endtemplate}
class CreateSeedPasswordView extends StatefulWidget {
  /// {@macro create_password_widget}
  const CreateSeedPasswordView({
    required this.phrase,
    required this.name,
    required this.callback,
    required this.setCurrentKey,
    required this.needBiometryIfPossible,
    super.key,
  });

  /// Seed phrase that should be added
  final List<String> phrase;

  /// Name of seed phrase if provided
  final String? name;

  /// Callback that will be called when user enter passwords and creates seed
  final CreatePasswordWidgetNavigationCallback callback;

  /// If true, then current key will be set as default (provided in onboarding)
  final bool setCurrentKey;

  /// If true, then biometry will be requested if possible
  final bool needBiometryIfPossible;

  @override
  State<CreateSeedPasswordView> createState() => _CreateSeedPasswordViewState();
}

class _CreateSeedPasswordViewState extends State<CreateSeedPasswordView> {
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  final passwordFocus = FocusNode();
  final confirmFocus = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    final localization = context.l10n;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          // TODO(alex-a4): add transport checking
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localization.create_password,
                style: StyleRes.pageTitle.copyWith(color: colors.textPrimary),
              ),
              const SizedBox(height: 16),
              Text(
                localization.create_password_description,
                style: StyleRes.bodyText.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(height: 32),
              CommonInput(
                obscureText: true,
                controller: passwordController,
                focusNode: passwordFocus,
                labelText: localization.your_password,
                onSubmitted: (_) => confirmFocus.requestFocus(),
                validator: (_) {
                  if (passwordController.text.length >= 8) {
                    return null;
                  }
                  return localization.password_length;
                },
              ),
              const SizedBox(height: 12),
              CommonInput(
                obscureText: true,
                controller: confirmController,
                focusNode: confirmFocus,
                labelText: localization.confirm_password,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _nextAction(),
                validator: (_) {
                  if (confirmController.text == passwordController.text) {
                    return null;
                  }

                  return localization.passwords_match;
                },
              ),
              const SizedBox(height: 12),
              if (widget.needBiometryIfPossible) getBiometricSwitcher(),
              const Spacer(),
              CommonButton.primary(
                text: localization.next,
                onPressed: _nextAction,
                fillWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getBiometricSwitcher() {
    final localization = context.l10n;
    final colors = context.themeStyle.colors;

    return Container(
      color: ColorsRes.lightBlue.withOpacity(0.1),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              localization.use_biometry_for_fast_login,
              style: StyleRes.regular16.copyWith(color: colors.textPrimary),
            ),
          ),
          const SizedBox(width: 16),
          CommonSwitchInput(
            value: true,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  Future<void> _nextAction({bool isEver = true}) async {
    if (formKey.currentState?.validate() ?? false) {
      // final keyRepo = context.read<KeysRepository>();
      // final accountsRepo = context.read<AccountsRepository>();
      // final key = await keyRepo.createKey(
      //   phrase: widget.phrase,
      //   password: passwordController.text,
      //   name: widget.name,
      // );
      // // make key visible for subscribers
      // if (widget.setCurrentKey) await keyRepo.setCurrentKey(key.publicKey);
      //
      // final overlay = DefaultDialogController.showFullScreenLoader();
      //
      // /// Waits for founding any accounts. If no accounts found - start creating a new one
      // late StreamSubscription sub;
      // sub = accountsRepo
      //     .accountsForStream(key.publicKey)
      //     .where((event) => event.isNotEmpty)
      //     .timeout(const Duration(seconds: 1), onTimeout: (c) => c.close())
      //     .listen(
      //   (accounts) {
      //     overlay.dismiss(animate: false);
      //     widget.callback(context);
      //     sub.cancel();
      //   },
      //   onDone: () async {
      //     await context.read<AccountsRepository>().addAccount(
      //           publicKey: key.publicKey,
      //           walletType: getDefaultWalletType(isEver),
      //           workchain: kDefaultWorkchain,
      //         );
      //     overlay.dismiss(animate: false);
      //     if (mounted) {
      //       widget.callback(context);
      //     }
      //     sub.cancel();
      //   },
      // );
    }
  }
}
