import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Callback to make any action after user entered seed phrase name.
typedef EnterSeedNameCompleteCallback = void Function(String? name);

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
  final EnterSeedNameCompleteCallback callback;

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

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(DimensSize.d16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localization.seedPhraseNameTitle,
              style: StyleRes.h1.copyWith(color: colors.textPrimary),
            ),
            const SizedBox(height: DimensSize.d12),
            Text(
              localization.seedPhraseNameDescription,
              style:
                  StyleRes.primaryRegular.copyWith(color: colors.textPrimary),
            ),
            const SizedBox(height: DimensSize.d20),
            CommonInput(
              controller: nameController,
              hintText: localization.seedName,
              onSubmitted: (_) => _nextAction(),
            ),
            const Spacer(),
            CommonButton.primary(
              text: localization.continueWord,
              onPressed: _nextAction,
              fillWidth: true,
            ),
          ],
        ),
      ),
    );
  }

  void _nextAction() {
    final name = nameController.text.trim();
    widget.callback(name.isEmpty ? null : name);
  }
}
