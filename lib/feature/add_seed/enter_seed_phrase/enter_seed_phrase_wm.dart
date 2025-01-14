import 'package:app/app/router/app_route.dart';
import 'package:app/app/router/routs/add_seed/add_seed.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/data/input_data.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/data/tab_data.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/enter_seed_phrase.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/enter_seed_phrase_model.dart';
import 'package:app/feature/constants.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/seed_utils.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Factory method for creating [EnterSeedPhraseWidgetModel]
EnterSeedPhraseWidgetModel defaultEnterSeedPhraseWidgetModelFactory(
  BuildContext context,
) {
  return EnterSeedPhraseWidgetModel(
    EnterSeedPhraseModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
      inject(),
    ),
  );
}

/// [WidgetModel] для [EnterSeedPhrase]
class EnterSeedPhraseWidgetModel
    extends CustomWidgetModel<EnterSeedPhrase, EnterSeedPhraseModel> {
  EnterSeedPhraseWidgetModel(
    super.model,
  );

  final formKey = GlobalKey<FormState>();

  final _log = Logger('EnterSeedPhraseCubit');

  late final _displayPasteButtonState = createNotifier<bool>(true);
  late final _tabState = createNotifier<EnterSeedPhraseTabData?>();

  /// TODO так просто не держать
  late final _allowedValues = model.seedPhraseWordsCount;

  /// TODO так просто не держать
  late int _currentValue = _allowedValues.first;

  /// TODO так просто не держать
  late final List<EnterSeedPhraseInputData> _inputDataList = List.unmodifiable(
    [
      for (int i = 0; i < _allowedValues.max; i++)
        EnterSeedPhraseInputData.init(i)
          ..controller.addListener(() {
            final hasText = _hasText;

            if (_isDisplayPasteButton == hasText) {
              _displayPasteButtonState.accept(!hasText);
            }

            if (hasText) {
              _checkDebugPhraseGenerating();
            }

            _checkInputCompletion(i);
          })
          ..focusNode.addListener(() => _checkInputCompletion(i)),
    ],
  );

  ListenableState<bool> get displayPasteButtonState => _displayPasteButtonState;

  ListenableState<EnterSeedPhraseTabData?> get tabState => _tabState;

  int get _actualSeedPhraseLength => model.actualSeedPhraseLength;

  int get _legacySeedPhraseLength => model.legacySeedPhraseLength;

  EnterSeedPhraseTabData? get _tabData => _tabState.value;

  bool get _hasText => _inputDataList.any((data) => data.text.isNotEmpty);

  bool get _isDisplayPasteButton => displayPasteButtonState.value ?? true;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  @override
  void dispose() {
    for (final c in _inputDataList) {
      c.dispose();
    }

    super.dispose();
  }

  void _init() {
    final inputs = _inputDataList.take(_currentValue).toList();
    _tabState.accept(
      EnterSeedPhraseTabData(
        allowedValues: _allowedValues,
        currentValue: _currentValue.clamp(0, inputs.length),
        inputs: inputs,
      ),
    );
  }

  /// Check if debug phrase is entered in any text field
  Future<void> _checkDebugPhraseGenerating() async {
    if (!_inputDataList.any((data) => data.text == 'speakfriendandenter')) {
      return;
    }

    final key = await model.getKey(_currentValue);

    final count = _inputDataList.take(_currentValue).length;

    for (var i = 0; i < count; i++) {
      final text = key.words[i];
      _inputDataList[i].controller
        ..text = text
        ..selection = TextSelection.fromPosition(
          TextPosition(offset: text.length),
        );
    }

    await _validateFormWithError();
  }

  /// If input with [index] has any text and it's not in focus
  void _checkInputCompletion(int index) {
    final data = _inputDataList[index];

    if ((data.text.isNotEmpty && !data.isFocused) || data.text.isEmpty) {
      _updateInputDataList(
        index: index,
        isError: false,
      );

      _updateTab(
        inputs: _inputDataList.take(_currentValue).toList(),
      );
    }
  }

  void _confirm(String phrase) {
    final path =
        GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    final route = getCurrentAppRoute(fullPath: path);

    // because of automatic navigation, we may face problem with double
    // navigation here.
    if (route != AppRoute.createSeedPassword) {
      context.goFurther(
        AppRoute.createSeedPassword.pathWithData(
          queryParameters: {
            addSeedPhraseQueryParam: phrase,
          },
        ),
        preserveQueryParams: true,
      );
    }
  }

  /// Validate form and return its status.
  /// It also updates state of cubit if there was some errors.
  ///
  /// Returns true if there was no any error, false otherwise.

  Future<bool> _validateFormWithError() async {
    final isEmptyFields = !(formKey.currentState?.validate() ?? false);
    var isWrongWords = false;

    for (var index = 0; index < _currentValue; index++) {
      final input = _inputDataList[index];
      if (!await _checkIsWordValid(input.text)) {
        isWrongWords = true;
        _inputDataList[index].isError = true;
      }
    }

    _updateTab(
      // TODO
      inputs: _inputDataList.take(_currentValue).toList(),
    );

    if (isEmptyFields) {
      model.showError(LocaleKeys.fillMissingWords.tr());
    } else if (isWrongWords) {
      model.showError(LocaleKeys.incorrectWordsFormat.tr());
    }

    return !isEmptyFields && !isWrongWords;
  }

  /// [word] is valid if it is in list of hints for this word.
  Future<bool> _checkIsWordValid(String word) => model.checkIsWordValid(word);

  /// Drop form validation state
  void _resetFormAndError() {
    formKey.currentState?.reset();
    var isChangedModels = false;

    try {
      for (var index = 0; index < _currentValue; index++) {
        if (_inputDataList[index].isError) {
          isChangedModels = true;
          _inputDataList[index].isError = false;
        }
      }
    } finally {
      if (isChangedModels) {
        _updateTab(
          // TODO
          inputs: _inputDataList.take(_currentValue).toList(),
        );
      }
    }
  }

  void _updateInputDataList({
    required int index,
    bool? isError,
  }) {
    _inputDataList[index].isError = isError;
  }

  void _updateTab({
    List<int>? allowedValues,
    int? currentValue,
    List<EnterSeedPhraseInputData>? inputs,
  }) {
    final data = _tabData;
    if (data == null) {
      return;
    }
    _tabState.accept(
      data.copyWith(
        allowedValues: allowedValues,
        currentValue: currentValue,
        inputs: inputs,
      ),
    );
  }

  /// Callback for UI TextField widget
  Future<List<String>> suggestionsCallback(
    TextEditingController controller,
  ) async {
    final text = controller.value.text;
    if (text.isEmpty) return [];
    final hints = await model.getHints(text);
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

    final inputs = _inputDataList.take(value).toList();

    _updateTab(
      currentValue: value.clamp(0, inputs.length),
      allowedValues: _allowedValues,
      inputs: inputs,
    );
    _displayPasteButtonState.accept(true);
  }

  Future<void> confirmAction() async {
    if (!await model.checkConnection(context)) {
      return;
    }

    if (await _validateFormWithError()) {
      try {
        FocusManager.instance.primaryFocus?.unfocus();

        final buffer = StringBuffer();

        for (var i = 0; i < _currentValue; i++) {
          buffer
            ..write(_inputDataList[i].text.trim())
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
        _confirm(phrase);
      } on Exception catch (e, s) {
        _log.severe('confirmAction', e, s);
        model.showError(e.toString());
      } on FfiException catch (e, s) {
        _log.severe('confirmAction FfiException', e, s);
        model.showError(LocaleKeys.wrongSeed.tr());
      }
    }
  }

  /// [index] starts with 0
  void nextOrConfirm(int index) {
    if (index == _currentValue - 1) {
      confirmAction();
    } else {
      /// TODO сделать безопасно
      _inputDataList[index + 1].focusNode.requestFocus();
    }
  }

  void clearFields() {
    for (final data in _inputDataList) {
      data.controller.selection = const TextSelection.collapsed(offset: 0);
    }
    _resetFormAndError();
  }

  /// [index] start with 0
  void onSuggestionSelected(
    String suggestion,
    int index,
  ) {
    _inputDataList[index].controller
      ..text = suggestion
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: suggestion.length),
      );

    nextOrConfirm(index);
  }

  /// Reset text of controller that triggers [_checkInputCompletion]
  void clearInputModel(int index) => _inputDataList[index].controller.clear();

  Future<void> pastePhrase() async {
    final words = await getSeedListFromClipboard();

    final count = words.length;
    if (count == _actualSeedPhraseLength || count == _legacySeedPhraseLength) {
      changeTab(count);
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

        model.showError(LocaleKeys.incorrectWordsFormat.tr());

        return;
      }

      try {
        // TODO(knightforce): check why error "Not in inclusive range 0..11: 12"
        words.asMap().forEach((index, word) {
          _inputDataList[index].controller.value = TextEditingValue(
            text: word,
            selection: TextSelection.fromPosition(
              TextPosition(offset: word.length),
            ),
          );
        });
      } catch (_) {}

      await _validateFormWithError();
    });
  }

  void _clearAllInputs() {
    for (final data in _inputDataList) {
      data.controller.clear();
    }
  }
}
