import 'package:app/feature/onboarding/bloc/onboarding_bloc.dart';
import 'package:app/feature/onboarding/view/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Onboarding')),
        body: const OnboardingView(),
      ),
    );
  }
}
