import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/localization/localization.dart';
import 'package:app/v2/feature/onboarding/view/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Entry point of the app if user not authenticated
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeStyle = context.themeStyleV2;
    return BlocProvider<LocalizationBloc>(
      create: (context) => LocalizationBloc(inject<LocalizationService>()),
      child: Scaffold(
        backgroundColor: themeStyle.colors.background0,
        resizeToAvoidBottomInset: false,
        body: const OnboardingView(),
      ),
    );
  }
}
