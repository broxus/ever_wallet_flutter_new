import 'package:app/feature/add_seed/enter_seed_phrase/data/input_data.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/data/tab_data.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/enter_seed_phrase_wm.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/widgets/tabs.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/components/input/common_input_style_v2.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class EnterSeedPhraseWords extends StatelessWidget {
  const EnterSeedPhraseWords({
    required this.formKey,
    required this.allowedValues,
    required this.currentValue,
    required this.displayPasteButtonState,
    required this.tabState,
    required this.changeTab,
    required this.pastePhrase,
    required this.clearFields,
    required this.onSuggestions,
    required this.onSuggestionSelected,
    required this.onNext,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final List<int> allowedValues;
  final int currentValue;
  final ListenableState<bool> displayPasteButtonState;
  final ListenableState<EnterSeedPhraseTabData> tabState;
  final ValueChanged<int> changeTab;
  final VoidCallback pastePhrase;
  final VoidCallback clearFields;
  final SuggestionsCallback<String> onSuggestions;
  final SuggestionSelectedCallback onSuggestionSelected;
  final ValueChanged<int> onNext;

  @override
  Widget build(BuildContext context) {
    final themeStyleV2 = context.themeStyleV2;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardOpen = bottomPadding >= commonButtonHeight;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isKeyboardOpen) const SizedBox(height: DimensSize.d24),
          if (!isKeyboardOpen)
            EnterSeedPhraseTabs(
              allowedValues: allowedValues,
              currentValue: currentValue,
              displayPasteButtonState: displayPasteButtonState,
              changeTab: changeTab,
              pastePhrase: pastePhrase,
              clearFields: clearFields,
            ),
          StateNotifierBuilder(
            listenableState: tabState,
            builder: (_, EnterSeedPhraseTabData? data) {
              if (data == null) {
                return const SizedBox.shrink();
              }

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: DimensSizeV2.d16,
                  ),
                  child: ListView.separated(
                    itemCount: data.inputs.length,
                    separatorBuilder: (_, __) => const SizedBox(
                      height: DimensSizeV2.d8,
                    ),
                    itemBuilder: (_, index) => _Input(
                      key: ValueKey(index),
                      theme: themeStyleV2,
                      data: data.inputs[index],
                      currentValue: currentValue,
                      onSuggestions: onSuggestions,
                      onSuggestionSelected: onSuggestionSelected,
                      onNext: onNext,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: DimensSize.d16),
        ],
      ),
    );
  }
}

class _Input extends StatelessWidget {
  const _Input({
    required this.theme,
    required this.data,
    required this.currentValue,
    required this.onSuggestions,
    required this.onSuggestionSelected,
    required this.onNext,
    super.key,
  });

  final ThemeStyleV2 theme;
  final EnterSeedPhraseInputData data;
  final int currentValue;
  final SuggestionsCallback<String> onSuggestions;
  final SuggestionSelectedCallback onSuggestionSelected;
  final ValueChanged<int> onNext;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;
    final themeStyleV2 = context.themeStyleV2;
    final displayIndex = data.index + 1;
    final indexText = NumberFormat('00').format(displayIndex);

    return CommonInput(
      autocorrect: false,
      hintStyle: themeStyleV2.textStyles.labelSmall,
      inactiveBorderColor: themeStyleV2.colors.border0,
      textStyle: themeStyleV2.textStyles.labelSmall,
      suggestionBackground: themeStyleV2.colors.background1,
      keyboardType: TextInputType.visiblePassword,
      height: DimensSize.d48,
      controller: data.controller,
      suggestionsCallback: (_) => onSuggestions(data.controller.text),
      itemBuilder: _itemBuilder,
      onSuggestionSelected: (suggestion) =>
          onSuggestionSelected(suggestion, data.index),
      focusNode: data.focusNode,
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
      onSubmitted: (_) => onNext(data.index),
      textInputAction: data.index == currentValue - 1
          ? TextInputAction.done
          : TextInputAction.next,
      v2Style: CommonInputStyleV2(themeStyleV2),
    );
  }

  Widget _itemBuilder(BuildContext context, String suggestion) {
    return ListTile(
      tileColor: Colors.transparent,
      title: Text(
        suggestion,
        style: theme.textStyles.labelSmall,
      ),
    );
  }
}
