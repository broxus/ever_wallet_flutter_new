import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:app/v2/feature/add_seed/constants.dart';
import 'package:app/v2/feature/add_seed/import_wallet/import_wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

final seedSplitRegExp = RegExp(r'[ |;,:\n.]');
const wordsCount = 12;

ImportWalletWidgetModel defaultImportWalletWidgetModelFactory(
  BuildContext context,
) {
  return ImportWalletWidgetModel(ImportWalletModel(inject()));
}

class ImportWalletWidgetModel
    extends CustomWidgetModel<ImportWalletView, ImportWalletModel> {
  ImportWalletWidgetModel(super.model);

  final _log = Logger('ImportWalletWidgetModel');

  late final screenState = createEntityNotifier<ImportWalletData?>()
    ..loading(ImportWalletData());

  ImportWalletData? get _data => screenState.value.data;

  Future<void> onPressedImport() async {
    String? error;
    try {
      FocusManager.instance.primaryFocus?.unfocus();
      if (screenState.value.data?.words?.isNotEmpty ?? false) {
        await deriveFromPhrase(
          phrase: screenState.value.data!.words!.join(' '),
          mnemonicType: defaultMnemonicType,
        );
        await model.import();
      } else {
        model.showValidateError(LocaleKeys.incorrectWordsFormat.tr());
      }
    } on Exception catch (e, s) {
      _log.severe('confirmAction', e, s);
      error = e.toString();
    } on FfiException catch (e, s) {
      _log.severe('confirmAction FfiException', e, s);
      error = LocaleKeys.wrongSeed.tr();
    }
    if (error != null) {
      model.showValidateError(error);
    }
  }

  Future<void> pasteWords() async {
    final clipboard = await Clipboard.getData(Clipboard.kTextPlain);
    final words = clipboard?.text
            ?.replaceAll(RegExp(r'\\s+'), ' ')
            .split(seedSplitRegExp) ??
        <String>[];
    if (words.isNotEmpty) {
      for (final word in words) {
        if (!await _isWordValid(word)) {
          words.clear();
          break;
        }
      }
    } else {
      words.clear();
    }

    if (words.isEmpty) {
      model.showValidateError(LocaleKeys.incorrectWordsFormat.tr());
      return;
    } else {
      final halfLength = (words.length / 2).floor();

      final firstColumnWords = words.sublist(0, halfLength);
      final secondColumnWords = words.sublist(halfLength);
      _updateState(
        isPasted: true,
        words: words,
        firstColumnWords: firstColumnWords,
        secondColumnWords: secondColumnWords,
      );
    }
  }

  void deleteWords() {
    _updateState(isPasted: false);
  }

  void _updateState({
    bool? isPasted,
    List<String>? words,
    List<String>? firstColumnWords,
    List<String>? secondColumnWords,
  }) {
    screenState.content(
      _data?.copyWith(
        isPasted: isPasted,
        words: words,
        firstColumnWords: firstColumnWords,
        secondColumnWords: secondColumnWords,
      ),
    );
  }

  Future<bool> _isWordValid(String word) async {
    final hints = await getHints(input: word);
    if (hints.contains(word)) {
      return true;
    }

    return false;
  }
}
