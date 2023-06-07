import 'package:app/feature/add_seed/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'enter_seed_phrase_state.dart';

part 'enter_seed_phrase_cubit.freezed.dart';

/// Regexp that helps splitting seed phrase into words.
final seedSplitRegExp = RegExp(r'[ |;|,|:|\n|.]');
const _debugPhraseLength = 15;

/// Callback that will be called when user correctly enter seed phrase.
typedef EnterSeedPhraseConfirmCallback = void Function(List<String> phrase);

/// Cubit that manages the state of the seed phrase entering page.
class EnterSeedPhraseCubit extends Cubit<EnterSeedPhraseState> {
  EnterSeedPhraseCubit(this.confirmCallback)
      : super(const EnterSeedPhraseState.initial());

  final EnterSeedPhraseConfirmCallback confirmCallback;

  final formKey = GlobalKey<FormState>();
  final _controllers = List.generate(24, (_) => TextEditingController());
  final _focuses = List.generate(24, (_) => FocusNode());
  final _possibleValues = const <int>[12, 24];
  late List<int> _allowedValues;
  late int _currentValue;

  @override
  Future<void> close() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focuses) {
      f.dispose();
    }

    return super.close();
  }

  void init() {
    // TODO(alex-a4): uncomment when transport selection will be added
    // if (context.read<TransportRepository>().isEverTransport) {
    //   _allowedValues = possibleValues;
    // } else {
    _allowedValues = [_possibleValues.first];
    // }
    _currentValue = _allowedValues.first;
    for (final c in _controllers) {
      c.addListener(() {
        final hasText =
            _controllers.any((controller) => controller.text.isNotEmpty);
        final st = state;
        // hasText means paste button must not be shown
        if (st is _Tab && st.displayPasteButton == hasText) {
          emit(st.copyWith(displayPasteButton: !hasText));
        }
        if (hasText) {
          _checkDebugPhraseGenerating();
        }
      });
    }
    _controllers[0].addListener(() {
      /// Only for 1-st controller allow paste as button
      /// It's some bug but Input's paste removes spaces so check with length
      if (_controllers[0].text.length > _debugPhraseLength) {
        pastePhrase();
      }
    });
    emit(
      EnterSeedPhraseState.tab(
        allowedValues: _allowedValues,
        currentValue: _currentValue,
        controllers: _controllers.take(_currentValue).toList(),
        focuses: _focuses.take(_currentValue).toList(),
        displayPasteButton: true,
      ),
    );
  }

  /// Callback for UI TextField widget
  Future<List<String>> suggestionsCallback(
    TextEditingController controller,
  ) async {
    final value = controller.value;
    if (value.text.isEmpty) return [];
    final text = value.text.substring(0, value.selection.start);
    final hints = await getHints(input: text);
    if (hints.length == 1 && hints[0] == value.text) {
      return [];
    }

    return hints;
  }

  void changeTab(int value) {
    if (value == _currentValue) return;
    _currentValue = value;
    formKey.currentState?.reset();

    final st = state;
    if (st is _Tab) {
      emit(
        st.copyWith(
          currentValue: value,
          controllers: _controllers.take(value).toList(),
          focuses: _focuses.take(value).toList(),
          allowedValues: _allowedValues,
          formError: null,
          displayPasteButton: true,
        ),
      );
    }
  }

  Future<void> confirmAction() async {
    if (_validateFormWithError()) {
      String? error;
      try {
        FocusManager.instance.primaryFocus?.unfocus();
        final phrase =
            _controllers.take(_currentValue).map((e) => e.text).toList();
        final mnemonicType = _currentValue == _possibleValues.last
            ? const MnemonicType.legacy()
            : defaultMnemonicType;

        await deriveFromPhrase(
          phrase: phrase.join(' '),
          mnemonicType: mnemonicType,
        );
        confirmCallback(phrase);
      } on Exception catch (e) {
        error = e.toString();
      } on Object catch (e) {
        error = e.toString();
      }
      final st = state;
      if (error != null && st is _Tab) {
        emit(st.copyWith(formError: error));
      }
    }
  }

  void nextOrConfirm(int index) {
    if (index == _currentValue) {
      confirmAction();
    } else {
      _focuses[index].requestFocus();
    }
  }

  void clearFields() {
    for (final c in _controllers) {
      c
        ..text = ''
        ..selection = const TextSelection.collapsed(offset: 0);
    }
    _resetFormAndError();
  }

  /// [index] start with 0
  void onSuggestionSelected(
    String suggestion,
    int index,
  ) {
    _controllers[index]
      ..text = suggestion
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: suggestion.length),
      );

    nextOrConfirm(index);
  }

  Future<void> pastePhrase() async {
    final clipboard = await Clipboard.getData(Clipboard.kTextPlain);
    final words = clipboard?.text
            ?.replaceAll(RegExp(r'\\s+'), ' ')
            .split(seedSplitRegExp) ??
        <String>[];

    if (words.isNotEmpty && words.length == _currentValue) {
      for (final word in words) {
        if ((await getHints(input: word)).isEmpty) {
          words.clear();
          break;
        }
      }
    } else {
      words.clear();
    }

    if (words.isEmpty) {
      _resetFormAndError();

      // unawaited(
      //   showErrorSnackbar(
      //     context: context,
      //     message: ,
      //   ),
      // );
      return;
    }

    words.asMap().forEach((index, word) {
      _controllers[index].value = TextEditingValue(
        text: word,
        selection: TextSelection.fromPosition(
          TextPosition(offset: word.length),
        ),
      );
    });
    _validateFormWithError();
  }

  /// Check if debug phrase is entered in any text field
  Future<void> _checkDebugPhraseGenerating() async {
    if (_controllers.any((e) => e.text == 'speakfriendandenter')) {
      final key = await generateKey(
        accountType: _currentValue == _possibleValues.last
            ? const MnemonicType.legacy()
            : defaultMnemonicType,
      );

      for (var i = 0; i < _controllers.take(_currentValue).length; i++) {
        final text = key.words[i];
        _controllers[i].text = text;
        _controllers[i].selection =
            TextSelection.fromPosition(TextPosition(offset: text.length));
      }
      _validateFormWithError();
    }
  }

  /// Validate form and return its status
  bool _validateFormWithError() {
    final isValid = formKey.currentState?.validate() ?? false;
    final st = state;
    if (st is _Tab) {
      emit(st.copyWith(formError: isValid ? null : ''));
    }

    return isValid;
  }

  /// Drop form validation state
  void _resetFormAndError() {
    formKey.currentState?.reset();
    final st = state;
    if (st is _Tab) {
      emit(st.copyWith(formError: null));
    }
  }
}
