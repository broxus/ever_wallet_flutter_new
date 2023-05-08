import 'package:app/feature/onboarding/widgets/onboarding_app_bar.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Callback to make any action after user entered seed phrase name.
typedef EnterSeedNameNavigationCallback = void Function(
  BuildContext context,
  String? name,
);

/// {@template enter_seed_name_view}
/// Screen that allows user to enter name for seed phrase.
/// Result name will be passed to [callback].
/// {@endtemplate}
class EnterSeedNameView extends StatefulWidget {
  /// {@macro enter_seed_name_view}
  const EnterSeedNameView({
    required this.callback,
    super.key,
  });

  /// Callback that will be called when user entered seed phrase name.
  final EnterSeedNameNavigationCallback callback;

  @override
  State<EnterSeedNameView> createState() => _EnterSeedNameViewState();
}

class _EnterSeedNameViewState extends State<EnterSeedNameView> {
  final nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;
    final colors = context.themeStyle.colors;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const OnboardingAppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localization.seed_phrase_name_title,
                  style: StyleRes.pageTitle.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 12),
                Text(
                  localization.seed_phrase_name_description,
                  style: StyleRes.bodyText.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                CommonInput(
                  controller: nameController,
                  height: 52,
                  labelText: localization.seed_name,
                  onSubmitted: (_) => _nextAction(),
                ),
                const Spacer(),
                CommonButton.primary(
                  text: localization.continue_word,
                  onPressed: _nextAction,
                  fillWidth: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _nextAction() {
    final name = nameController.text.trim();
    widget.callback(context, name.isEmpty ? null : name);
  }
}
