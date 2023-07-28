import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page with snackbars
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
            children: const [
              ProgressBar(value: 0),
              ProgressBar(value: 0.25),
              ProgressBar(value: 0.5),
              ProgressBar(value: 0.75),
              ProgressBar(value: 1),
            ],
          ),
        ),
      ),
    );
  }
}
