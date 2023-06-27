import 'package:app/feature/profile/seed_detail/widgets/widgets.dart';
import 'package:app/feature/profile/widgets/widgets.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that shows [DeriveKeysEnterPasswordSheet] to enter
/// password before deriving keys.
void showDeriveKeysSheetPassword(
  BuildContext context,
  String publicKey,
) {
  showCommonBottomSheet<void>(
    context: context,
    title: LocaleKeys.enterPasswordTo.tr(
      args: [LocaleKeys.addKey.tr().toLowerCase()],
    ),
    useAppBackgroundColor: true,
    body: (_, __) => DeriveKeysEnterPasswordSheet(publicKey: publicKey),
  );
}

/// This is a widget that displays password field to derive keys
class DeriveKeysEnterPasswordSheet extends StatelessWidget {
  const DeriveKeysEnterPasswordSheet({
    required this.publicKey,
    super.key,
  });

  final String publicKey;

  @override
  Widget build(BuildContext context) {
    return EnterCheckPasswordWidget(
      publicKey: publicKey,
      onPasswordAccepted: (password) => Navigator.of(context)
        ..pop()
        ..push(deriveKeysSheet(publicKey, password)),
    );
  }
}
