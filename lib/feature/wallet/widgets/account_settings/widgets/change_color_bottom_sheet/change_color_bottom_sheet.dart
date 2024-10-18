import 'package:app/app/service/identify/identy_icon_data.dart';
import 'package:app/feature/wallet/widgets/account_settings/widgets/change_color_bottom_sheet/change_color_bottom_sheet_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/components/button/app_bar_back_button.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Helper function to show [ChangeColorBottomSheet].
Future<void> showChangeColorBottomSheet({
  required BuildContext context,
  required String address,
}) {
  return showCommonBottomSheet(
    titleMargin: EdgeInsets.zero,
    context: context,
    body: (_, __) => ChangeColorBottomSheet(
      address: address,
    ),
  );
}

class ChangeColorBottomSheet
    extends ElementaryWidget<ChangeColorBottomSheetWidgetModel> {
  const ChangeColorBottomSheet({
    required this.address,
    Key? key,
    WidgetModelFactory<ChangeColorBottomSheetWidgetModel> wmFactory =
        defaultChangeColorBottomSheetWidgetModelFactory,
  }) : super(
          wmFactory,
          key: key,
        );

  final String address;

  @override
  Widget build(ChangeColorBottomSheetWidgetModel wm) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppBarBackButton(
              onPressed: wm.onPressedBack,
            ),
            Text(
              LocaleKeys.changeAvatarColor.tr(),
              style: wm.textStyle.headingMedium,
            ),
            const SizedBox(width: DimensSizeV2.d48),
          ],
        ),
        const SizedBox(height: DimensSizeV2.d28),
        Flexible(
          child: StateNotifierBuilder<IdentifyIconData?>(
            listenableState: wm.selectedColorState,
            builder: (_, IdentifyIconData? selectedColor) {
              return SizedBox(
                height: DimensSizeV2.d64,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (var i = 0; i < wm.count; i++)
                      _ItemColor(
                        key: ValueKey(wm.availableColors[i].color),
                        color: wm.availableColors[i].color,
                        isSelected: wm.availableColors[i] == selectedColor,
                        onPressed: () =>
                            wm.onPressedColor(wm.availableColors[i]),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: DimensSizeV2.d16),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.save.tr(),
          onPressed: wm.onPressedSave,
        ),
      ],
    );
  }
}

class _ItemColor extends StatelessWidget {
  const _ItemColor({
    required this.color,
    required this.isSelected,
    required this.onPressed,
    super.key,
  });

  final Color color;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: _Wrapper(
        isVisible: isSelected,
        child: SizedBox.expand(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

class _Wrapper extends StatelessWidget {
  const _Wrapper({
    required this.isVisible,
    required this.child,
  });

  final bool isVisible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: DimensSizeV2.d64,
      width: DimensSizeV2.d64,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isVisible
                ? context.themeStyleV2.colors.borderFocus
                : Colors.transparent,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(DimensSizeV2.d3),
          child: child,
        ),
      ),
    );
  }
}
