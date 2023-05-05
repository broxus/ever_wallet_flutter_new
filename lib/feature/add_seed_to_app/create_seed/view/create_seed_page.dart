import 'package:app/feature/add_seed_to_app/create_seed/create_seed.dart';
import 'package:app/feature/onboarding/widgets/onboarding_app_bar.dart';
import 'package:flutter/material.dart';

/// {@template create_seed_page}
/// Starting page for seed creation.
/// {@endtemplate}
class CreateSeedPage extends StatelessWidget {
  /// {@macro create_seed_page}
  const CreateSeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const OnboardingAppBar(),
      body: CreateSeedView(
        skipCallback: (BuildContext context, List<String> phrase) {},
        checkCallback: (BuildContext context, List<String> phrase) {},
      ),
    );
  }
}
