import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/localization/localization.dart';
import 'package:app/feature/onboarding/view/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Entry point of the app if user not authenticated
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocalizationBloc>(
      create: (context) => LocalizationBloc(inject<LocalizationService>()),
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        body: OnboardingView(),
      ),
    );
  }
}
