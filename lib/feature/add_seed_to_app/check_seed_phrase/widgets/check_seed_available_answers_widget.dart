import 'package:app/app/utils/iterable_extensions.dart';
import 'package:app/feature/add_seed_to_app/check_seed_phrase/check_seed_phrase.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template check_seed_available_answers_widget}
/// Widget that allows user to select answers for seed phrase checking.
/// Widget displays list of available words for checking.
/// {@endtemplate}
class CheckSeedAvailableAnswersWidget extends StatelessWidget {
  /// {@macro check_seed_available_answers_widget}
  const CheckSeedAvailableAnswersWidget({
    required this.availableAnswers,
    required this.selectedAnswers,
    required this.selectAnswer,
    super.key,
  });

  /// List of available answers for checking.
  final List<String> availableAnswers;

  /// List of selected answers for checking (it will be hidden)
  final List<String> selectedAnswers;

  /// Callback that will be called when user tap on answer (it also can revert)
  final ValueChanged<String> selectAnswer;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 0; index < defaultWordsToCheckAmount; index++) ...[
          _answersRow(
            availableAnswers.sublist(
              index * defaultWordsToCheckAmount,
              index * defaultWordsToCheckAmount + defaultWordsToCheckAmount,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }

  Widget _answersRow(List<String> answers) {
    return Row(
      children: answers.map(_answerBuilder).separated(const SizedBox(width: 8)),
    );
  }

  Widget _answerBuilder(String answer) {
    final isSelected = selectedAnswers.contains(answer);

    return Expanded(
      child: Builder(
        builder: (context) {
          final colors = context.themeStyle.colors;

          return PressInkWidget(
            onPressed: isSelected ? null : () => selectAnswer(answer),
            child: DottedBorder(
              dashPattern: isSelected ? const [4, 4] : const [1, 0],
              color: colors.accentTertiary,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 4,
                  ),
                  child: Text(
                    isSelected ? '' : answer,
                    style: StyleRes.medium16
                        .copyWith(color: colors.textButtonSecondary),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
