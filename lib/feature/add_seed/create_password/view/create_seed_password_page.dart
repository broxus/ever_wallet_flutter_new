import 'package:app/app/router/app_route.dart';
import 'package:app/feature/add_seed/create_password/create_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template create_seed_password_onboarding_page}
/// Entry point to create seed password from onboarding.
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
    return BlocProvider<CreateSeedPasswordCubit>(
      create: (context) => CreateSeedPasswordCubit(
        phrase: extra.phrase,
        setCurrentKey: true,
        // Redundant because of guard, but we need to pass it down.
        // ignore: no-empty-block
        completeCallback: () {},
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: const Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: DefaultAppBar(),
          body: CreateSeedPasswordView(needBiometryIfPossible: true),
        ),
      ),
    );
  }
}

/// {@template create_seed_password_profile_page}
/// Entry point to create seed password from profile.
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
    return BlocProvider<CreateSeedPasswordCubit>(
      create: (context) => CreateSeedPasswordCubit(
        phrase: extra.phrase,
        name: extra.name,
        // When we do this flow from profile, navigate to profile root
        completeCallback: () =>
            context.goNamed(AppRoute.manageSeedsAccounts.name),
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: const Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: DefaultAppBar(),
          body: CreateSeedPasswordView(needBiometryIfPossible: false),
        ),
      ),
    );
  }
}
