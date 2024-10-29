import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'enter_seed_phrase_input_state.freezed.dart';

/// Model of input word in seed phrase.
/// This model allows display 2 different states of every input.
/// input - ready to enter seed word
/// entered - displayed card with entered (but not 100% correct word).
@freezed
class EnterSeedPhraseInputState with _$EnterSeedPhraseInputState {
  const factory EnterSeedPhraseInputState.input({
    required TextEditingController controller,
    required FocusNode focus,
    required int index,
    required bool hasError,
  }) = EnterSeedPhraseInput;

  const factory EnterSeedPhraseInputState.entered({
    required String text,
    required int index,
    required bool hasError,
  }) = EnterSeedPhraseEntered;
}
