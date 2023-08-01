import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page with read only controls
class ReadOnlyStory extends StatelessWidget {
  const ReadOnlyStory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(titleText: 'Read only'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SeparatedColumn(
            children: [
              const ProgressBar(value: 0),
              const ProgressBar(value: 0.25),
              const ProgressBar(value: 0.5),
              const ProgressBar(value: 0.75),
              const ProgressBar(value: 1),
              CountIndicator(
                count: 1,
                onPressed: () {
                  showSnackbar(
                    context: context,
                    type: SnackbarType.info,
                    message: 'Pressed',
                    duration: const Duration(seconds: 3),
                  );
                },
              ),
              CountIndicator(
                // ignore: no-magic-number
                count: 999,
                onPressed: () {
                  showSnackbar(
                    context: context,
                    type: SnackbarType.info,
                    message: 'Pressed',
                    duration: const Duration(seconds: 3),
                  );
                },
              ),
              const BrowserBottomBarPrimary(
                tabCount: 0,
              ),
              const BrowserBottomBarPrimary(
                tabCount: 1,
              ),
              const BrowserBottomBarTabs(),
            ],
          ),
        ),
      ),
    );
  }
}
