part of 'check_seed_phrase_cubit.dart';

@Deprecated('Use v2 version')
@freezed
class CheckSeedPhraseCubitState with _$CheckSeedPhraseCubitState {
  @Deprecated('Use v2 version')
  const factory CheckSeedPhraseCubitState.initial() = _Initial;

  /// Display answer without any selections
  @Deprecated('Use v2 version')
  const factory CheckSeedPhraseCubitState.answer(
    List<String> availableAnswers,
    List<CheckSeedCorrectAnswer> userAnswers,
    int currentAnswerIndex,
  ) = _Answer;

  /// Correct selection. Other selections must be blocked.
  /// Question will change automatically
  @Deprecated('Use v2 version')
  const factory CheckSeedPhraseCubitState.correct(
    List<String> availableAnswers,
    List<CheckSeedCorrectAnswer> userAnswers,
  ) = _Correct;

  /// Error selection
  @Deprecated('Use v2 version')
  const factory CheckSeedPhraseCubitState.error(
    List<String> availableAnswers,
    List<CheckSeedCorrectAnswer> userAnswers,
  ) = _Error;
}
