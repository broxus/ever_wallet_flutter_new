import 'package:app/generated/generated.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

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
    final theme = context.themeStyleV2;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(DimensSize.d16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      LocaleKeys.enterSeedNameScreenTitle.tr(),
                      style: theme.textStyles.headingXLarge,
                    ),
                    const SizedBox(height: DimensSizeV2.d12),
                    Text(
                      LocaleKeys.enterSeedNameScreenDescription.tr(),
                      style: theme.textStyles.paragraphMedium,
                    ),
                    const SizedBox(height: DimensSizeV2.d24),
                    PrimaryTextField(
                      maxLength: maxLengthForMainEntities,
                      textEditingController: nameController,
                      hintText: LocaleKeys.seedName.tr(),
                      onSubmit: (_) => _nextAction(),
                    ),
                  ],
                ),
              ),
            ),
            AccentButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.continueWord.tr(),
              onPressed: _nextAction,
            ),
            const SizedBox(height: DimensSizeV2.d12),
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
