part of 'enter_seed_phrase_cubit.dart';

/// State for <EnterSeedPhraseCubit>
@freezed
class EnterSeedPhraseState with _$EnterSeedPhraseState {
  /// Initial state
  const factory EnterSeedPhraseState.initial() = _Initial;

  /// State that displays 12 or 24 words entering
  /// [allowedValues] and [currentValue] used for tab widget.
  /// If [allowedValues] contains only one item, tab widget must not be shown.
  /// [displayPasteButton] = false if there are no text in fields else true
  const factory EnterSeedPhraseState.tab({
    required List<int> allowedValues,
    required int currentValue,
    required List<EnterSeedPhraseInputState> inputs,
    required bool displayPasteButton,
  }) = _Tab;
}
