import 'package:flutter/foundation.dart';

@Deprecated('Use v2 version')
@immutable
class CheckSeedCorrectAnswer {
  @Deprecated('Use v2 version')
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