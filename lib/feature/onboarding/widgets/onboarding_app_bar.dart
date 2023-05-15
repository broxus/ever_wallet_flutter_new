import 'package:app/feature/widgets/widgets.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';

/// {@template onboarding_app_bar}
/// Default appbar for onboarding screens
/// {@endtemplate}
class OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// {@macro onboarding_app_bar}
  const OnboardingAppBar({
    this.actions,
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  /// See [DefaultAppBar.actions]
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return DefaultAppBar(
      backText: context.l10n.backWord,
      actions: actions,
      needDivider: false,
    );
  }
}
