import 'package:app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Helper function that displays [LogOutConfirmSheet] and returns true, if user
/// decided to logout completely, false otherwise.
Future<bool> showLogOutConfirmSheet(BuildContext context) async {
  final result = await showCommonBottomSheet<bool>(
    context: context,
    centerTitle: true,
    body: (_, __) => const LogOutConfirmSheet(),
  );

  return result ?? false;
}

class LogOutConfirmSheet extends StatelessWidget {
  const LogOutConfirmSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: DimensSizeV2.d24),
        Text(
          LocaleKeys.areYouSure.tr(),
          textAlign: TextAlign.center,
          style: theme.textStyles.headingLarge,
        ),
        const SizedBox(height: DimensSizeV2.d8),
        Text(
          LocaleKeys.logoutConfirmText.tr(),
          textAlign: TextAlign.center,
          style: theme.textStyles.paragraphMedium,
        ),
        const SizedBox(height: DimensSizeV2.d24),
        DestructiveButton(
          title: LocaleKeys.logOut.tr(),
          onPressed: () => Navigator.of(context).pop(true),
          buttonShape: ButtonShape.pill,
        ),
        const SizedBox(height: DimensSizeV2.d8),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.cancelWord.tr(),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        const SizedBox(height: DimensSizeV2.d24),
      ],
    );
  }
}
