import 'package:app/feature/add_seed_to_app/create_seed/create_seed.dart';
import 'package:app/feature/onboarding/widgets/onboarding_app_bar.dart';
import 'package:app/generated/assets.gen.dart';
import 'package:app/l10n/l10n.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Callback that calls if user taps skip checking or check phrase.
typedef CreateSeedNavigationCallback = void Function(
  BuildContext context,
  List<String> phrase,
);

/// {@template create_seed_view}
/// Widget that allows user to create random seed phrase, copy it and check
/// {@endtemplate}
class CreateSeedView extends StatefulWidget {
  /// {@macro create_seed_view}
  const CreateSeedView({
    required this.skipCallback,
    required this.checkCallback,
    required this.needSkipButtonBorder,
    super.key,
  });

  final CreateSeedNavigationCallback skipCallback;
  final CreateSeedNavigationCallback checkCallback;

  final bool needSkipButtonBorder;

  @override
  State<CreateSeedView> createState() => _CreateSeedViewState();
}

class _CreateSeedViewState extends State<CreateSeedView> {
  late final cubit = CreateSeedCubit()..init();

  final isCopied = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;
    final colors = context.themeStyle.colors;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: const OnboardingAppBar(),
      body: SafeArea(
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
                  bloc: cubit,
                  builder: (context, state) {
                    return state.when(
                      initial: Container.new,
                      generated: (words) {
                        return Stack(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _wordsField(colors, words),
                                  _copyButton(words),
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
                                    onPressed: () =>
                                        widget.checkCallback(context, words),
                                  ),
                                  const SizedBox(height: 12),
                                  CommonButton.secondary(
                                    text: localization.skip_take_risk,
                                    onPressed: () =>
                                        widget.skipCallback(context, words),
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

  Widget _copyButton(List<String> words) {
    return ValueListenableBuilder<bool>(
      valueListenable: isCopied,
      builder: (context, copied, __) {
        final localization = context.l10n;
        final colors = context.themeStyle.colors;

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
              onPressed: () {
                Clipboard.setData(
                  ClipboardData(text: words.join(' ')),
                );
                isCopied.value = true;
                Future.delayed(const Duration(seconds: 2), () {
                  isCopied.value = false;
                });
              },
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
