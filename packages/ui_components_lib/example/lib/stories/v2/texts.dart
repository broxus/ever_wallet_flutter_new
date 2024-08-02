import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Page with texts
class TextsStoryV2 extends StatefulWidget {
  const TextsStoryV2({super.key});

  @override
  State<TextsStoryV2> createState() => _TextsStoryV2State();
}

class _TextsStoryV2State extends State<TextsStoryV2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Texts v2')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(DimensSize.d16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: DimensSize.d20),
            PrimaryText(
              'TitleLarge',
              type: PrimaryTextType.titleLarge,
            ),
            SizedBox(height: DimensSize.d20),
            PrimaryText(
              'TitleSmall',
              type: PrimaryTextType.titleSmall,
            ),
            SizedBox(height: DimensSize.d20),
            PrimaryText(
              'DescriptionLarge',
            ),
            SizedBox(height: DimensSize.d20),
            PrimaryText(
              'DescriptionSmall',
              type: PrimaryTextType.descriptionSmall,
            ),
            SizedBox(height: DimensSize.d40),
          ],
        ),
      ),
    );
  }
}
