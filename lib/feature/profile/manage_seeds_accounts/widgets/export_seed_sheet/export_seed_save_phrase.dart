import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/widgets.dart';

/// Helper method that displays [ExportSeedSavePhrase] sheet.
ModalRoute<void> exportSeedSavePhraseRoute(
  TextStyle titleTextStyle,
  List<String> phrase,
) {
  return commonBottomSheetRoute(
    titleTextStyle: titleTextStyle,
    title: LocaleKeys.saveSeedPhrase.tr(),
    body: (_, controller) => ExportSeedSavePhrase(
      phrase: phrase,
      controller: controller,
    ),
  );
}

/// Widget that shows the seed phrase that could be copied.
class ExportSeedSavePhrase extends StatelessWidget {
  const ExportSeedSavePhrase({
    required this.phrase,
    required this.controller,
    super.key,
  });

  final List<String> phrase;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      separatorSize: DimensSize.d24,
      children: [
        Flexible(
          child: SingleChildScrollView(
            controller: controller,
            child: _wordsField(),
          ),
        ),
        _copyButton(),
      ],
    );
  }

  Widget _textPair(String word, int index) {
    final indexText = NumberFormat('0').format(index);

    return IgnorePointer(
      child: PrimaryTextField(
        textEditingController: TextEditingController(text: word),
        labelText: indexText,
      ),
    );
  }

  Widget _copyButton() {
    return Builder(
      builder: (context) {
        return PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.copyWords.tr(),
          onPressed: () {
            inject<MessengerService>().show(
              Message.successful(
                message: LocaleKeys.copiedExclamation.tr(),
              ),
            );
            Clipboard.setData(ClipboardData(text: phrase.join(' ')));
          },
        );
      },
    );
  }

  Widget _wordsField() {
    final lengthHalf = phrase.length ~/ 2;

    return SeparatedRow(
      children: [
        Expanded(
          child: SeparatedColumn(
            mainAxisSize: MainAxisSize.min,
            children: phrase
                .getRange(0, lengthHalf)
                .mapIndexed((i, word) => _textPair(word, i + 1))
                .toList(),
          ),
        ),
        Expanded(
          child: SeparatedColumn(
            mainAxisSize: MainAxisSize.min,
            children: phrase
                .getRange(lengthHalf, phrase.length)
                .mapIndexed(
                  (i, word) => _textPair(word, i + lengthHalf + 1),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
