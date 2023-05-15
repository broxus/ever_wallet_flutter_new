import 'package:app/app/utils/iterable_extensions.dart';
import 'package:app/feature/add_seed/check_seed_phrase/check_seed_phrase.dart';
import 'package:app/l10n/l10n.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template check_seed_answers_widget}
/// Widget for check seed phrase.
/// [currentIndex] displays which of [userAnswers] must be displayed as current.
/// [clearAnswer] calls if user taps on any word.
/// {@endtemplate}
class CheckSeedAnswersWidget extends StatelessWidget {
  /// {@macro check_seed_answers_widget}
  const CheckSeedAnswersWidget({
    required this.userAnswers,
    required this.currentIndex,
    required this.clearAnswer,
    super.key,
  });

  /// List of answers that user selected
  final List<CheckSeedCorrectAnswer> userAnswers;

  /// Index of answer that must be displayed as current.
  /// null if all answers are selected.
  final int? currentIndex;

  /// Callback to clear selected answer
  final ValueChanged<String> clearAnswer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: userAnswers
          .mapIndexed(_answerBuilder)
          .separated(const SizedBox(width: 16)),
    );
  }

  Widget _answerBuilder(int index, CheckSeedCorrectAnswer answer) {
    final isSelected = answer.word != '';
    final isCurrent = index == currentIndex;

    return Expanded(
      child: Builder(
        builder: (context) {
          final colors = context.themeStyle.colors;
          final l10n = context.l10n;
          return PressInkWidget(
            onPressed: isSelected ? () => clearAnswer(answer.word) : null,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      isCurrent ? colors.accentPrimary : colors.fillingTertiary,
                ),
              ),
              child: Text(
                isSelected
                    ? '${answer.wordIndex + 1}. ${answer.word}'
                    : '${l10n.word} #${answer.wordIndex + 1}',
                style: StyleRes.regular16.copyWith(
                  color:
                      isSelected ? colors.textSecondary : colors.textTertiary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
