import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Callback to make any action after user entered seed phrase name.
@Deprecated('Use v2 version')
typedef EnterSeedNameCompleteCallback = void Function(String? name);

/// {@template enter_seed_name_view}
/// Screen that allows user to enter name for seed phrase.
/// Result name will be passed to [callback].
/// {@endtemplate}
@Deprecated('Use v2 version')
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
    final colors = context.themeStyle.colors;

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
                      style: StyleRes.h1.copyWith(color: colors.textPrimary),
                    ),
                    const SizedBox(height: DimensSize.d12),
                    Text(
                      LocaleKeys.enterSeedNameScreenDescription.tr(),
                      style: StyleRes.primaryRegular
                          .copyWith(color: colors.textPrimary),
                    ),
                    const SizedBox(height: DimensSize.d24),
                    CommonInput(
                      controller: nameController,
                      titleText: LocaleKeys.seedName.tr(),
                      onSubmitted: (_) => _nextAction(),
                    ),
                  ],
                ),
              ),
            ),
            CommonButton.primary(
              text: LocaleKeys.continueWord.tr(),
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
