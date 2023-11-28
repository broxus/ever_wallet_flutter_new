import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Builder of tab bar item
typedef CommonTabBarTitleBuilder<T> = String Function(
  BuildContext context,
  T value,
);

/// Builder of trailing widget of tab, returned widget is optional but may be
/// used to add some information about tab.
/// To get content color, you may use [EverButtonStyleProvider]
typedef CommonTabBarTrailingBuilder<T> = Widget? Function(
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
    this.trailingBuilder,
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

  /// Builder of trailing item for any tab.
  final CommonTabBarTrailingBuilder<T>? trailingBuilder;

  @override
  Widget build(BuildContext context) {
    return SeparatedRow(
      children: values
          .map(
            (v) => fillWidth
                ? Expanded(child: _item(context, v))
                : _item(context, v),
          )
          .toList(),
    );
  }

  Widget _item(BuildContext context, T v) {
    final colors = context.themeStyle.colors;
    final isSelected = v == selectedValue;
    final trailing = trailingBuilder?.call(context, v);

    return CommonButton(
      onPressed: () => onChanged(v),
      padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
      fillWidth: fillWidth,
      text: builder(context, v),
      height: DimensSize.d48,
      squircleRadius: DimensRadius.xMedium,
      backgroundColor:
          isSelected ? colors.backgroundPrimary : colors.backgroundSecondary,
      contentColor: isSelected ? colors.textContrast : colors.textSecondary,
      contentPressedColor:
          isSelected ? colors.textSecondary : colors.textPrimary,
      trailing: trailing,
    );
  }
}
