import 'package:app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that displays [LogOutConfirmSheet] and returns true, if user
/// decided to logout completely, false otherwise.
Future<bool> showLogOutConfirmSheet(BuildContext context) async {
  final result = await showCommonBottomSheet<bool>(
    context: context,
    title: LocaleKeys.areYouSure.tr(),
    useAppBackgroundColor: true,
    centerTitle: true,
    body: (_, __) => const LogOutConfirmSheet(),
  );

  return result ?? false;
}

class LogOutConfirmSheet extends StatelessWidget {
  const LogOutConfirmSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          LocaleKeys.logoutConfirmText.tr(),
          textAlign: TextAlign.center,
          style: StyleRes.primaryRegular.copyWith(color: colors.textPrimary),
        ),
        const SizedBox(height: DimensSize.d16),
        CommonButton(
          buttonType: EverButtonType.secondary,
          contentColor: colors.alert,
          text: LocaleKeys.logOut.tr(),
          onPressed: () => Navigator.of(context).pop(true),
        ),
        CommonButton.primary(
          fillWidth: true,
          text: LocaleKeys.cancelWord.tr(),
          onPressed: () => Navigator.of(context).pop(false),
        ),
      ],
    );
  }
}
