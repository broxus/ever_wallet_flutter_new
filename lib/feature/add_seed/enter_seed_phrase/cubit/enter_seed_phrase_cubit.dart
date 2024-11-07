import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/app/service/network_connection/network_connection_service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/cubit/enter_seed_phrase_input_state.dart';
import 'package:app/feature/constants.dart';
import 'package:app/generated/locale_keys.g.dart';
import 'package:app/utils/mixins/connection_mixin.dart';
import 'package:app/utils/seed_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

part 'enter_seed_phrase_cubit.freezed.dart';

part 'enter_seed_phrase_state.dart';

/// Regexp that helps splitting seed phrase into words.
final seedSplitRegExp = RegExp(r'[ |;,:\n.]');

const _actualSeedPhraseLength = 12;
const _legacySeedPhraseLength = 24;

const _autoNavigationDelay = Duration(milliseconds: 500);

/// Callback that will be called when user correctly enter seed phrase.
typedef EnterSeedPhraseConfirmCallback = void Function(String phrase);

/// Cubit that manages the state of the seed phrase entering page.
class EnterSeedPhraseCubit extends Cubit<EnterSeedPhraseState>
    with ConnectionMixin {
  EnterSeedPhraseCubit(this.context, this.confirmCallback)
      : super(const EnterSeedPhraseState.initial());

  final _log = Logger('EnterSeedPhraseCubit');

  final BuildContext context;
  final EnterSeedPhraseConfirmCallback confirmCallback;

  final formKey = GlobalKey<FormState>();

  late List<TextEditingController> _controllers;
  late List<FocusNode> _focuses;
  late List<int> _allowedValues;
  late int _currentValue;

  /// Models of input
  late List<EnterSeedPhraseInputState> _inputModels;

  @override
  @protected
  final messengerService = inject<MessengerService>();

  @override
  @protected
  final networkConnectionService = inject<NetworkConnectionService>();

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
    _allowedValues =
        inject<NekotonRepository>().currentTransport.seedPhraseWordsCount;
    _currentValue = _allowedValues.first;
    final max = _allowedValues.max;
    _controllers = List.generate(max, (_) => TextEditingController());
    _focuses = List.generate(max, (_) => FocusNode());

    _inputModels = List.generate(
      max,
      (index) => EnterSeedPhraseInputState.input(
        controller: _controllers[index],
        focus: _focuses[index],
        index: index,
        hasError: false,
      ),
    );

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
    _focuses.forEachIndexed((index, f) {
      f.addListener(() => _checkInputCompletion(index));
    });
    final inputs = _inputModels.take(_currentValue).toList();
    emit(
      EnterSeedPhraseState.tab(
        allowedValues: _allowedValues,
        currentValue: _currentValue.clamp(0, inputs.length),
        inputs: inputs,
        displayPasteButton: true,
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

    _clearAllInputs();

    _currentValue = value;
    formKey.currentState?.reset();

    final st = state;
    if (st is _Tab) {
      final inputs = _inputModels.take(value).toList();
      emit(
        st.copyWith(
          currentValue: value.clamp(0, inputs.length),
          allowedValues: _allowedValues,
          inputs: inputs,
          displayPasteButton: true,
        ),
      );
    }
  }

  Future<void> confirmAction() async {
    if (!await checkConnection(context)) {
      return;
    }

    if (await _validateFormWithError()) {
      String? error;
      try {
        FocusManager.instance.primaryFocus?.unfocus();

        final buffer = StringBuffer();

        for (var i = 0; i < _currentValue; i++) {
          buffer
            ..write(_controllers[i].text.trim())
            ..write(' ');
        }

        final phrase = buffer.toString().trimRight();

        final mnemonicType = _currentValue == _legacySeedPhraseLength
            ? const MnemonicType.legacy()
            : defaultMnemonicType;

        await deriveFromPhrase(
          phrase: phrase,
          mnemonicType: mnemonicType,
        );
        confirmCallback(phrase);
      } on Exception catch (e, s) {
        _log.severe('confirmAction', e, s);
        error = e.toString();
      } on FfiException catch (e, s) {
        _log.severe('confirmAction FfiException', e, s);
        error = LocaleKeys.wrongSeed.tr();
      }
      if (error != null) {
        _showValidateError(error);
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

  /// Reset text of controller that triggers [_checkInputCompletion]
  void clearInputModel(int index) => _controllers[index].clear();

  Future<void> pastePhrase() async {
    final words = await getSeedListFromClipboard();

    switch (words.length) {
      case _actualSeedPhraseLength:
        changeTab(_actualSeedPhraseLength);
      case _legacySeedPhraseLength:
        changeTab(_legacySeedPhraseLength);
      default:
    }

    Future.delayed(const Duration(milliseconds: 100), () async {
      if (words.isNotEmpty && words.length == _currentValue) {
        for (final word in words) {
          if (!await _checkIsWordValid(word)) {
            words.clear();
            break;
          }
        }
      } else {
        words.clear();
      }

      if (words.isEmpty) {
        _resetFormAndError();

        _showValidateError(LocaleKeys.incorrectWordsFormat.tr());

        return;
      }

      _canAutoNavigate = false;

      words.asMap().forEach((index, word) {
        _controllers[index].value = TextEditingValue(
          text: word,
          selection: TextSelection.fromPosition(
            TextPosition(offset: word.length),
          ),
        );
      });

      await _validateFormWithError();

      _canAutoNavigate = true;
      _checkAutoNavigate();
    });
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

      await _validateFormWithError();
    }
  }

  void _clearAllInputs() {
    for (final controller in _controllers) {
      controller.clear();
    }
  }

  /// [word] is valid if it is in list of hints for this word.
  Future<bool> _checkIsWordValid(String word) async {
    final hints = await getHints(input: word);
    if (hints.contains(word)) {
      return true;
    }

    return false;
  }

  /// Validate form and return its status.
  /// It also updates state of cubit if there was some errors.
  ///
  /// Returns true if there was no any error, false otherwise.
  Future<bool> _validateFormWithError() async {
    final hasEmptyFields = !(formKey.currentState?.validate() ?? false);
    var hasWrongWords = false;

    for (var index = 0; index < _currentValue; index++) {
      final input = _inputModels[index];
      if (input is EnterSeedPhraseEntered &&
          !await _checkIsWordValid(input.text)) {
        hasWrongWords = true;
        _inputModels[index] = _inputModels[index].copyWith(hasError: true);
      }
    }

    final st = state;
    if (hasWrongWords && st is _Tab) {
      emit(st.copyWith(inputs: _inputModels.take(_currentValue).toList()));
    }

    if (hasEmptyFields) {
      _showValidateError(LocaleKeys.fillMissingWords.tr());
    } else if (hasWrongWords) {
      _showValidateError(LocaleKeys.incorrectWordsFormat.tr());
    }

    return !hasEmptyFields && !hasWrongWords;
  }

  void _showValidateError(String message) {
    inject<MessengerService>().show(
      Message.error(
        context: context,
        message: message,
        debounceTime: defaultInfoMessageDebounceDuration,
      ),
    );
  }

  /// Drop form validation state
  void _resetFormAndError() {
    formKey.currentState?.reset();
    var changedModels = false;
    for (var index = 0; index < _currentValue; index++) {
      if (_inputModels[index].hasError) {
        changedModels = true;
        _inputModels[index] = _inputModels[index].copyWith(hasError: false);
      }
    }
    final st = state;
    if (changedModels && st is _Tab) {
      emit(st.copyWith(inputs: _inputModels.take(_currentValue).toList()));
    }
  }

  /// If input with [index] has any text and it's not in focus
  void _checkInputCompletion(int index) {
    final controller = _controllers[index];
    final focus = _focuses[index];
    final inputModel = _inputModels[index];

    void update() {
      final st = state;
      if (st is _Tab) {
        emit(
          st.copyWith(inputs: _inputModels.take(_currentValue).toList()),
        );
      }
    }

    if (controller.text.isNotEmpty &&
        !focus.hasFocus &&
        inputModel is EnterSeedPhraseInput) {
      // if input entered, not focused and not completed yet
      _inputModels[index] =
          _inputModels[index] = EnterSeedPhraseInputState.input(
        controller: controller,
        focus: focus,
        index: index,
        hasError: false,
      );
      update();
    } else if (controller.text.isEmpty &&
        inputModel is EnterSeedPhraseEntered) {
      // if input is empty but still completed
      _inputModels[index] = EnterSeedPhraseInputState.input(
        controller: controller,
        focus: focus,
        index: index,
        hasError: false,
      );
      update();
    }
  }

  /// If true, then [_checkAutoNavigate] will work, else otherwise.
  /// This can be helpful to ignore this check, for example during paste phase
  bool _canAutoNavigate = true;

  /// if all inputs are completed, go next automatically
  void _checkAutoNavigate() {
    if (_canAutoNavigate &&
        _inputModels
            .take(_currentValue)
            .every((i) => i is EnterSeedPhraseEntered)) {
      Future.delayed(_autoNavigationDelay, confirmAction);
    }
  }
}
