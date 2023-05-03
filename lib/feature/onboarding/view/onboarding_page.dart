import 'package:app/feature/onboarding/view/onboarding_view.dart';
import 'package:flutter/material.dart';

/// Entry point of the app if user not authenticated
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: OnboardingView(),
    );
  }
}
