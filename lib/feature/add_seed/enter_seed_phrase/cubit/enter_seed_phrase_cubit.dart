import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/add_seed/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

part 'enter_seed_phrase_state.dart';

part 'enter_seed_phrase_cubit.freezed.dart';

/// Regexp that helps splitting seed phrase into words.
final seedSplitRegExp = RegExp(r'[ |;|,|:|\n|.]');
const _debugPhraseLength = 15;

const _legacySeedPhraseLength = 24;

/// Callback that will be called when user correctly enter seed phrase.
typedef EnterSeedPhraseConfirmCallback = void Function(List<String> phrase);

/// Cubit that manages the state of the seed phrase entering page.
class EnterSeedPhraseCubit extends Cubit<EnterSeedPhraseState> {
  EnterSeedPhraseCubit(this.confirmCallback)
      : super(const EnterSeedPhraseState.initial());

  final EnterSeedPhraseConfirmCallback confirmCallback;

  final formKey = GlobalKey<FormState>();

  /// This list is same length as [_controllers] and [_focuses].
  /// If item contains true, then user entered correct word in this field.
  /// Item validates only if there at least one character in the field and
  /// it's not in focus.
  late List<ValueNotifier<bool>> _inputsCompleted;

  late List<TextEditingController> _controllers;
  late List<FocusNode> _focuses;
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
    for (final i in _inputsCompleted) {
      i.dispose();
    }

    return super.close();
  }

  void init() {
    _allowedValues =
        inject<NekotonRepository>().currentTransport.seedPhraseWordsCount;
    _currentValue = _allowedValues.first;
    final max = _allowedValues.max;
    _controllers = List.generate(max, (_) => TextEditingController());
    _focuses = List.generate(max, (_) => FocusNode());
    _inputsCompleted = List.generate(max, (_) => ValueNotifier(false));

    _controllers.forEachIndexed((index, c) {
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

        _checkInputCompletion(index);
      });
    });
    _controllers[0].addListener(() {
      /// Only for 1-st controller allow paste as button
      /// It's some bug but Input's paste removes spaces so check with length
      if (_controllers[0].text.length > _debugPhraseLength) {
        pastePhrase();
      }
    });
    _focuses.forEachIndexed((index, f) {
      f.addListener(() => _checkInputCompletion(index));
    });
    emit(
      EnterSeedPhraseState.tab(
        allowedValues: _allowedValues,
        currentValue: _currentValue,
        controllers: _controllers.take(_currentValue).toList(),
        focuses: _focuses.take(_currentValue).toList(),
        displayPasteButton: true,
        inputsCompleted: _inputsCompleted.take(_currentValue).toList(),
      ),
    );
  }

  /// Callback for UI TextField widget
  Future<List<String>> suggestionsCallback(
    TextEditingController controller,
  ) async {
    final text = controller.value.text;
    if (text.isEmpty) return [];
    final hints = await getHints(input: text);
    if (hints.length == 1 && hints[0] == text) {
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
          displayPasteButton: true,
          inputsCompleted: _inputsCompleted.take(value).toList(),
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
        final mnemonicType = _currentValue == _legacySeedPhraseLength
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
      if (error != null) {
        inject<MessengerService>().show(Message.error(message: error));
      }
    }
  }

  /// [index] starts with 0
  void nextOrConfirm(int index) {
    if (index == _currentValue - 1) {
      confirmAction();
    } else {
      _focuses[index + 1].requestFocus();
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
        accountType: _currentValue == _legacySeedPhraseLength
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

    // TODO(alex-a4): fix text
    inject<MessengerService>().show(Message.error(message: 'Invalid phrase'));

    return isValid;
  }

  /// Drop form validation state
  void _resetFormAndError() => formKey.currentState?.reset();

  /// If input with [index] has any text and it's not in focus
  void _checkInputCompletion(int index) {
    final controller = _controllers[index];
    final focus = _focuses[index];
    final inputCompleted = _inputsCompleted[index];

    if (controller.text.isNotEmpty &&
        !focus.hasFocus &&
        !inputCompleted.value) {
      // TODO(alex-a4): decide if we need validation here
      // final text = controller.text;
      // final hints = await getHints(input: text);
      // if (hints.length == 1 && hints[0] == text) {
      // if input entered, not focus and not completed yet
      inputCompleted.value = true;
    } else if (controller.text.isEmpty && inputCompleted.value) {
      // if input is empty but still completed
      inputCompleted.value = false;
    }
  }
}
