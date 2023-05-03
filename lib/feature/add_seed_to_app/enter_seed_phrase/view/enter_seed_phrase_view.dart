import 'dart:async';

import 'package:app/feature/add_seed_to_app/constants.dart';
import 'package:app/feature/onboarding/widgets/onboarding_app_bar.dart';
import 'package:app/l10n/l10n.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Regexp that helps splitting seed phrase into words.
final seedSplitRegExp = RegExp(r'[ |;|,|:|\n|.]');

/// Callback that will be called when user correctly enter seed phrase.
typedef EnterPhraseNavigationCallback = void Function(
  BuildContext context,
  List<String> phrase,
);

/// {@template enter_seed_phrase_view}
/// Screen that allows user to enter seed phrase with 12 or 24 words.
/// {@endtemplate}
class EnterSeedPhraseView extends StatefulWidget {
  /// {@macro enter_seed_phrase_view}
  const EnterSeedPhraseView({
    required this.callback,
    super.key,
  });

  final EnterPhraseNavigationCallback callback;

  @override
  State<EnterSeedPhraseView> createState() => _EnterSeedPhraseViewState();
}

class _EnterSeedPhraseViewState extends State<EnterSeedPhraseView> {
  final formKey = GlobalKey<FormState>();
  final controllers = List.generate(24, (_) => TextEditingController());
  final focuses = List.generate(24, (_) => FocusNode());
  final possibleValues = const <int>[12, 24];
  late List<int> values;

  final formErrorNotifier = ValueNotifier<String?>(null);

  /// Display paste only if there are no text(false) in fields else clear (true)
  final isClearButtonState = ValueNotifier<bool>(false);
  late ValueNotifier<int> valuesNotifier = ValueNotifier<int>(values.first);

  @override
  void initState() {
    super.initState();
    // TODO(alex-a4): uncomment when transport selection will be added
    // if (context.read<TransportRepository>().isEverTransport) {
    //   values = possibleValues;
    // } else {
    values = [possibleValues.first];
    // }
    for (final c in controllers) {
      c.addListener(() {
        final hasText =
            controllers.any((controller) => controller.text.isNotEmpty);
        isClearButtonState.value = hasText;
        _checkDebugPhraseGenerating();
      });
    }
    controllers[0].addListener(() {
      /// Only for 1-st controller allow paste as button
      /// It's some bug but Input's paste removes spaces so check with length
      if (controllers[0].text.length > 15) {
        pastePhrase();
      }
    });
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focuses) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: const OnboardingAppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                Expanded(
                  child: _buildPhrasesList(),
                ),
                SizedBox(
                  height: bottomPadding < commonButtonHeight
                      ? 0
                      : bottomPadding - commonButtonHeight,
                ),
                CommonButton.primary(
                  text: l10n.confirm,
                  onPressed: _confirmAction,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhrasesList() {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: ValueListenableBuilder<int>(
          valueListenable: valuesNotifier,
          builder: (context, value, __) {
            final activeControllers = controllers.take(value).toList();
            final l10n = context.l10n;
            final colors = context.themeStyle.colors;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.enter_seed_phrase,
                  style: StyleRes.pageTitle.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 28),
                Row(
                  children: [
                    Expanded(
                      child: CommonTabBar<int>(
                        values: values,
                        selectedValue: value,
                        onChanged: (v) {
                          formKey.currentState?.reset();
                          valuesNotifier.value = v;
                        },
                        builder: (_, v) => l10n.words_count(v),
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: isClearButtonState,
                      builder: (_, isClear, __) {
                        return CommonButton.ghostNoPadding(
                          onPressed: isClear ? clearFields : pastePhrase,
                          text: isClear ? l10n.clear_all : l10n.paste_all,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.paste_seed_into_first_box,
                  style: StyleRes.bodyText.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: activeControllers
                            .getRange(0, value ~/ 2)
                            .mapIndexed(
                              (index, c) =>
                                  _inputBuild(c, focuses[index], index + 1),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: activeControllers
                            .getRange(value ~/ 2, value)
                            .mapIndexed(
                          (index, c) {
                            final i = index + value ~/ 2;
                            return _inputBuild(c, focuses[i], i + 1);
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
                ValueListenableBuilder<String?>(
                  valueListenable: formErrorNotifier,
                  builder: (context, error, __) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        if (error == null)
                          SizedBox(
                            height: StyleRes.regular16.fontSize! *
                                StyleRes.regular16.height!,
                          )
                        else
                          Text(
                            error.capitalize!,
                            style: StyleRes.regular16
                                .copyWith(color: colors.textNegative),
                          ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// [index] start with 1
  Widget _inputBuild(
    TextEditingController controller,
    FocusNode focus,
    int index,
  ) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: CommonInput(
            controller: controller,
            suggestionsCallback: (_) => _suggestionsCallback(controller),
            itemBuilder: _itemBuilder,
            onSuggestionSelected: (suggestion) =>
                _onSuggestionSelected(suggestion, controller, index - 1),
            focusNode: focus,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 16, top: 11, right: 4),
              child: Text(
                '$index.',
                style: StyleRes.bodyText.copyWith(color: colors.textTertiary),
              ),
            ),
            onSubmitted: (_) => _nextOrConfirm(index - 1),
            textInputAction: index == valuesNotifier.value
                ? TextInputAction.done
                : TextInputAction.next,
          ),
        );
      },
    );
  }

  Future<List<String>> _suggestionsCallback(
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

  Widget _itemBuilder(BuildContext context, String suggestion) {
    final colors = context.themeStyle.colors;
    return ListTile(
      tileColor: Colors.transparent,
      title: Text(
        suggestion,
        style: StyleRes.bodyText.copyWith(color: colors.textPrimary),
      ),
    );
  }

  /// [index] start with 0
  void _onSuggestionSelected(
    String suggestion,
    TextEditingController controller,
    int index,
  ) {
    controller
      ..text = suggestion
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: suggestion.length),
      );

    _nextOrConfirm(index);
  }

  void _nextOrConfirm(int index) {
    if (index == valuesNotifier.value) {
      _confirmAction();
    } else {
      focuses[index].requestFocus();
    }
  }

  void _confirmAction() {
    if (_validateFormWithError()) {
      try {
        FocusManager.instance.primaryFocus?.unfocus();
        final phrase =
            controllers.take(valuesNotifier.value).map((e) => e.text).toList();
        final mnemonicType = valuesNotifier.value == possibleValues.last
            ? const MnemonicType.legacy()
            : defaultMnemonicType;

        deriveFromPhrase(
          phrase: phrase.join(' '),
          mnemonicType: mnemonicType,
        );
        widget.callback(context, phrase);
      } on Exception catch (e) {
        formErrorNotifier.value = e.toString();
      } on Object catch (e) {
        formErrorNotifier.value = e.toString();
      }
    }
  }

  void clearFields() {
    for (final c in controllers) {
      c
        ..text = ''
        ..selection = const TextSelection.collapsed(offset: 0);
    }
    _resetFormAndError();
  }

  Future<void> pastePhrase() async {
    final clipboard = await Clipboard.getData(Clipboard.kTextPlain);
    final words = clipboard?.text
            ?.replaceAll(RegExp(r'\\s+'), ' ')
            .split(seedSplitRegExp) ??
        <String>[];

    if (words.isNotEmpty && words.length == valuesNotifier.value) {
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
      if (!mounted) return;
      _resetFormAndError();

      unawaited(
        showErrorSnackbar(
          context: context,
          message: context.l10n.incorrect_words_format,
        ),
      );
      return;
    }

    words.asMap().forEach((index, word) {
      controllers[index].value = TextEditingValue(
        text: word,
        selection:
            TextSelection.fromPosition(TextPosition(offset: word.length)),
      );
    });
    _validateFormWithError();
  }

  Future<void> _checkDebugPhraseGenerating() async {
    if (controllers.any((e) => e.text == 'speakfriendandenter')) {
      final key = await generateKey(
        accountType: valuesNotifier.value == possibleValues.last
            ? const MnemonicType.legacy()
            : defaultMnemonicType,
      );

      for (var i = 0; i < controllers.take(valuesNotifier.value).length; i++) {
        final text = key.words[i];
        controllers[i].text = text;
        controllers[i].selection =
            TextSelection.fromPosition(TextPosition(offset: text.length));
      }
      _validateFormWithError();
    }
  }

  /// Validate form and return its status
  bool _validateFormWithError() {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      formErrorNotifier.value = context.l10n.seed_is_wrong;
    } else {
      formErrorNotifier.value = null;
    }
    return isValid;
  }

  void _resetFormAndError() {
    formKey.currentState?.reset();
    formErrorNotifier.value = null;
  }
}
