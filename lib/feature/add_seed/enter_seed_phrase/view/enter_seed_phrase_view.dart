import 'package:app/feature/add_seed/enter_seed_phrase/cubit/cubit.dart';
import 'package:app/generated/generated.dart';
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
              Assets.images.seedPhraseIcon.path,
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
                    _Tabs(
                      allowedValues: allowedValues,
                      currentValue: currentValue,
                      displayPasteButton: displayPasteButton,
                      onTabChanged: cubit.changeTab,
                      onPastePhrase: cubit.pastePhrase,
                      onClearFields: cubit.clearFields,
                    ),
                  ],
                  _Inputs(inputs: inputsModels, currentValue: currentValue),
                  const SizedBox(height: DimensSize.d16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Tabs extends StatelessWidget {
  const _Tabs({
    required this.allowedValues,
    required this.currentValue,
    required this.displayPasteButton,
    required this.onTabChanged,
    required this.onPastePhrase,
    required this.onClearFields,
  });

  final List<int> allowedValues;
  final int currentValue;
  final bool displayPasteButton;
  final void Function(int) onTabChanged;
  final VoidCallback onPastePhrase;
  final VoidCallback onClearFields;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final value in allowedValues)
                  GestureDetector(
                    onTap: () => onTabChanged(value),
                    child: PrimarySegmentControl(
                      size: SegmentControlSize.small,
                      state: value == currentValue
                          ? SegmentControlState.selected
                          : SegmentControlState.normal,
                      title: LocaleKeys.wordsCount.plural(value),
                      value: value,
                    ),
                  ),
              ],
            ),
          ),
        ),
        GhostButton(
          buttonShape: ButtonShape.pill,
          buttonSize: ButtonSize.small,
          onPressed: displayPasteButton ? onPastePhrase : onClearFields,
          title: displayPasteButton
              ? LocaleKeys.pasteAll.tr()
              : LocaleKeys.clearAll.tr(),
          icon: displayPasteButton
              ? LucideIcons.arrowDownToDot
              : LucideIcons.trash2,
        ),
      ],
    );
  }
}

class _Inputs extends StatelessWidget {
  const _Inputs({
    required this.inputs,
    required this.currentValue,
  });

  final List<EnterSeedPhraseInputState> inputs;
  final int currentValue;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EnterSeedPhraseCubit>();

    return ContainerRow(
      padding: const EdgeInsets.symmetric(vertical: DimensSize.d16),
      children: [
        Expanded(
          child: SeparatedColumn(
            children: [
              for (final input in inputs.getRange(
                0,
                currentValue ~/ _gridColumnCount,
              ))
                _Input(
                  input: input,
                  currentValue: currentValue,
                  suggestionsCallback: cubit.suggestionsCallback,
                  onSuggestionSelected: cubit.onSuggestionSelected,
                  onSubmitted: cubit.nextOrConfirm,
                  onClear: cubit.clearInputModel,
                ),
            ],
          ),
        ),
        Expanded(
          child: SeparatedColumn(
            children: [
              for (final input in inputs.getRange(
                currentValue ~/ _gridColumnCount,
                currentValue,
              ))
                _Input(
                  input: input,
                  currentValue: currentValue,
                  suggestionsCallback: cubit.suggestionsCallback,
                  onSuggestionSelected: cubit.onSuggestionSelected,
                  onSubmitted: cubit.nextOrConfirm,
                  onClear: cubit.clearInputModel,
                ),
            ],
          ),
        ),
      ],
    );
  }
}

final _format = NumberFormat('00');

class _Input extends StatelessWidget {
  const _Input({
    required this.input,
    required this.currentValue,
    required this.suggestionsCallback,
    required this.onSuggestionSelected,
    required this.onSubmitted,
    required this.onClear,
  });

  final EnterSeedPhraseInputState input;

  /// starts with 0
  final int currentValue;
  final SuggestionsCallback<String> suggestionsCallback;
  final void Function(String, int) onSuggestionSelected;
  final void Function(int) onSubmitted;
  final void Function(int) onClear;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final colors = context.themeStyle.colors;
    final displayIndex = input.index + 1;
    final indexText = _format.format(displayIndex);

    return input.when(
      entered: (text, index, hasError) {
        return PressScaleWidget(
          onPressed: () => onClear(index),
          child: CommonCard(
            width: double.infinity,
            alignment: Alignment.center,
            leadingText: indexText,
            titleText: text,
            trailingChild: CommonIconWidget.svg(svg: Assets.images.trash.path),
            borderColor: hasError ? colors.alert : null,
          ),
        );
      },
      input: (controller, focus, index, hasError) {
        return CommonInput(
          key: Key('SeedInput-$index'),
          autocorrect: false,
          hintStyle: theme.textStyles.labelSmall,
          inactiveBorderColor: theme.colors.border0,
          textStyle: theme.textStyles.labelSmall,
          suggestionBackground: theme.colors.background1,
          keyboardType: TextInputType.visiblePassword,
          height: DimensSize.d48,
          controller: controller,
          suggestionsCallback: suggestionsCallback,
          itemBuilder: _itemBuilder,
          onSuggestionSelected: (suggestion) =>
              onSuggestionSelected(suggestion, index),
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
          onSubmitted: (_) => onSubmitted(index),
          textInputAction: index == currentValue - 1
              ? TextInputAction.done
              : TextInputAction.next,
          v2Style: CommonInputStyleV2(theme),
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
}
