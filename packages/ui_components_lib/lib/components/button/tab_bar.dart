import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Builder of tab bar item
typedef CommonTabBarTitleBuilder<T> = String Function(
  BuildContext context,
  T value,
);

/// {@template common_tab_bar}
/// Default tab bar that displays section selection.
/// {@endtemplate}
class CommonTabBar<T> extends StatelessWidget {
  /// {@macro common_tab_bar}
  const CommonTabBar({
    required this.values,
    required this.builder,
    required this.selectedValue,
    required this.onChanged,
    this.fillWidth = false,
    super.key,
  });

  /// List of values that could be selected
  final List<T> values;

  /// Builder of tab bar title that uses [values] to build tab title
  final CommonTabBarTitleBuilder<T> builder;

  /// Callback that calls when user select new tab
  final ValueChanged<T> onChanged;

  /// Current value of tabbar
  final T selectedValue;

  /// Whether the tab bar should fill the horizontal space
  final bool fillWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: values
          .map(
            (v) => fillWidth
                ? Expanded(child: _item(context, v))
                : _item(context, v),
          )
          .separated(const SizedBox(width: 8))
          .toList(),
    );
  }

  Widget _item(BuildContext context, T v) {
    final colors = context.themeStyle.colors;
    final isSelected = v == selectedValue;

    return CommonButton(
      onPressed: () => onChanged(v),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      fillWidth: fillWidth,
      text: builder(context, v),
      // TODO(alex-a4): mabye we should use something
      // like Dimens.buttonHeight.medium?
      height: Dimens.dimens12,
      // TODO(alex-a4): aaand default squircle radius?
      squircleRadius: Dimens.dimens03,
      backgroundColor:
          isSelected ? colors.backgroundPrimary : colors.backgroundSecondary,
      contentColor: isSelected ? colors.textContrast : colors.textSecondary,
      contentPressedColor:
          isSelected ? colors.textSecondary : colors.textPrimary,
    );
  }
}
