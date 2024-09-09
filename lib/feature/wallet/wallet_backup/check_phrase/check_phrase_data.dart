import 'package:app/v1/feature/add_seed/check_seed_phrase/cubit/check_seed_correct_answer.dart';

class CheckPhraseData {
  CheckPhraseData({
    required this.availableAnswers,
    this.userAnswers,
    this.currentCheckIndex = 0,
    this.isAllChosen = false,
  });

  final List<CheckSeedCorrectAnswer>? userAnswers;
  final List<String>? availableAnswers;
  final int currentCheckIndex;
  final bool isAllChosen;
}
