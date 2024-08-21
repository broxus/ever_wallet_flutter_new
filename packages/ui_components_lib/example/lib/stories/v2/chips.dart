import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';
import 'package:ui_components_lib/v2/widgets/chips/chips.dart';

class ChipsV2 extends StatelessWidget {
  const ChipsV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Segment-Controls v2')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(DimensSizeV2.d16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                PrimaryChip(
                  text: 'Test name',
                  iconData: LucideIcons.globe,
                  type: ChipsType.warning,
                ),
                SizedBox(width: 16),
                PrimaryChip(
                  text: 'Animal',
                  iconData: LucideIcons.cat,
                  type: ChipsType.success,
                ),
              ],
            ),
            SizedBox(height: DimensSizeV2.d16),
            Row(
              children: [
                PrimaryChip(
                  text: 'Fox animal',
                  iconData: LucideIcons.dog,
                  type: ChipsType.error,
                ),
                SizedBox(width: DimensSizeV2.d16),
                PrimaryChip(
                  text: 'House',
                  iconData: LucideIcons.house,
                  type: ChipsType.normal,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
