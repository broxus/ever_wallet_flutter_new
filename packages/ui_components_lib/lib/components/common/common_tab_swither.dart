import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Definition of tab item for [CommonTabSwitcher]
class CommonTabSwitcherItem<T> {
  CommonTabSwitcherItem({
    required this.title,
    required this.value,
  });

  final String title;
  final T value;
}

/// {@template common_tab_switcher}
///
/// This is a widget, that allows switch between different tabs.
/// It is same as [CommonTabBar] in behavior, but it has different UI/UX
///
/// {@endtemplate}
class CommonTabSwitcher<T> extends StatelessWidget {
  /// {@macro common_tab_switcher}
  const CommonTabSwitcher({
    required this.onTabChanged,
    required this.values,
    required this.currentValue,
    this.fillWidth = true,
    super.key,
  });

  /// Callback when user click on tab
  final ValueChanged<T> onTabChanged;

  /// List of items that should be displayed in tab
  final List<CommonTabSwitcherItem<T>> values;

  /// Current value of tab
  final T currentValue;

  /// If widget should fill all available width
  final bool fillWidth;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return ShapedContainerRow(
      mainAxisSize: MainAxisSize.min,
      separatorSize: DimensSize.d4,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(DimensSize.d4),
      color: colors.appBackground,
      children: values.map((i) {
        final item = _switcherItem(i, colors);

        if (fillWidth) {
          return Expanded(child: item);
        }

        return item;
      }).toList(),
    );
  }

  Widget _switcherItem(CommonTabSwitcherItem<T> item, ColorsPalette colors) {
    return AnimatedColor(
      color: item.value == currentValue
          ? colors.backgroundSecondary
          : colors.appBackground,
      duration: kThemeAnimationDuration,
      builder: (context, color) {
        return CommonButton(
          height: DimensSize.d48,
          squircleRadius: DimensRadius.medium,
          buttonType: EverButtonType.ghost,
          onPressed: () => onTabChanged(item.value),
          fillWidth: fillWidth,
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(
            horizontal: DimensSize.d16,
            vertical: DimensSize.d4,
          ),
          textAlign: TextAlign.center,
          text: item.title,
          contentColor: colors.textPrimary,
        );
      },
    );
  }
}
