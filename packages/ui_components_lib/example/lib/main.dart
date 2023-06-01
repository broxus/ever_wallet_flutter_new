import 'package:example/stories/stories.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

void main() {
  runApp(const StoryWidget());
}

class StoryWidget extends StatelessWidget {
  const StoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Storybook(
      wrapperBuilder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: everPredefinedLightTheme(),
          darkTheme: everPredefinedDarkTheme(),
          useInheritedMediaQuery: true,
          home: child,
        );
      },
      initialStory: 'Widgets/Buttons',
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
          name: 'Widgets/Snackbar',
          builder: (_) => const SnackbarStory(),
        ),
        Story(
          name: 'Colors',
          builder: (_) => const ColorsStory(),
        ),
      ],
    );
  }
}
