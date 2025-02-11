import 'dart:math';

import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/v1/feature/add_seed/check_seed_phrase/cubit/cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'check_seed_phrase_cubit.freezed.dart';
part 'check_seed_phrase_state.dart';

const defaultWordsToCheckAmount = 3;
const defaultCheckAnswersAmount = 9;
const delayBeforeCompleteChecking = Duration(seconds: 1);

/// Cubit that allows user to check if he remembered seed phrase.
/// It generates random order of words that user can select from.
/// Cubit must be initialized by calling [initAnswers] to generate
/// [availableAnswers] list.
class CheckSeedPhraseCubit extends Cubit<CheckSeedPhraseCubitState>
    with BlocBaseMixin {
  factory CheckSeedPhraseCubit(
    SeedPhraseModel seed,
    ValueChanged<SeedPhraseModel> completeChecking,
  ) {
    final correct = _selectCorrectAnswers(seed);

    return CheckSeedPhraseCubit._(
      seed,
      completeChecking,
      correct,
      correct.map((e) => e.copyWith(word: '')).toList(),
    );
  }

  CheckSeedPhraseCubit._(
    this.seed,
    this.completeChecking,
    this._correctAnswers,
    this.userAnswers,
  ) : super(const CheckSeedPhraseCubitState.initial());

  final SeedPhraseModel seed;
  final List<CheckSeedCorrectAnswer> _correctAnswers;
  late final List<String> availableAnswers;

  /// Answers that user selected, if empty then user haven't selected it yet
  final List<CheckSeedCorrectAnswer> userAnswers;

  /// Navigate to other screen
  final ValueChanged<SeedPhraseModel> completeChecking;

  /// if null - all words selected
  int? currentCheckIndex = 0;

  void initAnswers() {
    availableAnswers = _generateAnswerWords(_correctAnswers);
    emitSafe(
      CheckSeedPhraseCubitState.answer(availableAnswers, userAnswers, 0),
    );
  }

  void answerQuestion(String answer) {
    if (state is _Correct) return;
    final index = currentCheckIndex;
    if (index == null) return;
    userAnswers[index] = userAnswers[index].copyWith(word: answer);
    _goNextOrValidate();
  }

  void clearAnswer(String answer) {
    if (state is _Correct) return;
    final answerIndex = userAnswers.indexWhere((a) => a.word == answer);
    userAnswers[answerIndex] = userAnswers[answerIndex].copyWith(word: '');
    _goNextOrValidate();
  }

  void _goNextOrValidate() {
    final nextIndex = _firstEmptyAnswer();
    if (nextIndex == null) {
      _validate();
    } else {
      _goNext(nextIndex);
    }
  }

  void _validate() {
    var hasError = false;
    _correctAnswers.forEachIndexed(
      (index, answer) =>
          hasError = answer.word != userAnswers[index].word || hasError,
    );
    if (hasError) {
      emitSafe(CheckSeedPhraseCubitState.error(availableAnswers, userAnswers));
      Future<void>.delayed(delayBeforeCompleteChecking, () {
        userAnswers.forEachIndexed(
          (index, answer) =>
              userAnswers[index] = userAnswers[index].copyWith(word: ''),
        );
        currentCheckIndex = 0;
        emitSafe(
          CheckSeedPhraseCubitState.answer(
            availableAnswers,
            userAnswers,
            0,
          ),
        );
      });
    } else {
      emitSafe(
        CheckSeedPhraseCubitState.correct(
          availableAnswers,
          List.of(userAnswers),
        ),
      );
      Future<void>.delayed(delayBeforeCompleteChecking, () {
        completeChecking(seed);
      });
    }
  }

  void _goNext(int nextIndex) {
    currentCheckIndex = nextIndex;
    emitSafe(
      CheckSeedPhraseCubitState.answer(
        availableAnswers,
        List.of(userAnswers),
        nextIndex,
      ),
    );
  }

  int? _firstEmptyAnswer() {
    for (var i = 0; i < userAnswers.length; i++) {
      if (userAnswers[i].word.isEmpty) return i;
    }

    return null;
  }

  /// Correct answers for internal checks
  static List<CheckSeedCorrectAnswer> _selectCorrectAnswers(
    SeedPhraseModel seed,
  ) {
    if (seed.isEmpty) {
      return [];
    }

    final rng = Random();
    final indices = <int>[];

    while (indices.length < defaultWordsToCheckAmount) {
      final number = rng.nextInt(seed.wordsCount);

      if (indices.contains(number)) {
        continue;
      }

      indices.add(number);
    }

    indices.sort();

    return [
      for (final index in indices)
        CheckSeedCorrectAnswer(
          seed.words[index],
          index,
        ),
    ];
  }

  /// List of words that users choose of
  List<String> _generateAnswerWords(
    List<CheckSeedCorrectAnswer> correct,
  ) {
    final correctWords = correct.map((e) => e.word).toList();
    final dictionary = getHints(input: '');
    final answers = <String>[...correctWords];
    final random = Random();
    while (answers.length < defaultCheckAnswersAmount) {
      final number = random.nextInt(dictionary.length);
      if (answers.contains(dictionary[number])) {
        continue;
      }
      answers.add(dictionary[number]);
    }
    // to be sure it was shuffled
    answers
      ..shuffle()
      ..shuffle()
      ..shuffle();

    return answers;
  }
}
