import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Item of dropdown that allows displaying elements in UI.
class CommonSheetDropdownItem<T> {
  CommonSheetDropdownItem({
    required this.value,
    required this.title,
    this.icon,
  });

  final T value;
  final Widget? icon;
  final String title;
}

/// Widget that allows selecting one value from multiple using bottom sheet.
///
/// !!! If [values] contains only 1 item, then sheet will not be able to open.
class CommonSelectDropdown<T> extends StatelessWidget {
  const CommonSelectDropdown({
    required this.values,
    required this.currentValue,
    required this.onChanged,
    this.sheetTitle,
    this.titleText,
    this.subtitleText,
    super.key,
  });

  /// List of values that will be used to select [currentValue] using bottom
  /// sheet.
  final List<CommonSheetDropdownItem<T>> values;

  /// Current value that will be displayed.
  /// Value can be null that means, that nothing will be displayed.
  final T? currentValue;

  /// Title that will be displayed for input field.
  final String? titleText;

  /// Subtitle that will be displayed right to title.
  final String? subtitleText;

  /// Callback that calls when user select new item from sheet.
  final ValueChanged<T> onChanged;

  /// Title that is used in displayed sheet to tell user what to select
  final String? sheetTitle;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return PressScaleWidget(
      onPressed: values.length == 1 ? null : () => _openSelectSheet(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
        child: Container(
          padding: const EdgeInsets.only(
            left: DimensSizeV2.d16,
            right: DimensSizeV2.d8,
            bottom: DimensSizeV2.d8,
            top: DimensSizeV2.d8,
          ),
          decoration: BoxDecoration(
            color: theme.colors.background1,
            border: SquircleBoxBorder(
              squircleRadius: DimensRadiusV2.radius16,
              borderSide: BorderSide(color: theme.colors.border0),
            ),
          ),
          child: SeparatedRow(
            separatorSize: DimensSizeV2.d4,
            children: [
              if (titleText != null)
                Text(
                  titleText!,
                  style: theme.textStyles.labelSmall.copyWith(
                    color: theme.colors.content3,
                  ),
                ),
              Expanded(
                child: Text(
                  currentValue == null
                      ? ''
                      : values
                              .firstWhereOrNull(
                                (e) => e.value == currentValue,
                              )
                              ?.title ??
                          '',
                  style: theme.textStyles.paragraphSmall.copyWith(
                    color: theme.colors.content0,
                  ),
                ),
              ),
              FloatButton(
                buttonShape: ButtonShape.square,
                icon: LucideIcons.chevronRight,
                buttonSize: ButtonSize.small,
                onPressed:
                    values.length == 1 ? null : () => _openSelectSheet(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openSelectSheet(BuildContext context) {
    final theme = context.themeStyleV2;
    showCommonBottomSheet<void>(
      context: context,
      title: sheetTitle,
      centerTitle: true,
      titleTextStyle: theme.textStyles.headingLarge,
      body: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.only(top: DimensSize.d16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: DimensSizeV2.d18),
            margin: const EdgeInsets.only(bottom: DimensSizeV2.d12),
            decoration: BoxDecoration(
              color: theme.colors.background2,
              borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
            ),
            child: SeparatedColumn(
              separator: const Padding(
                padding: EdgeInsets.symmetric(vertical: DimensSize.d18),
                child: CommonDivider(),
              ),
              children: values
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        onChanged(e.value);
                      },
                      child: Row(
                        children: [
                          const SizedBox(width: DimensSizeV2.d24),
                          Expanded(
                            child: Text(
                              e.title,
                              style: theme.textStyles.labelMedium,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          if (currentValue == e.value)
                            const Icon(
                              LucideIcons.check,
                              size: DimensSizeV2.d20,
                            ),
                          const SizedBox(width: DimensSize.d24),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
