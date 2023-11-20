import 'package:app/feature/add_seed/enter_seed_phrase/cubit/cubit.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

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
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final hasBottomPadding = bottomPadding >= commonButtonHeight;

    return SafeArea(
      minimum: const EdgeInsets.only(bottom: DimensSize.d16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
        child: Column(
          children: [
            if (hasBottomPadding)
              Divider(
                color: colors.strokePrimary,
                height: DimensStroke.small,
                thickness: DimensStroke.small,
              ),
            Expanded(
              child: _buildPhrasesList(),
            ),
            SizedBox(
              // subtract commonButtonHeight to avoid button above keyboard
              height: hasBottomPadding ? bottomPadding - commonButtonHeight : 0,
            ),
            CommonButton.primary(
              text: LocaleKeys.confirm.tr(),
              onPressed: () =>
                  context.read<EnterSeedPhraseCubit>().confirmAction(),
              fillWidth: true,
            ),
          ],
        ),
      ),
    );
  }

  // ignore:long-method
  Widget _buildPhrasesList() {
    return BlocBuilder<EnterSeedPhraseCubit, EnterSeedPhraseState>(
      builder: (context, state) {
        final cubit = context.read<EnterSeedPhraseCubit>();
        final colors = context.themeStyle.colors;
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
                    Text(
                      LocaleKeys.enterSeedPhrase.tr(),
                      style: StyleRes.h1.copyWith(color: colors.textPrimary),
                    ),
                    const SizedBox(height: DimensSize.d12),
                    Text(
                      LocaleKeys.pasteSeedIntoFirstBox.tr(),
                      style: StyleRes.primaryRegular
                          .copyWith(color: colors.textPrimary),
                    ),
                    const SizedBox(height: DimensSize.d24),
                    _tabs(
                      allowedValues,
                      cubit,
                      currentValue,
                      displayPasteButton,
                    ),
                  ],
                  _inputs(inputsModels, currentValue),
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
  Widget _inputBuild(
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
            );
          },
        );
      },
    );
  }

  Widget _itemBuilder(BuildContext context, String suggestion) {
    final colors = context.themeStyle.colors;

    return ListTile(
      tileColor: Colors.transparent,
      title: Text(
        suggestion,
        style: StyleRes.primaryRegular.copyWith(color: colors.textPrimary),
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
                child: CommonTabBar<int>(
                  values: allowedValues,
                  selectedValue: currentValue,
                  onChanged: cubit.changeTab,
                  builder: (_, v) => LocaleKeys.wordsCount.plural(v),
                ),
              ),
            ),
            CommonButton.ghost(
              leading: CommonButtonIconWidget.svg(
                svg: displayPasteButton
                    ? Assets.images.paste.path
                    : Assets.images.close.path,
              ),
              onPressed:
                  displayPasteButton ? cubit.pastePhrase : cubit.clearFields,
              text: displayPasteButton
                  ? LocaleKeys.pasteAll.tr()
                  : LocaleKeys.clearAll.tr(),
            ),
          ],
        );
      },
    );
  }

  Widget _inputs(
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
                .map((input) => _inputBuild(input, currentValue))
                .toList(),
          ),
        ),
        Expanded(
          child: SeparatedColumn(
            children: inputs
                .getRange(currentValue ~/ _gridColumnCount, currentValue)
                .map((input) => _inputBuild(input, currentValue))
                .toList(),
          ),
        ),
      ],
    );
  }
}
