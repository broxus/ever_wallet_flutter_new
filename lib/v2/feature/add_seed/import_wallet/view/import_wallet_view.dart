import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/dimens_v2.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button.dart';

import '../import_wallet.dart';

class ImportWalletView extends ElementaryWidget<ImportWalletWidgetModel> {
  const ImportWalletView({
    super.key,
    WidgetModelFactory<ImportWalletWidgetModel>? wmFactory,
  }) : super(
          wmFactory ?? defaultImportWalletWidgetModelFactory,
        );

  @override
  Widget build(ImportWalletWidgetModel wm) {
    final context = wm.context;
    final theme = context.themeStyleV2;

    return EntityStateNotifierBuilder<ImportWalletData?>(
      listenableEntityState: wm.screenState,
      builder: (_, data) {
        final isPasted = wm.isPasted;
        return SafeArea(
          minimum: const EdgeInsets.only(bottom: DimensSize.d24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/seed_phrase_icon.png',
                  width: 56,
                  height: 56,
                ),
                const SizedBox(height: DimensSizeV2.d16),
                Text('Import wallet', style: theme.textStyles.headingLarge),
                const SizedBox(height: DimensSizeV2.d8),
                Text(
                  'Enter your secret recovery phrase to securely import your wallet.',
                  style: theme.textStyles.paragraphMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: DimensSizeV2.d24),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: theme.colors.background1,
                        borderRadius:
                            BorderRadius.circular(DimensRadiusV2.radius16),
                      ),
                      padding: const EdgeInsets.all(DimensSizeV2.d32),
                      width: double.infinity,
                      child: _ListWords(
                        theme: theme,
                        words: data?.words,
                        isMasked: isPasted,
                      ),
                    ),
                    if (isPasted)
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: DimensSizeV2.d8,
                            right: DimensSizeV2.d8,
                          ),
                          child: FloatButton(
                            buttonShape: ButtonShape.circle,
                            icon: LucideIcons.trash2,
                            onPressed: () {
                              wm.deleteWords();
                            },
                          ),
                        ),
                      )
                    else
                      Center(
                        child: FloatButton(
                          buttonShape: ButtonShape.pill,
                          title: 'Paste from clipboard',
                          onPressed: () {
                            wm.pasteWords();
                          },
                          icon: LucideIcons.arrowDown,
                          isFullWidth: false,
                        ),
                      )
                  ],
                ),
                const SizedBox(height: DimensSizeV2.d24),
                GhostButton(
                  buttonShape: ButtonShape.pill,
                  title: 'Import manually',
                  onPressed: () {},
                  icon: LucideIcons.pencilLine,
                ),
                const Spacer(),
                AccentButton(
                  buttonShape: ButtonShape.pill,
                  title: 'Import',
                  onPressed: isPasted ? () {
                    wm.import();
                  } : null,
                  icon: LucideIcons.textCursorInput,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ListWords extends StatelessWidget {
  const _ListWords({
    required this.theme,
    required this.words,
    required this.isMasked,
  });

  final ThemeStyleV2 theme;
  final List<String>? words;
  final bool isMasked;

  @override
  Widget build(BuildContext context) {
    final words = this.words ?? List.generate(12, (index) => '^*#!#\$^*');
    final halfLength = (words.length / 2).floor();

    final firstColumnWords = words.sublist(0, halfLength);
    final secondColumnWords = words.sublist(halfLength);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              firstColumnWords.length,
              (index) => Padding(
                //add padding between rows
                padding: index != firstColumnWords.length - 1
                    ? const EdgeInsets.only(bottom: DimensSizeV2.d12)
                    : EdgeInsets.zero,
                child: _WordWithIndex(
                  theme: theme,
                  word: firstColumnWords[index],
                  index: index,
                  isMasked: isMasked,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              secondColumnWords.length,
              (index) => Padding(
                padding: index != firstColumnWords.length - 1
                    ? const EdgeInsets.only(bottom: DimensSizeV2.d12)
                    : EdgeInsets.zero,
                child: _WordWithIndex(
                  theme: theme,
                  word: secondColumnWords[index],
                  index: index + halfLength,
                  isMasked: isMasked,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _WordWithIndex extends StatelessWidget {
  const _WordWithIndex({
    required this.theme,
    required this.word,
    required this.index,
    required this.isMasked,
  });

  final ThemeStyleV2 theme;
  final String word;
  final int index;
  final bool isMasked;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${index + 1}',
          style: theme.textStyles.labelSmall
              .copyWith(color: theme.colors.content3),
        ),
        const SizedBox(width: DimensSizeV2.d8),
        Text(
          word,
          style: theme.textStyles.labelSmall.copyWith(
            color: isMasked ? theme.colors.content0 : theme.colors.content3,
          ),
        ),
      ],
    );
  }
}
