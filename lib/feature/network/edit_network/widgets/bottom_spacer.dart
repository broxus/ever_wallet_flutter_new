import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BottomSpacer extends StatelessWidget {
  const BottomSpacer({
    required this.deleteEnabled,
    required this.saveEnabled,
    super.key,
  });

  final bool deleteEnabled;
  final bool saveEnabled;

  @override
  Widget build(BuildContext context) {
    final buttonCount = (deleteEnabled ? 1 : 0) + (saveEnabled ? 1 : 0);

    return SliverSafeArea(
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: buttonCount * commonButtonHeight + DimensSizeV2.d16,
        ),
      ),
      minimum: const EdgeInsets.only(bottom: DimensSizeV2.d16),
    );
  }
}
