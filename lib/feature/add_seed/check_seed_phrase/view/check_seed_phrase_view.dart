import 'package:app/feature/add_seed/check_seed_phrase/check_seed_phrase.dart';
import 'package:app/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Screen that allows user to check seed phrase for correctness.
class CheckSeedPhraseView extends StatelessWidget {
  const CheckSeedPhraseView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.themeStyle.colors;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.checkSeedPhrase,
              style: StyleRes.h1.copyWith(color: colors.textPrimary),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.checkSeedPhraseCorrectly,
              style:
                  StyleRes.primaryRegular.copyWith(color: colors.textPrimary),
            ),
            const SizedBox(height: 32),
            Expanded(
              child:
                  BlocBuilder<CheckSeedPhraseCubit, CheckSeedPhraseCubitState>(
                builder: (context, state) => state.when(
                  initial: Container.new,
                  answer: (available, user, index) => _buildCheckBody(
                    available,
                    user,
                    currentIndex: index,
                  ),
                  correct: _buildCheckBody,
                  error: (available, user) => _buildCheckBody(
                    available,
                    user,
                    isError: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckBody(
    List<String> available,
    List<CheckSeedCorrectAnswer> userAnswers, {
    int? currentIndex,
    bool isError = false,
  }) {
    return Builder(
      builder: (context) {
        final localization = context.l10n;
        final colors = context.themeStyle.colors;
        final cubit = context.read<CheckSeedPhraseCubit>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckSeedAnswersWidget(
              userAnswers: userAnswers,
              currentIndex: currentIndex,
              clearAnswer: cubit.clearAnswer,
            ),
            if (isError)
              Text(
                localization.seedIsWrong,
                style: StyleRes.addRegular.copyWith(color: colors.alert),
                textAlign: TextAlign.center,
              ),
            const Spacer(),
            CheckSeedAvailableAnswersWidget(
              availableAnswers: available,
              selectedAnswers: userAnswers.map((e) => e.word).toList(),
              selectAnswer: cubit.answerQuestion,
            ),
          ],
        );
      },
    );
  }
}
