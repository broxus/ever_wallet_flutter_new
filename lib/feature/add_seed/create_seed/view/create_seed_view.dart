import 'package:app/feature/add_seed/create_seed/create_seed.dart';
import 'package:app/generated/assets.gen.dart';
import 'package:app/l10n/l10n.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Callback that calls if user taps skip checking or check phrase.
typedef CreateSeedCompleteCallback = void Function(List<String> phrase);

/// {@template create_seed_view}
/// Widget that allows user to create random seed phrase, copy it and check
/// {@endtemplate}
class CreateSeedView extends StatelessWidget {
  /// {@macro create_seed_view}
  const CreateSeedView({
    required this.skipCallback,
    required this.checkCallback,
    super.key,
  });

  final CreateSeedCompleteCallback skipCallback;
  final CreateSeedCompleteCallback checkCallback;

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;
    final colors = context.themeStyle.colors;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localization.save_seed_phrase,
              style: StyleRes.pageTitle.copyWith(color: colors.textPrimary),
            ),
            const SizedBox(height: 12),
            Text(
              localization.save_seed_warning,
              style: StyleRes.bodyText.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<CreateSeedCubit, CreateSeedCubitState>(
                builder: (context, state) {
                  return state.when(
                    initial: Container.new,
                    generated: (words, isCopied) {
                      return Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _wordsField(colors, words),
                                const SizedBox(height: 4),
                                _copyButton(words, isCopied),
                                // To allow scroll above buttons
                                const SizedBox(
                                  height: commonButtonHeight * 2 + 12,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Column(
                              children: [
                                CommonButton.primary(
                                  text: localization.check_seed_phrase,
                                  onPressed: () => checkCallback(words),
                                  fillWidth: true,
                                ),
                                const SizedBox(height: 12),
                                CommonButton.secondary(
                                  text: localization.skip_take_risk,
                                  onPressed: () => skipCallback(words),
                                  fillWidth: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textPair(String word, int index, ColorsPalette colors) {
    final style = StyleRes.regular16.copyWith(color: colors.textPrimary);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text(
              '$index.',
              style: style.copyWith(color: colors.textTertiary),
            ),
          ),
          Expanded(
            child: Text(word, style: style, textAlign: TextAlign.left),
          ),
        ],
      ),
    );
  }

  Widget _copyButton(List<String> words, bool copied) {
    return Builder(
      builder: (context) {
        final localization = context.l10n;
        final colors = context.themeStyle.colors;
        final cubit = context.read<CreateSeedCubit>();

        if (copied) {
          return SizedBox(
            height: commonButtonHeight,
            child: Align(
              child: Text(
                localization.copied_no_exclamation,
                style: StyleRes.medium16.copyWith(color: colors.textPositive),
              ),
            ),
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonButton.ghost(
              leading: CommonButtonIconWidget.svg(
                svg: Assets.images.copy.path,
              ),
              text: localization.copy_words,
              onPressed: cubit.copySeed,
            ),
          ],
        );
      },
    );
  }

  Widget _wordsField(ColorsPalette colors, List<String> words) {
    return Container(
      color: colors.fillingSecondary,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: words
                  .getRange(0, 6)
                  .mapIndexed((i, word) => _textPair(word, i + 1, colors))
                  .toList(),
            ),
          ),
          Expanded(
            child: Column(
              children: words
                  .getRange(6, 12)
                  .mapIndexed((i, word) => _textPair(word, i + 7, colors))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
