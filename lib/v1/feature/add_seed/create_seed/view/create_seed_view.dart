import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/generated/generated.dart';
import 'package:app/v1/feature/add_seed/create_seed/create_seed.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Callback that calls if user taps skip checking or check phrase.
typedef CreateSeedCompleteCallback = ValueChanged<SeedPhraseModel>;

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
    final theme = context.themeStyleV2;

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
                      style: theme.textStyles.headingXLarge,
                    ),
                    const SizedBox(height: DimensSizeV2.d12),
                    Text(
                      LocaleKeys.saveSeedWarning.tr(),
                      style: theme.textStyles.paragraphMedium,
                    ),
                    const SizedBox(height: DimensSizeV2.d24),
                    BlocBuilder<CreateSeedCubit, CreateSeedCubitState>(
                      builder: (context, state) {
                        return state.when(
                          initial: Container.new,
                          generated: (seed, isCopied) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _wordsField(seed),
                                const SizedBox(height: DimensSizeV2.d4),
                                _copyButton(isCopied),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: DimensSizeV2.d8),
                  ],
                ),
              ),
            ),
            BlocBuilder<CreateSeedCubit, CreateSeedCubitState>(
              builder: (context, state) {
                final seed = state.maybeWhen(
                  generated: (seed, _) => seed,
                  orElse: SeedPhraseModel.empty,
                );

                return Column(
                  children: [
                    AccentButton(
                      buttonShape: ButtonShape.pill,
                      title: LocaleKeys.checkSeedPhrase.tr(),
                      onPressed: () => checkCallback(seed),
                    ),
                    const SizedBox(height: DimensSizeV2.d8),
                    PrimaryButton(
                      buttonShape: ButtonShape.pill,
                      title: LocaleKeys.skipTakeRisk.tr(),
                      onPressed: () => skipCallback(seed),
                    ),
                    const SizedBox(height: DimensSizeV2.d12),
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
    final indexText = NumberFormat('0').format(index);

    return IgnorePointer(
      child: PrimaryTextField(
        labelText: indexText,
        textEditingController: TextEditingController(text: word),
        sizeType: PrimaryTextFieldSizeType.medium,
      ),
    );
  }

  Widget _copyButton(bool copied) {
    return Builder(
      builder: (context) {
        final cubit = context.read<CreateSeedCubit>();

        if (copied) {
          return GhostButton(
            buttonShape: ButtonShape.pill,
            buttonSize: ButtonSize.small,
            postfixIcon: LucideIcons.checkCheck,
            title: LocaleKeys.copiedExclamation.tr(),
            onPressed: () {},
          );
        }

        return GhostButton(
          buttonSize: ButtonSize.small,
          postfixIcon: LucideIcons.copy,
          title: LocaleKeys.copyWords.tr(),
          onPressed: cubit.copySeed,
          buttonShape: ButtonShape.pill,
        );
      },
    );
  }

  Widget _wordsField(SeedPhraseModel seed) {
    final lengthHalf = seed.wordsCount ~/ 2;

    return SeparatedRow(
      children: [
        Expanded(
          child: SeparatedColumn(
            children: seed.words
                .getRange(0, lengthHalf)
                .mapIndexed((i, word) => _textPair(word, i + 1))
                .toList(),
          ),
        ),
        Expanded(
          child: SeparatedColumn(
            children: seed.words
                .getRange(lengthHalf, seed.wordsCount)
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
