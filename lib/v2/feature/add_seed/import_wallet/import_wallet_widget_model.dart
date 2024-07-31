import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/constants.dart';

import 'package:app/core/wm/custom_wm.dart';
import 'package:app/v2/feature/add_seed/import_wallet/import_wallet.dart';

final seedSplitRegExp = RegExp(r'[ |;,:\n.]');

ImportWalletWidgetModel defaultImportWalletWidgetModelFactory(
  BuildContext context,
) {
  return ImportWalletWidgetModel(
    inject(),
    ImportWalletModel(),
  );
}

class ImportWalletWidgetModel
    extends CustomWidgetModel<ImportWalletView, ImportWalletModel> {
  ImportWalletWidgetModel(this._messengerService, super.model);

  MessengerService _messengerService;

  late final screenState = createEntityNotifier<ImportWalletData?>()
    ..loading(ImportWalletData());

  ImportWalletData? get _data => screenState.value.data;

  bool get isPasted => _isPasted;

  Future<void> import() => model.import();

  Future<void> pasteWords() async {
    final clipboard = await Clipboard.getData(Clipboard.kTextPlain);
    final words = clipboard?.text
            ?.replaceAll(RegExp(r'\\s+'), ' ')
            .split(seedSplitRegExp) ??
        <String>[];
    _isPasted = true;
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
      _showValidateError(LocaleKeys.incorrectWordsFormat.tr());
      return;
    }
    {
      _isPasted = true;
      _updateState(isPasted: _isPasted, words: words);
    }
  }

  void deleteWords() {
    _isPasted = false;
    _updateState(isPasted: _isPasted, words: null);
  }

  void _updateState({
    bool? isPasted,
    List<String>? words,
  }) {
    screenState.content(
      _data?.copyWith(
        isPasted: isPasted,
        words: words,
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

  void _showValidateError(String message) {
    _messengerService.show(
      Message.error(
        message: message,
        debounceTime: defaultInfoMessageDebounceDuration,
      ),
    );
  }

  bool _isPasted = false;
}
