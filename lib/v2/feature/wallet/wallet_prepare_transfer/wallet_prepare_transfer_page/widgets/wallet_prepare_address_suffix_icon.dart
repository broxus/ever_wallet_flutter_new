import 'package:app/generated/assets.gen.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/components/button/button.dart';
import 'package:ui_components_lib/theme_style.dart';

class WalletPrepareAddressSuffixIcon extends StatelessWidget {
  const WalletPrepareAddressSuffixIcon({
    required this.receiverState,
    required this.onPressedClear,
    required this.onPressedPastAddress,
    required this.onPressedScan,
    super.key,
  });

  final StateNotifier<String?> receiverState;
  final VoidCallback onPressedClear;
  final VoidCallback onPressedPastAddress;
  final VoidCallback onPressedScan;

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder<String?>(
      listenableState: receiverState,
      builder: (context, String? text) {
        final colors = context.themeStyle.colors;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (text?.isNotEmpty ?? false)
              CommonIconButton.icon(
                buttonType: EverButtonType.ghost,
                icon: Icons.clear_rounded,
                size: CommonIconButtonSize.small,
                onPressed: onPressedClear,
                color: colors.textSecondary,
              )
            else
              CommonIconButton.svg(
                buttonType: EverButtonType.ghost,
                svg: Assets.images.paste.path,
                size: CommonIconButtonSize.small,
                onPressed: onPressedPastAddress,
                color: colors.blue,
              ),
            CommonIconButton.svg(
              buttonType: EverButtonType.ghost,
              svg: Assets.images.scan.path,
              size: CommonIconButtonSize.small,
              onPressed: onPressedScan,
              color: colors.blue,
            ),
          ],
        );
      },
    );
  }
}
