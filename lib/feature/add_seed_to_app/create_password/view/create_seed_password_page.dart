import 'package:app/app/router/app_route.dart';
import 'package:app/feature/add_seed_to_app/create_password/create_password.dart';
import 'package:app/feature/onboarding/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// {@template create_seed_password_onboarding_page}
/// Entry point to create seed password.
/// {@endtemplate}
class CreateSeedPasswordOnboardingPage extends StatelessWidget {
  /// {@macro create_seed_password_onboarding_page}
  const CreateSeedPasswordOnboardingPage({
    required this.extra,
    super.key,
  });

  final CreateSeedRouteExtra extra;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const OnboardingAppBar(),
        body: CreateSeedPasswordView(
          name: null,
          phrase: extra.phrase,
          needBiometryIfPossible: true,
          setCurrentKey: true,
          // TODO(alex-a4): maybe this callback is optional because of guard
          callback: (context) => context.go(AppRoute.wallet.path),
        ),
      ),
    );
  }
}

/// {@template create_seed_password_profile_page}
/// Entry point to create seed password.
/// {@endtemplate}
class CreateSeedPasswordProfilePage extends StatelessWidget {
  /// {@macro create_seed_password_profile_page}
  const CreateSeedPasswordProfilePage({
    required this.extra,
    super.key,
  });

  final CreateSeedRouteExtra extra;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const OnboardingAppBar(),
        body: CreateSeedPasswordView(
          name: extra.name,
          phrase: extra.phrase,
          needBiometryIfPossible: false,
          setCurrentKey: false,
          // TODO(alex-a4): maybe this callback is optional because of guard
          callback: (context) => context.go(AppRoute.wallet.path),
        ),
      ),
    );
  }
}
