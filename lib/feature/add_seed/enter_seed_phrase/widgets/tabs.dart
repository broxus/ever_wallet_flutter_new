import 'package:app/generated/generated.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class EnterSeedPhraseTabs extends StatelessWidget {
  const EnterSeedPhraseTabs({
    required this.allowedValues,
    required this.currentValue,
    required this.displayPasteButtonState,
    required this.changeTab,
    required this.pastePhrase,
    required this.clearFields,
    super.key,
  });

  final List<int> allowedValues;
  final int currentValue;
  final ListenableState<bool> displayPasteButtonState;
  final ValueChanged<int> changeTab;
  final VoidCallback pastePhrase;
  final VoidCallback clearFields;

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
                    onTap: () => changeTab(value),
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
        StateNotifierBuilder(
          listenableState: displayPasteButtonState,
          builder: (_, bool? isDisplay) {
            isDisplay ??= true;
            return GhostButton(
              buttonShape: ButtonShape.pill,
              buttonSize: ButtonSize.small,
              onPressed: isDisplay ? pastePhrase : clearFields,
              title: isDisplay
                  ? LocaleKeys.pasteAll.tr()
                  : LocaleKeys.clearAll.tr(),
              icon: isDisplay ? LucideIcons.arrowDownToDot : LucideIcons.trash2,
            );
          },
        ),
      ],
    );
  }
}
