import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/segment_control/segment_control.dart';

class SegmentControlsV2 extends StatelessWidget {
  const SegmentControlsV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Segment-Controls v2')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(DimensSize.d16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                PrimarySegmentControl(
                  state: SegmentControlState.selected,
                  icon: LucideIcons.brain,
                  title: 'Test 1',
                  value: '123',
                ),
                PrimarySegmentControl(
                  state: SegmentControlState.normal,
                  icon: LucideIcons.brain,
                  title: 'Test 2',
                  value: '312',
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                PrimarySegmentControl(
                  state: SegmentControlState.normal,
                  icon: LucideIcons.airVent,
                  size: SegmentControlSize.medium,
                  title: 'A',
                  value: '1',
                ),
                PrimarySegmentControl(
                  state: SegmentControlState.selected,
                  icon: LucideIcons.album,
                  size: SegmentControlSize.medium,
                  title: 'B',
                  value: '2',
                ),
                PrimarySegmentControl(
                  state: SegmentControlState.normal,
                  icon: LucideIcons.facebook,
                  size: SegmentControlSize.medium,
                  title: 'C',
                  value: '3',
                ),
              ],
            ),
            Row(
              children: [
                PrimarySegmentControl(
                  state: SegmentControlState.selected,
                  icon: LucideIcons.airVent,
                  size: SegmentControlSize.small,
                  title: 'Hi',
                  value: '12',
                ),
                PrimarySegmentControl(
                  state: SegmentControlState.normal,
                  icon: LucideIcons.notebook,
                  size: SegmentControlSize.medium,
                  title: 'B',
                  value: '1',
                ),
                PrimarySegmentControl(
                  state: SegmentControlState.normal,
                  icon: LucideIcons.snowflake,
                  size: SegmentControlSize.medium,
                  title: 'C',
                  value: '1',
                ),
                PrimarySegmentControl(
                  state: SegmentControlState.normal,
                  icon: LucideIcons.mailCheck,
                  size: SegmentControlSize.medium,
                  title: 'D',
                  value: '321',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
