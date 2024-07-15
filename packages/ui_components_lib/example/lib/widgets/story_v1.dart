import 'package:example/stories/stories.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:ui_components_lib/predefined_theme.dart';

class StoryV1 extends StatelessWidget {
  const StoryV1({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: everPredefinedLightTheme(),
      child: Storybook(
        initialStory: 'Git log',
        wrapperBuilder: (_, Widget? child) {
          return Material(
            type: MaterialType.transparency,
            child: child,
          );
        },
        stories: [
          Story(
            name: 'Git log',
            builder: (_) => const GitLog(),
          ),
          Story(
            name: 'Widgets/Buttons',
            builder: (_) => const ButtonsStory(),
          ),
          Story(
            name: 'Widgets/Inputs',
            builder: (_) => const InputsStory(),
          ),
          Story(
            name: 'Widgets/Currency Inputs',
            builder: (_) => const CurrencyInputsStory(),
          ),
          Story(
            name: 'Widgets/Snackbar',
            builder: (_) => const SnackbarStory(),
          ),
          Story(
            name: 'Widgets/Sheet',
            builder: (_) => const SheetStory(),
          ),
          Story(
            name: 'Widgets/Common',
            builder: (_) => const CommonStory(),
          ),
          Story(
            name: 'Widgets/Read Only',
            builder: (_) => const ReadOnlyStory(),
          ),
          Story(
            name: 'Colors',
            builder: (_) => const ColorsStory(),
          ),
        ],
      ),
    );
  }
}
