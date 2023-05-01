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
          .toList(),
    );
  }

  Widget _item(BuildContext context, T v) {
    final colors = context.themeStyle.colors;
    final isSelected = v == selectedValue;
    return PressScaleWidget(
      onPressed: () => onChanged(v),
      child: Container(
        height: 44,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? colors.textButtonSecondary : Colors.transparent,
            ),
          ),
        ),
        child: Text(
          builder(context, v),
          style: StyleRes.medium16.copyWith(
            color:
                isSelected ? colors.textButtonSecondary : colors.textTertiary,
          ),
        ),
      ),
    );
  }
}
