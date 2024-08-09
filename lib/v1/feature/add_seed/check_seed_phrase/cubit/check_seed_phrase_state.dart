part of 'check_seed_phrase_cubit.dart';

@freezed
class CheckSeedPhraseCubitState with _$CheckSeedPhraseCubitState {
  const factory CheckSeedPhraseCubitState.initial() = _Initial;

  /// Display answer without any selections
  const factory CheckSeedPhraseCubitState.answer(
    List<String> availableAnswers,
    List<CheckSeedCorrectAnswer> userAnswers,
    int currentAnswerIndex,
  ) = _Answer;

  /// Correct selection. Other selections must be blocked.
  /// Question will change automatically
  const factory CheckSeedPhraseCubitState.correct(
    List<String> availableAnswers,
    List<CheckSeedCorrectAnswer> userAnswers,
  ) = _Correct;

  /// Error selection
  const factory CheckSeedPhraseCubitState.error(
    List<String> availableAnswers,
    List<CheckSeedCorrectAnswer> userAnswers,
  ) = _Error;
}
