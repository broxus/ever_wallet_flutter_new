import 'package:app/app/router/app_route.dart';
import 'package:app/app/router/routs/add_seed/add_seed.dart';
import 'package:app/generated/generated.dart';
import 'package:app/v1/feature/add_seed/check_seed_phrase/check_seed_phrase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template check_seed_phrase_page}
/// Entry point to check if user wrote down seed phrase correctly.
/// {@endtemplate}
class CheckSeedPhrasePage extends StatelessWidget {
  /// {@macro check_seed_phrase_page}
  const CheckSeedPhrasePage({
    required this.phrase,
    super.key,
  });

  final String? phrase;

  void _navigateToPassword(BuildContext context, String? phrase) =>
      context.goFurther(
        AppRoute.createSeedPassword.pathWithData(
          queryParameters: {
            if (phrase != null) addSeedPhraseQueryParam: phrase,
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckSeedPhraseCubit>(
      create: (context) => CheckSeedPhraseCubit(
        phrase,
        (String? phrase) => _navigateToPassword(context, phrase),
      )..initAnswers(),
      child: Scaffold(
        appBar: DefaultAppBar(
          onClosePressed: (context) => context.maybePop(),
          actions: [
            CommonButton.ghost(
              padding: EdgeInsets.zero,
              text: LocaleKeys.skipWord.tr(),
              onPressed: () => _navigateToPassword(context, phrase),
            ),
          ],
        ),
        body: const CheckSeedPhraseView(),
      ),
    );
  }
}
