// ignore_for_file: use_build_context_synchronously

import 'package:app/app/router/app_route.dart';
import 'package:app/app/router/routs/add_seed/add_seed.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/add_seed/import_wallet/data/import_wallet_data.dart';
import 'package:app/feature/add_seed/import_wallet/import_wallet_screen.dart';
import 'package:app/feature/add_seed/import_wallet/import_wallet_screen_model.dart';
import 'package:app/feature/constants.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/seed_utils.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

final seedSplitRegExp = RegExp(r'[ |;,:\n.]');
const _actualSeedPhraseLength = 12;
const _legacySeedPhraseLength = 24;

ImportWalletScreenWidgetModel defaultImportWalletWidgetModelFactory(
  BuildContext context,
) {
  return ImportWalletScreenWidgetModel(
    ImportWalletScreenModel(
      inject(),
      inject(),
      inject(),
    ),
  );
}

class ImportWalletScreenWidgetModel
    extends CustomWidgetModel<ImportWalletScreen, ImportWalletScreenModel> {
  ImportWalletScreenWidgetModel(super.model) {
    _init();
  }

  late final screenState = createEntityNotifier<ImportWalletData?>()
    ..loading(ImportWalletData());

  ImportWalletData? get _data => screenState.value.data;
  final _log = Logger('ImportWalletWidgetModel');
  int? _currentValue;
  Set<String>? _hints;

  Future<void> onPressedImport() async {
    if (!await model.checkConnection(context)) {
      return;
    }

    String? error;
    try {
      FocusManager.instance.primaryFocus?.unfocus();

      final seed = screenState.value.data?.seed;

      if (seed != null && seed.isNotEmpty) {
        final phrase = seed.phrase;

        final mnemonicType = _currentValue == _legacySeedPhraseLength
            ? const MnemonicType.legacy()
            : defaultMnemonicType;

        deriveFromPhrase(
          phrase: phrase,
          mnemonicType: mnemonicType,
        );
        if (!context.mounted) return;
        context.goFurther(
          AppRoute.createSeedPassword.pathWithData(
            queryParameters: {
              addSeedPhraseQueryParam: phrase,
            },
          ),
          preserveQueryParams: true,
        );
      } else {
        model.showValidateError(context, LocaleKeys.incorrectWordsFormat.tr());
      }
    } on FrbException catch (e, s) {
      _log.severe('confirmAction FrbException', e, s);
      error = LocaleKeys.wrongSeed.tr();
    } on Exception catch (e, s) {
      _log.severe('confirmAction', e, s);
      error = e.toString();
    }
    if (error != null) {
      model.showValidateError(context, error);
    }
  }

  void onChangeTab(int value) {
    _currentValue = value;
    _updateState(
      isPasted: false,
      selectedValue: _currentValue,
      seed: SeedPhraseModel.empty(),
    );
  }

  Future<void> pasteWords() async {
    var seed = SeedPhraseModel.fromWords(await getSeedListFromClipboard());

    if (seed.isNotEmpty) {
      for (final word in seed.words) {
        if (!_isWordValid(word)) {
          seed = SeedPhraseModel.empty();
          break;
        }
      }
    }

    switch (seed.wordsCount) {
      case _actualSeedPhraseLength:
        onChangeTab(_actualSeedPhraseLength);
      case _legacySeedPhraseLength:
        onChangeTab(_legacySeedPhraseLength);
      default:
        model.showValidateError(context, LocaleKeys.incorrectWordsFormat.tr());
        return;
    }

    final halfLength = (seed.wordsCount / 2).floor();

    final firstColumnWords = seed.words.sublist(0, halfLength);
    final secondColumnWords = seed.words.sublist(halfLength);
    _updateState(
      isPasted: true,
      seed: seed,
      firstColumnWords: firstColumnWords,
      secondColumnWords: secondColumnWords,
    );
  }

  void deleteWords() {
    _updateState(isPasted: false);
  }

  void onPressedManual() {
    context.goFurther(
      AppRoute.enterSeed.path,
      preserveQueryParams: true,
    );
  }

  void _init() {
    final allowedValues = model.allowedValues;
    if (model.allowedValues.isNotEmpty) {
      _currentValue = allowedValues.first;
      _updateState(
        allowedValues: allowedValues,
        selectedValue: _currentValue,
      );
    }
  }

  void _updateState({
    bool? isPasted,
    List<int>? allowedValues,
    int? selectedValue,
    SeedPhraseModel? seed,
    List<String>? firstColumnWords,
    List<String>? secondColumnWords,
  }) {
    screenState.content(
      _data?.copyWith(
        isPasted: isPasted,
        allowedData: allowedValues,
        selectedValue: selectedValue,
        seed: seed,
        firstColumnWords: firstColumnWords,
        secondColumnWords: secondColumnWords,
      ),
    );
  }

  bool _isWordValid(String word) {
    final hints = _hints ??= getHints(input: '').toSet();
    return hints.contains(word);
  }
}
