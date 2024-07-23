import 'package:example/stories/v2/buttons.dart';
import 'package:example/stories/v2/segment_contols.dart';
import 'package:example/stories/v2/text_fields.dart';
import 'package:example/stories/v2/toasts.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:ui_components_lib/v2/predefined_theme_v2.dart';

class StoryV2 extends StatelessWidget {
  const StoryV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: getPredefinedDarkTheme(),
      child: Storybook(
        initialStory: 'Widgets',
        wrapperBuilder: (_, Widget? child) {
          return Material(
            type: MaterialType.transparency,
            child: child,
          );
        },
        stories: [
          Story(
            name: 'Widgets/TextFields',
            builder: (_) => const TextFieldsStoryV2(),
          ),
          Story(
            name: 'Widgets/Buttons',
            builder: (_) => const ButtonsStoryV2(),
          ),
          Story(
            name: 'Widgets/Segment-Controls',
            builder: (_) => const SegmentControlsV2(),
          ),
          Story(
            name: 'Widgets/Toasts',
            builder: (_) => const ToastsV2(),
          ),
        ],
      ),
    );
  }
}
