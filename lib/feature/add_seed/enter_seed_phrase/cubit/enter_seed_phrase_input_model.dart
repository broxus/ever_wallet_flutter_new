import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'enter_seed_phrase_input_model.freezed.dart';

/// Model of input word in seed phrase.
/// This model allows display 2 different states of every input.
/// input - ready to enter seed word
/// entered - displayed card with entered (but not 100% correct word).
@freezed
class EnterSeedPhraseInputModel with _$EnterSeedPhraseInputModel {
  const factory EnterSeedPhraseInputModel.input({
    required TextEditingController controller,
    required FocusNode focus,
    required int index,
    required bool hasError,
  }) = EnterSeedPhraseInput;

  const factory EnterSeedPhraseInputModel.entered({
    required String text,
    required int index,
    required bool hasError,
  }) = EnterSeedPhraseEntered;
}
