import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Helper function to show [SwitchToThisNetworkSheet].
Future<void> showSwitchToThisNetworkSheet({
  required BuildContext context,
  required VoidCallback onSwitch,
}) {
  return showCommonBottomSheet(
    context: context,
    body: (_, __) => SwitchToThisNetworkSheet(
      onSwitch: onSwitch,
    ),
  );
}

class SwitchToThisNetworkSheet extends StatefulWidget {
  const SwitchToThisNetworkSheet({
    required this.onSwitch,
    super.key,
  });

  final VoidCallback onSwitch;

  @override
  State<SwitchToThisNetworkSheet> createState() =>
      _SwitchToThisNetworkSheetState();
}

class _SwitchToThisNetworkSheetState extends State<SwitchToThisNetworkSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: DimensSizeV2.d24),
        Image.asset(
          Assets.images.checkCircleFill.checkCircleFill.path,
          height: DimensSizeV2.d56,
          width: DimensSizeV2.d56,
        ),
        const SizedBox(height: DimensSizeV2.d16),
        Text(
          LocaleKeys.networkAddedSheetTitle.tr(),
          style: theme.textStyles.headingLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: DimensSizeV2.d24),
        AccentButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.networkAddedSheetSwitch.tr(),
          onPressed: _onSwitch,
        ),
        const SizedBox(height: DimensSizeV2.d8),
        PrimaryButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.networkAddedSheetContinue.tr(),
          onPressed: _onContinue,
        ),
      ],
    );
  }

  void _onSwitch() {
    widget.onSwitch();
    Navigator.of(context).pop();
  }

  void _onContinue() => Navigator.of(context).pop();
}
