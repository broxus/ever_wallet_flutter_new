import 'package:app/v1/feature/add_seed/check_seed_phrase/check_seed_phrase.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template check_seed_available_answers_widget}
/// Widget that allows user to select answers for seed phrase checking.
/// Widget displays list of available words for checking.
/// {@endtemplate}
@Deprecated('Use v2 version')
class CheckSeedAvailableAnswersWidget extends StatelessWidget {
  /// {@macro check_seed_available_answers_widget}
  @Deprecated('Use v2 version')
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
      child: Builder(
        builder: (context) {
          final colors = context.themeStyle.colors;

          return PressScaleWidget(
            onPressed: isSelected ? null : () => selectAnswer(answer),
            child: SizedBox(
              height: DimensSize.d48,
              child: Material(
                color: isSelected
                    ? Colors.transparent
                    : colors.backgroundSecondary,
                shape:
                    const SquircleShapeBorder(cornerRadius: DimensRadius.max),
                child: DottedBorder(
                  customPath: (size) =>
                      const SquircleShapeBorder(cornerRadius: DimensRadius.max)
                          .getOuterPath(Offset.zero & size),
                  dashPattern: isSelected ? const [4, 4] : const [1, 0],
                  strokeWidth: isSelected ? DimensStroke.small : 0,
                  color: isSelected ? colors.strokePrimary : Colors.transparent,
                  child: Center(
                    child: Text(
                      answer,
                      style: StyleRes.secondaryBold.copyWith(
                        color: isSelected
                            ? colors.textSecondary
                            : colors.textPrimary,
                      ),
                    ),
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
