import 'package:app/generated/generated.dart';
import 'package:app/v2/feature/add_seed/enter_seed_phrase/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/components/input/common_input_style_v2.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

const _gridColumnCount = 2;

/// {@template enter_seed_phrase_view}
/// Screen that allows user to enter seed phrase with 12 or 24 words.
/// {@endtemplate}
class EnterSeedPhraseView extends StatelessWidget {
  /// {@macro enter_seed_phrase_view}
  const EnterSeedPhraseView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    final theme = context.themeStyleV2;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final hasBottomPadding = bottomPadding >= commonButtonHeight;

    return SafeArea(
      minimum: const EdgeInsets.only(bottom: DimensSizeV2.d16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
        child: Column(
          children: [
            Image.asset(
              'assets/images/seed_phrase_icon.png',
              width: DimensSizeV2.d56,
              height: DimensSizeV2.d56,
            ),
            const SizedBox(height: DimensSizeV2.d16),
            Text(
              LocaleKeys.enterSeedPhrase.tr(),
              style: theme.textStyles.headingLarge,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: DimensSizeV2.d8,
                left: DimensSizeV2.d16,
                right: DimensSizeV2.d16,
              ),
              child: PrimaryText(
                LocaleKeys.pasteSeedIntoFirstBox.tr(),
              ),
            ),
            if (hasBottomPadding)
              Divider(
                color: colors.strokePrimary,
                height: DimensStroke.small,
                thickness: DimensStroke.small,
              ),
            Expanded(
              child: _buildPhrasesList(theme),
            ),
            SizedBox(
              // subtract commonButtonHeight to avoid button above keyboard
              height: hasBottomPadding ? bottomPadding - commonButtonHeight : 0,
            ),
            AccentButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.confirm.tr(),
              onPressed: () =>
                  context.read<EnterSeedPhraseCubit>().confirmAction(),
            ),
          ],
        ),
      ),
    );
  }

  // ignore:long-method
  Widget _buildPhrasesList(ThemeStyleV2 theme) {
    return BlocBuilder<EnterSeedPhraseCubit, EnterSeedPhraseState>(
      builder: (context, state) {
        final cubit = context.read<EnterSeedPhraseCubit>();
        final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
        final isKeyboardOpen = bottomPadding >= commonButtonHeight;

        return state.when(
          initial: () => const SizedBox.shrink(),
          tab: (
            allowedValues,
            currentValue,
            inputsModels,
            displayPasteButton,
          ) =>
              SingleChildScrollView(
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isKeyboardOpen) ...[
                    const SizedBox(height: DimensSize.d24),
                    _tabs(
                      allowedValues,
                      cubit,
                      currentValue,
                      displayPasteButton,
                    ),
                  ],
                  _inputs(theme, inputsModels, currentValue),
                  const SizedBox(height: DimensSize.d16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// [currentValue] starts with 0
  // ignore: long-method
  Widget _inputBuild(
    ThemeStyleV2 themeStyleV2,
    EnterSeedPhraseInputModel input,
    int currentValue,
  ) {
    final displayIndex = input.index + 1;
    final indexText = NumberFormat('00').format(displayIndex);

    return Builder(
      builder: (context) {
        final cubit = context.read<EnterSeedPhraseCubit>();
        final colors = context.themeStyle.colors;

        return input.when(
          entered: (text, index, hasError) {
            return PressScaleWidget(
              onPressed: () => cubit.clearInputModel(index),
              child: CommonCard(
                width: double.infinity,
                alignment: Alignment.center,
                leadingText: indexText,
                titleText: text,
                trailingChild:
                    CommonIconWidget.svg(svg: Assets.images.trash.path),
                borderColor: hasError ? colors.alert : null,
              ),
            );
          },
          input: (controller, focus, index, hasError) {
            return CommonInput(
              hintStyle: themeStyleV2.textStyles.labelSmall,
              inactiveBorderColor: themeStyleV2.colors.border0,
              textStyle: themeStyleV2.textStyles.labelSmall,
              suggestionBackground: themeStyleV2.colors.background1,
              key: Key('SeedInput-$index'),
              height: DimensSize.d48,
              controller: controller,
              suggestionsCallback: (_) => cubit.suggestionsCallback(controller),
              itemBuilder: _itemBuilder,
              onSuggestionSelected: (suggestion) =>
                  cubit.onSuggestionSelected(suggestion, index),
              focusNode: focus,
              // show error border if field is empty
              validator: (v) => v?.isEmpty ?? true ? '' : null,
              needClearButton: false,
              // IntrinsicWidth to force Center match prefixIconConstraints
              prefixIcon: IntrinsicWidth(
                child: Center(
                  child: Text(
                    indexText,
                    style: StyleRes.addRegular.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ),
              ),
              onSubmitted: (_) => cubit.nextOrConfirm(index),
              textInputAction: index == currentValue - 1
                  ? TextInputAction.done
                  : TextInputAction.next,
              v2Style: CommonInputStyleV2(themeStyleV2),
            );
          },
        );
      },
    );
  }

  Widget _itemBuilder(BuildContext context, String suggestion) {
    final theme = context.themeStyleV2;

    return ListTile(
      tileColor: Colors.transparent,
      title: Text(
        suggestion,
        style: theme.textStyles.labelSmall,
      ),
    );
  }

  Widget _tabs(
    List<int> allowedValues,
    EnterSeedPhraseCubit cubit,
    int currentValue,
    bool displayPasteButton,
  ) {
    return Builder(
      builder: (context) {
        return Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: allowedValues
                      .map(
                        (value) => GestureDetector(
                          onTap: () => cubit.changeTab(value),
                          child: PrimarySegmentControl(
                            size: SegmentControlSize.small,
                            state: value == currentValue
                                ? SegmentControlState.selected
                                : SegmentControlState.normal,
                            title: LocaleKeys.wordsCount.plural(value),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            GhostButton(
              buttonShape: ButtonShape.pill,
              buttonSize: ButtonSize.small,
              onPressed:
                  displayPasteButton ? cubit.pastePhrase : cubit.clearFields,
              title: displayPasteButton
                  ? LocaleKeys.pasteAll.tr()
                  : LocaleKeys.clearAll.tr(),
              icon: LucideIcons.arrowDownToDot,
            ),
          ],
        );
      },
    );
  }

  Widget _inputs(
    ThemeStyleV2 themeStyleV2,
    List<EnterSeedPhraseInputModel> inputs,
    int currentValue,
  ) {
    return ContainerRow(
      padding: const EdgeInsets.symmetric(vertical: DimensSize.d16),
      children: [
        Expanded(
          child: SeparatedColumn(
            children: inputs
                .getRange(0, currentValue ~/ _gridColumnCount)
                .map((input) => _inputBuild(themeStyleV2, input, currentValue))
                .toList(),
          ),
        ),
        Expanded(
          child: SeparatedColumn(
            children: inputs
                .getRange(currentValue ~/ _gridColumnCount, currentValue)
                .map((input) => _inputBuild(themeStyleV2, input, currentValue))
                .toList(),
          ),
        ),
      ],
    );
  }
}
