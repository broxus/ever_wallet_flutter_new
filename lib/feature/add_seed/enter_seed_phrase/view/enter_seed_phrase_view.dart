import 'package:app/feature/add_seed/enter_seed_phrase/cubit/cubit.dart';
import 'package:app/l10n/l10n.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// {@template enter_seed_phrase_view}
/// Screen that allows user to enter seed phrase with 12 or 24 words.
/// {@endtemplate}
class EnterSeedPhraseView extends StatelessWidget {
  /// {@macro enter_seed_phrase_view}
  const EnterSeedPhraseView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: _buildPhrasesList(),
            ),
            SizedBox(
              height: bottomPadding < commonButtonHeight
                  ? 0
                  : bottomPadding - commonButtonHeight,
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

  Widget _buildPhrasesList() {
    return BlocBuilder<EnterSeedPhraseCubit, EnterSeedPhraseState>(
      builder: (context, state) {
        final cubit = context.read<EnterSeedPhraseCubit>();
        final l10n = context.l10n;
        final colors = context.themeStyle.colors;

        return state.when(
          initial: () => const SizedBox.shrink(),
          tab: (
            allowedValues,
            currentValue,
            controllers,
            focuses,
            displayPasteButton,
            error,
          ) =>
              SingleChildScrollView(
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.enterSeedPhrase,
                    style: StyleRes.h1.copyWith(color: colors.textPrimary),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: CommonTabBar<int>(
                          values: allowedValues,
                          selectedValue: currentValue,
                          onChanged: cubit.changeTab,
                          builder: (_, v) => l10n.wordsCount(v),
                        ),
                      ),
                      CommonButton.ghost(
                        onPressed: displayPasteButton
                            ? cubit.pastePhrase
                            : cubit.clearFields,
                        text:
                            displayPasteButton ? l10n.pasteAll : l10n.clearAll,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.pasteSeedIntoFirstBox,
                    style: StyleRes.primaryRegular
                        .copyWith(color: colors.textPrimary),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: controllers
                              .getRange(0, currentValue ~/ 2)
                              .mapIndexed(
                                (index, c) => _inputBuild(
                                  c,
                                  focuses[index],
                                  index + 1,
                                  currentValue,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          children: controllers
                              .getRange(currentValue ~/ 2, currentValue)
                              .mapIndexed(
                            (index, c) {
                              final i = index + currentValue ~/ 2;
                              return _inputBuild(
                                c,
                                focuses[i],
                                i + 1,
                                currentValue,
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (error == null)
                    SizedBox(
                      height: StyleRes.secondaryBold.fontSize! *
                          StyleRes.secondaryBold.height!,
                    )
                  else
                    Text(
                      (error.isEmpty ? '' : error).capitalize!,
                      style:
                          StyleRes.secondaryBold.copyWith(color: colors.alert),
                    ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// [index] start with 1
  Widget _inputBuild(
    TextEditingController controller,
    FocusNode focus,
    int index,
    int currentValue,
  ) {
    return Builder(
      builder: (context) {
        final cubit = context.read<EnterSeedPhraseCubit>();
        final colors = context.themeStyle.colors;

        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: CommonInput(
            controller: controller,
            suggestionsCallback: (_) => cubit.suggestionsCallback(controller),
            itemBuilder: _itemBuilder,
            onSuggestionSelected: (suggestion) =>
                cubit.onSuggestionSelected(suggestion, index - 1),
            focusNode: focus,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 16, top: 11, right: 4),
              child: Text(
                '$index.',
                style:
                    StyleRes.addRegular.copyWith(color: colors.textSecondary),
              ),
            ),
            onSubmitted: (_) => cubit.nextOrConfirm(index - 1),
            textInputAction: index == currentValue
                ? TextInputAction.done
                : TextInputAction.next,
          ),
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
}
