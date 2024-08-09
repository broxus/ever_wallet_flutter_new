import 'package:flutter/foundation.dart';

@immutable
class CheckSeedCorrectAnswer {
  const CheckSeedCorrectAnswer(this.word, this.wordIndex);

  /// If word is empty string then user doesn't answered
  final String word;

  /// Starts with 0
  final int wordIndex;

  CheckSeedCorrectAnswer copyWith({required String word}) =>
      CheckSeedCorrectAnswer(word, wordIndex);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckSeedCorrectAnswer &&
          runtimeType == other.runtimeType &&
          word == other.word &&
          wordIndex == other.wordIndex;

  @override
  int get hashCode => word.hashCode ^ wordIndex.hashCode;
}
