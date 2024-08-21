// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: invalid_use_of_protected_member

import 'package:app/app/router/router.dart';
import 'package:app/feature/add_seed/import_wallet/data/import_wallet_data.dart';
import 'package:app/feature/add_seed/import_wallet/import_wallet_widget_model.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class ImportWalletScreen
    extends ElementaryWidget<ImportWalletScreenWidgetModel> {
  const ImportWalletScreen({
    super.key,
    WidgetModelFactory<ImportWalletScreenWidgetModel>? wmFactory,
  }) : super(
          wmFactory ?? defaultImportWalletWidgetModelFactory,
        );

  @override
  Widget build(ImportWalletScreenWidgetModel wm) {
    final context = wm.context;
    final theme = context.themeStyleV2;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.colors.background0,
      appBar: DefaultAppBar(
        onClosePressed: (context) => context.maybePop(),
      ),
      body: EntityStateNotifierBuilder<ImportWalletData?>(
        listenableEntityState: wm.screenState,
        builder: (_, data) {
          final isPasted = data?.isPasted ?? false;
          return SafeArea(
            minimum: const EdgeInsets.only(bottom: DimensSize.d24),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/seed_phrase_icon.png',
                    width: DimensSizeV2.d56,
                    height: DimensSizeV2.d56,
                  ),
                  const SizedBox(height: DimensSizeV2.d16),
                  Text(
                    LocaleKeys.importWalletScreenTitle.tr(),
                    style: theme.textStyles.headingLarge,
                  ),
                  const SizedBox(height: DimensSizeV2.d8),
                  PrimaryText(LocaleKeys.importWalletScreenSubtitle.tr()),
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
                          firstColumnWords: data?.firstColumnWords,
                          secondColumnWords: data?.secondColumnWords,
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
                              onPressed: wm.deleteWords,
                            ),
                          ),
                        )
                      else
                        Center(
                          child: FloatButton(
                            buttonShape: ButtonShape.pill,
                            title: LocaleKeys.importWalletPasteClipboard.tr(),
                            onPressed: wm.pasteWords,
                            icon: LucideIcons.arrowDown,
                            isFullWidth: false,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: DimensSizeV2.d24),
                  GhostButton(
                    buttonShape: ButtonShape.pill,
                    title: LocaleKeys.importWalletManuallyButtonText.tr(),
                    onPressed: wm.onPressedManual,
                    icon: LucideIcons.pencilLine,
                  ),
                  const Spacer(),
                  AccentButton(
                    buttonShape: ButtonShape.pill,
                    title: LocaleKeys.importWalletButtonText.tr(),
                    onPressed: isPasted ? wm.onPressedImport : null,
                    icon: LucideIcons.textCursorInput,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ListWords extends StatelessWidget {
  const _ListWords({
    required this.theme,
    required this.firstColumnWords,
    required this.secondColumnWords,
    required this.isMasked,
  });

  final ThemeStyleV2 theme;
  final List<String>? firstColumnWords;
  final List<String>? secondColumnWords;
  final bool isMasked;

  @override
  Widget build(BuildContext context) {
    final halfLength = (wordsCount / 2).floor();
    final firstColumnWords = this.firstColumnWords ??
        List.generate(
          halfLength,
          (index) => r'^*#!#$^*',
        );
    final secondColumnWords = this.secondColumnWords ??
        List.generate(
          halfLength,
          (index) => r'^*#!#$^*',
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int index = 0; index < firstColumnWords.length; index++)
                Padding(
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
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int index = 0; index < secondColumnWords.length; index++)
                Padding(
                  padding: index != secondColumnWords.length - 1
                      ? const EdgeInsets.only(bottom: DimensSizeV2.d12)
                      : EdgeInsets.zero,
                  child: _WordWithIndex(
                    theme: theme,
                    word: secondColumnWords[index],
                    index: index + halfLength,
                    isMasked: isMasked,
                  ),
                ),
            ],
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
