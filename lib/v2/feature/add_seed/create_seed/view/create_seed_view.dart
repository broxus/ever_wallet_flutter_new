import 'package:app/generated/generated.dart';
import 'package:app/v2/feature/add_seed/create_seed/create_seed.dart';
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
    final colors = context.themeStyle.colors;

    return SafeArea(
      minimum: const EdgeInsets.only(bottom: DimensSize.d16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.saveSeedPhrase.tr(),
                      style: StyleRes.h1.copyWith(color: colors.textPrimary),
                    ),
                    const SizedBox(height: DimensSize.d12),
                    Text(
                      LocaleKeys.saveSeedWarning.tr(),
                      style: StyleRes.primaryRegular
                          .copyWith(color: colors.textPrimary),
                    ),
                    const SizedBox(height: DimensSize.d24),
                    BlocBuilder<CreateSeedCubit, CreateSeedCubitState>(
                      builder: (context, state) {
                        return state.when(
                          initial: Container.new,
                          generated: (words, isCopied) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _wordsField(words),
                                const SizedBox(height: DimensSize.d4),
                                _copyButton(isCopied),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: DimensSize.d8),
                  ],
                ),
              ),
            ),
            BlocBuilder<CreateSeedCubit, CreateSeedCubitState>(
              builder: (context, state) {
                final words = state.maybeWhen(
                  generated: (words, _) => words,
                  orElse: () => const <String>[],
                );

                return Column(
                  children: [
                    CommonButton.primary(
                      text: LocaleKeys.checkSeedPhrase.tr(),
                      onPressed: () => checkCallback(words),
                      fillWidth: true,
                    ),
                    const SizedBox(height: DimensSize.d8),
                    CommonButton.secondary(
                      text: LocaleKeys.skipTakeRisk.tr(),
                      onPressed: () => skipCallback(words),
                      fillWidth: true,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _textPair(String word, int index) {
    final indexText = NumberFormat('00').format(index);

    return CommonCard(titleText: word, leadingText: indexText);
  }

  Widget _copyButton(bool copied) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;
        final cubit = context.read<CreateSeedCubit>();

        if (copied) {
          return CommonButton(
            buttonType: EverButtonType.ghost,
            contentDisabledColor: colors.apply,
            trailing: CommonButtonIconWidget.svg(svg: Assets.images.check.path),
            text: LocaleKeys.copiedExclamation.tr(),
          );
        }

        return CommonButton.ghost(
          trailing: CommonButtonIconWidget.svg(svg: Assets.images.copy.path),
          text: LocaleKeys.copyWords.tr(),
          onPressed: cubit.copySeed,
        );
      },
    );
  }

  Widget _wordsField(List<String> words) {
    final lengthHalf = words.length ~/ 2;

    return SeparatedRow(
      children: [
        Expanded(
          child: SeparatedColumn(
            children: words
                .getRange(0, lengthHalf)
                .mapIndexed((i, word) => _textPair(word, i + 1))
                .toList(),
          ),
        ),
        Expanded(
          child: SeparatedColumn(
            children: words
                .getRange(lengthHalf, words.length)
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
