import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:app/v1/feature/add_seed/check_seed_phrase/check_seed_phrase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

const _errorDisplayDuration = Duration(seconds: 2);
const _errorDelayDuration = Duration(seconds: 3);

/// Screen that allows user to check seed phrase for correctness.
class CheckSeedPhraseView extends StatelessWidget {
  const CheckSeedPhraseView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SafeArea(
      minimum: const EdgeInsets.only(bottom: DimensSizeV2.d24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.letsCheckSeedPhrase.tr(),
                      style: theme.textStyles.headingXLarge,
                    ),
                    const SizedBox(height: DimensSizeV2.d12),
                    Text(
                      LocaleKeys.checkSeedPhraseCorrectly.tr(),
                      style: theme.textStyles.paragraphMedium,
                    ),
                    const SizedBox(height: DimensSizeV2.d24),
                    BlocConsumer<CheckSeedPhraseCubit,
                        CheckSeedPhraseCubitState>(
                      listener: (context, state) => state.maybeWhen<void>(
                        // ignore: no-empty-block
                        orElse: () {},
                        error: (_, __) {
                          inject<MessengerService>().show(
                            Message.error(
                              context: context,
                              message: LocaleKeys.seedIsWrong.tr(),
                              duration: _errorDisplayDuration,
                              debounceTime: _errorDelayDuration,
                            ),
                          );
                        },
                      ),
                      builder: (context, state) => state.when(
                        initial: Container.new,
                        answer: (available, user, index) => _buildAnswers(
                          available,
                          user,
                          currentIndex: index,
                        ),
                        correct: _buildAnswers,
                        error: _buildAnswers,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: DimensSizeV2.d12),
            BlocBuilder<CheckSeedPhraseCubit, CheckSeedPhraseCubitState>(
              builder: (context, state) => state.when(
                initial: Container.new,
                answer: (available, user, index) =>
                    _buildCheckAnswers(available, user),
                correct: _buildCheckAnswers,
                error: _buildCheckAnswers,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswers(
    List<String> _,
    List<CheckSeedCorrectAnswer> userAnswers, {
    int? currentIndex,
  }) {
    return Builder(
      builder: (context) {
        final cubit = context.read<CheckSeedPhraseCubit>();

        return CheckSeedAnswersWidget(
          userAnswers: userAnswers,
          currentIndex: currentIndex,
          clearAnswer: cubit.clearAnswer,
        );
      },
    );
  }

  Widget _buildCheckAnswers(
    List<String> available,
    List<CheckSeedCorrectAnswer> userAnswers,
  ) {
    return Builder(
      builder: (context) {
        final cubit = context.read<CheckSeedPhraseCubit>();

        return CheckSeedAvailableAnswersWidget(
          availableAnswers: available,
          selectedAnswers: userAnswers.map((e) => e.word).toList(),
          selectAnswer: cubit.answerQuestion,
        );
      },
    );
  }
}
