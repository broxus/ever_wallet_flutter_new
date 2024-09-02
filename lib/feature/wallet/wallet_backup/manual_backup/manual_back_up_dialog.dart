import 'package:app/app/router/app_route.dart';
import 'package:app/feature/wallet/wallet_backup/check_phrase/check_phrase_dialog.dart';
import 'package:app/feature/wallet/wallet_backup/good_job_back_up_dialog.dart';
import 'package:app/feature/wallet/wallet_backup/manual_backup/manual_back_up_data.dart';
import 'package:app/feature/wallet/wallet_backup/manual_backup/manual_back_up_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';
import 'package:ui_components_lib/v2/widgets/modals/primary_bottom_sheet.dart';

void showManualBackupDialog(BuildContext context, List<String> words) {
  showPrimaryBottomSheet(
    context: context,
    title: LocaleKeys.manualBackupTitleDialog.tr(),
    subtitle: LocaleKeys.manualBackupSubtitleDialog.tr(),
    firstButton: LayoutBuilder(
      builder: (context, constraints) {
        return AccentButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.checkPhrasesLabel.tr(),
          icon: LucideIcons.textCursorInput,
          onPressed: () {
            showCheckPhraseDialog(context, words);
          },
        );
      },
    ),
    secondButton: LayoutBuilder(
      builder: (context, _) {
        return PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.skipTakeRisk.tr(),
          onPressed: () {
            context.maybePop(); //close current dialog
            showGoodJobDialog(context);
          },
        );
      },
    ),
    content: ContentManualBackup(words: words),
  );
}

class ContentManualBackup extends ElementaryWidget<ManualBackUpWidgetModel> {
  ContentManualBackup({
    required List<String> words,
    Key? key,
    WidgetModelFactory<ManualBackUpWidgetModel>? wmFactory,
  }) : super(
          wmFactory ??
              (context) =>
                  defaultManualBackUpWidgetModelFactory(context, words),
          key: key,
        );

  @override
  Widget build(ManualBackUpWidgetModel wm) {
    final theme = wm.themeStyle;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: theme.colors.background2,
            borderRadius: BorderRadius.circular(
              DimensRadiusV2.radius16,
            ),
          ),
          padding: const EdgeInsets.all(DimensSizeV2.d32),
          child: _ListWords(wm.words),
        ),
        const SizedBox(height: DimensSizeV2.d8),
        EntityStateNotifierBuilder<ManualBackUpData?>(
          listenableEntityState: wm.screenState,
          builder: (context, data) {
            return GhostButton(
              buttonSize: ButtonSize.small,
              postfixIcon: data?.isCopied ?? false
                  ? LucideIcons.checkCheck
                  : LucideIcons.copy,
              title: data?.isCopied ?? false
                  ? LocaleKeys.copiedExclamation.tr()
                  : LocaleKeys.copyWords.tr(),
              onPressed: wm.copySeed,
              buttonShape: ButtonShape.pill,
            );
          },
        ),
        const SizedBox(height: DimensSizeV2.d24),
      ],
    );
  }
}

class _ListWords extends StatelessWidget {
  const _ListWords(this.words);

  final List<String> words;

  @override
  Widget build(BuildContext context) {
    final lengthHalf = words.length ~/ 2;
    final theme = context.themeStyleV2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              for (int index = 0; index < lengthHalf; index++)
                Padding(
                  //add padding between rows
                  padding: index != lengthHalf - 1
                      ? const EdgeInsets.only(bottom: DimensSizeV2.d12)
                      : EdgeInsets.zero,
                  child: _Word(
                    theme: theme,
                    word: words[index],
                    index: index,
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              for (int index = lengthHalf; index < words.length; index++)
                Padding(
                  padding: index != words.length - 1
                      ? const EdgeInsets.only(bottom: DimensSizeV2.d12)
                      : EdgeInsets.zero,
                  child: _Word(
                    theme: theme,
                    word: words[index],
                    index: index,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Word extends StatelessWidget {
  const _Word({
    required this.theme,
    required this.word,
    required this.index,
  });

  final ThemeStyleV2 theme;
  final String word;
  final int index;

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
            color: theme.colors.content0,
          ),
        ),
      ],
    );
  }
}
