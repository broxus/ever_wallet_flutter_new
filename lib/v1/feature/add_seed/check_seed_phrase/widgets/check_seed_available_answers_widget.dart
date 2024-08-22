import 'package:app/v1/feature/add_seed/check_seed_phrase/check_seed_phrase.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

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
    return SafeArea(
      minimum: const EdgeInsets.only(bottom: DimensSize.d12),
      child: SeparatedColumn(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var index = 0; index < defaultWordsToCheckAmount; index++)
            _answersRow(
              availableAnswers.sublist(
                index * defaultWordsToCheckAmount,
                index * defaultWordsToCheckAmount + defaultWordsToCheckAmount,
              ),
            ),
        ],
      ),
    );
  }

  Widget _answersRow(List<String> answers) {
    return SeparatedRow(
      children: answers.map(_answerBuilder).toList(),
    );
  }

  Widget _answerBuilder(String answer) {
    final isSelected = selectedAnswers.contains(answer);

    return Expanded(
      child: AccentButton(
        title: answer,
        buttonShape: ButtonShape.pill,
        onPressed: isSelected ? null : () => selectAnswer(answer),
      ),
    );
  }
}
