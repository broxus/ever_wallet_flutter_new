import 'package:app/app/router/app_route.dart';
import 'package:app/feature/add_seed/create_password/create_password.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/enter_seed_phrase.dart';
import 'package:app/feature/onboarding/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template enter_seed_phrase_page}
/// Starting page for seed phrase entering.
/// {@endtemplate}
class EnterSeedPhrasePage extends StatelessWidget {
  /// {@macro enter_seed_phrase_page}
  const EnterSeedPhrasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EnterSeedPhraseCubit>(
      create: (context) => EnterSeedPhraseCubit(
        (phrase) => context.goFurther(
          AppRoute.createSeedPassword.path,
          extra: CreateSeedRouteExtra(phrase: phrase),
        ),
      )..init(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: const Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: OnboardingAppBar(),
          body: EnterSeedPhraseView(),
        ),
      ),
    );
  }
}
