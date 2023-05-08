import 'package:app/app/router/app_route.dart';
import 'package:app/feature/add_seed_to_app/check_seed_phrase/check_seed_phrase.dart';
import 'package:app/feature/add_seed_to_app/create_password/create_password.dart';
import 'package:app/feature/onboarding/widgets/onboarding_app_bar.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template check_seed_phrase_page}
/// Entry point to check if user wrote down seed phrase correctly.
/// {@endtemplate}
class CheckSeedPhrasePage extends StatefulWidget {
  /// {@macro check_seed_phrase_page}
  const CheckSeedPhrasePage({
    required this.extra,
    super.key,
  });

  final CreateSeedRouteExtra extra;

  @override
  State<CheckSeedPhrasePage> createState() => _CheckSeedPhrasePageState();
}

class _CheckSeedPhrasePageState extends State<CheckSeedPhrasePage> {
  void _navigateToPassword(BuildContext context) =>
      context.goFurther(AppRoute.createSeedPassword.path, extra: widget.extra);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckSeedPhraseCubit>(
      create: (context) => CheckSeedPhraseCubit(
        widget.extra.phrase,
        () => _navigateToPassword(context),
      )..initAnswers(),
      child: Scaffold(
        appBar: OnboardingAppBar(
          actions: [
            CommonButton.ghostNoPadding(
              text: context.l10n.skip_word,
              onPressed: () => _navigateToPassword(context),
            ),
          ],
        ),
        body: CheckSeedPhraseView(
          navigateToPassword: _navigateToPassword,
        ),
      ),
    );
  }
}
