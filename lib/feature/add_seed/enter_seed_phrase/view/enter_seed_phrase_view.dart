import 'package:app/feature/add_seed/enter_seed_phrase/cubit/cubit.dart';
import 'package:app/generated/generated.dart';
import 'package:app/l10n/l10n.dart';
import 'package:collection/collection.dart';
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
    final l10n = context.l10n;
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
              text: l10n.confirm,
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
        final l10n = context.l10n;
        final colors = context.themeStyle.colors;
        final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
        final isKeyboardOpen = bottomPadding >= commonButtonHeight;

        return state.when(
          initial: () => const SizedBox.shrink(),
          tab: (
            allowedValues,
            currentValue,
            controllers,
            focuses,
            displayPasteButton,
            inputsCompleted,
          ) =>
              SingleChildScrollView(
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isKeyboardOpen) ...[
                    Text(
                      l10n.enterSeedPhrase,
                      style: StyleRes.h1.copyWith(color: colors.textPrimary),
                    ),
                    const SizedBox(height: DimensSize.d12),
                    Text(
                      l10n.pasteSeedIntoFirstBox,
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
                  _inputs(controllers, focuses, currentValue, inputsCompleted),
                  const SizedBox(height: DimensSize.d16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// [index] start with 1
  /// [currentValue] starts with 0
  Widget _inputBuild(
    TextEditingController controller,
    FocusNode focus,
    int index,
    int currentValue,
    ValueNotifier<bool> inputCompleted,
  ) {
    return ValueListenableBuilder<bool>(
      valueListenable: inputCompleted,
      builder: (context, completed, _) {
        final cubit = context.read<EnterSeedPhraseCubit>();
        final colors = context.themeStyle.colors;

        // ignore: no-magic-number
        final indexText = index < 10 ? '0$index' : '$index';

        if (completed) {
          return PressScaleWidget(
            onPressed: () => controller.clear(),
            child: CommonCard(
              leadingText: indexText,
              titleText: controller.text,
              trailingChild:
                  CommonIconWidget.svg(svg: Assets.images.trash.path),
            ),
          );
        }

        return CommonInput(
          height: DimensSize.d48,
          controller: controller,
          suggestionsCallback: (_) => cubit.suggestionsCallback(controller),
          itemBuilder: _itemBuilder,
          onSuggestionSelected: (suggestion) =>
              cubit.onSuggestionSelected(suggestion, index - 1),
          focusNode: focus,
          needClearButton: false,
          prefixIcon: Padding(
            // ignore: no-magic-number
            padding: EdgeInsets.only(
              left: DimensSize.d12,
              top: StyleRes.addRegular.fontSize!,
            ),
            child: Text(
              indexText,
              style: StyleRes.addRegular.copyWith(color: colors.textSecondary),
            ),
          ),
          onSubmitted: (_) => cubit.nextOrConfirm(index - 1),
          textInputAction: index - 1 == currentValue
              ? TextInputAction.done
              : TextInputAction.next,
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
        final l10n = context.l10n;

        return Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: CommonTabBar<int>(
                  values: allowedValues,
                  selectedValue: currentValue,
                  onChanged: cubit.changeTab,
                  builder: (_, v) => l10n.wordsCount(v),
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
              text: displayPasteButton ? l10n.pasteAll : l10n.clearAll,
            ),
          ],
        );
      },
    );
  }

  Widget _inputs(
    List<TextEditingController> controllers,
    List<FocusNode> focuses,
    int currentValue,
    List<ValueNotifier<bool>> inputsCompleted,
  ) {
    return ContainerRow(
      padding: const EdgeInsets.symmetric(vertical: DimensSize.d16),
      children: [
        Expanded(
          child: SeparatedColumn(
            children: controllers
                .getRange(0, currentValue ~/ _gridColumnCount)
                .mapIndexed(
                  (index, c) => _inputBuild(
                    c,
                    focuses[index],
                    index + 1,
                    currentValue,
                    inputsCompleted[index],
                  ),
                )
                .toList(),
          ),
        ),
        Expanded(
          child: SeparatedColumn(
            children: controllers
                .getRange(currentValue ~/ _gridColumnCount, currentValue)
                .mapIndexed(
              (index, c) {
                final i = index + currentValue ~/ _gridColumnCount;

                return _inputBuild(
                  c,
                  focuses[i],
                  i + 1,
                  currentValue,
                  inputsCompleted[i],
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
