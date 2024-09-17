import 'package:app/feature/wallet/widgets/account_settings/widgets/change_color_bottom_sheet/change_color_bottom_sheet_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/components/button/app_bar_back_button.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function to show [ChangeColorBottomSheet].
Future<void> showChangeColorBottomSheet({
  required BuildContext context,
  required PublicKey publicKey,
}) {
  return showCommonBottomSheet(
    titleMargin: EdgeInsets.zero,
    context: context,
    body: (_, __) => ChangeColorBottomSheet(
      publicKey: publicKey,
    ),
  );
}

class ChangeColorBottomSheet
    extends ElementaryWidget<ChangeColorBottomSheetWidgetModel> {
  const ChangeColorBottomSheet({
    required this.publicKey,
    Key? key,
    WidgetModelFactory<ChangeColorBottomSheetWidgetModel> wmFactory =
        defaultChangeColorBottomSheetWidgetModelFactory,
  }) : super(
          wmFactory,
          key: key,
        );

  final PublicKey publicKey;

  @override
  Widget build(ChangeColorBottomSheetWidgetModel wm) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppBarBackButton(
                  onPressed: wm.onPressedBack,
                ),
              ),
            ),
            Expanded(
              child: Align(
                child: Text(
                  LocaleKeys.changeColor.tr(),
                  style: wm.textStyle.headingMedium,
                ),
              ),
            ),
            const Expanded(
              child: SizedBox.shrink(),
            ),
          ],
        ),
        const SizedBox(height: DimensSizeV2.d28),
      ],
    );
  }
}
