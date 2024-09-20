import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

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
    this.titleChild,
    this.subtitleChild,
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

  /// Widget that can be used to title for input.
  /// In common cases, you will use [titleText].
  final Widget? titleChild;

  /// Subtitle that will be displayed right to title.
  final String? subtitleText;

  /// Widget that can be used to subtitle for input.
  /// In common cases, you will use [subtitleText].
  final Widget? subtitleChild;

  /// Callback that calls when user select new item from sheet.
  final ValueChanged<T> onChanged;

  /// Title that is used in displayed sheet to tell user what to select
  final String? sheetTitle;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    final title = titleChild ??
        (titleText == null
            ? null
            : Text(
                titleText!,
                style: theme.textStyles.labelMedium,
              ));

    final subtitle = subtitleChild ??
        (subtitleText == null
            ? null
            : Text(
                subtitleText!,
                style: theme.textStyles.labelSmall,
              ));

    return PressScaleWidget(
      onPressed: values.length == 1 ? null : () => _openSelectSheet(context),
      child: SeparatedColumn(
        children: [
          if (title != null || subtitle != null)
            SeparatedRow(
              separatorSize: DimensSize.d4,
              children: [
                if (title != null) title,
                if (subtitle != null) subtitle,
              ],
            ),
          ClipRRect(
            borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: DimensSize.d16,
                vertical: DimensSize.d12,
              ),
              decoration: BoxDecoration(
                color: theme.colors.background1,
                border: SquircleBoxBorder(
                  squircleRadius: DimensRadiusV2.radius16,
                  borderSide: BorderSide(color: theme.colors.border0),
                ),
              ),
              child: SeparatedRow(
                children: [
                  Expanded(
                    child: currentValue == null
                        ? const SizedBox.shrink()
                        : _itemBuilder(
                            values.firstWhere((e) => e.value == currentValue),
                          ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: theme.colors.content0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemBuilder(
    CommonSheetDropdownItem<T> value, {
    bool isSelected = false,
    VoidCallback? onPressed,
  }) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;

        return CommonListTile(
          height: DimensSize.d32,
          leading: value.icon,
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          titleText: value.title,
          trailing: isSelected
              ? Icon(Icons.check_rounded, color: colors.textPrimary)
              : null,
        );
      },
    );
  }

  void _openSelectSheet(BuildContext context) {
    showCommonBottomSheet<void>(
      context: context,
      title: sheetTitle,
      body: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.only(top: DimensSize.d16),
          child: SeparatedColumn(
            separator: const Padding(
              padding: EdgeInsets.symmetric(vertical: DimensSize.d12),
              child: CommonDivider(),
            ),
            children: values
                .map(
                  (e) => _itemBuilder(
                    e,
                    isSelected: e == currentValue,
                    onPressed: () {
                      Navigator.of(context).pop();
                      onChanged(e.value);
                    },
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
