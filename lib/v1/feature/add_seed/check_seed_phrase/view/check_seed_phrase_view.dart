import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:app/v1/feature/add_seed/check_seed_phrase/check_seed_phrase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const _errorDisplayDuration = Duration(seconds: 2);
const _errorDelayDuration = Duration(seconds: 3);

/// Screen that allows user to check seed phrase for correctness.
@Deprecated('Use v2 version')
class CheckSeedPhraseView extends StatelessWidget {
  @Deprecated('Use v2 version')
  const CheckSeedPhraseView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return SafeArea(
      minimum: const EdgeInsets.only(bottom: DimensSize.d24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
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
                      style: StyleRes.h1.copyWith(color: colors.textPrimary),
                    ),
                    const SizedBox(height: DimensSize.d12),
                    Text(
                      LocaleKeys.checkSeedPhraseCorrectly.tr(),
                      style: StyleRes.primaryRegular
                          .copyWith(color: colors.textPrimary),
                    ),
                    const SizedBox(height: DimensSize.d24),
                    BlocConsumer<CheckSeedPhraseCubit,
                        CheckSeedPhraseCubitState>(
                      listener: (context, state) => state.maybeWhen<void>(
                        // ignore: no-empty-block
                        orElse: () {},
                        error: (_, __) {
                          inject<MessengerService>().show(
                            Message.error(
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
            const SizedBox(height: DimensSize.d12),
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
