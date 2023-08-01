import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page with read only controls
class ReadOnlyStory extends StatefulWidget {
  const ReadOnlyStory({super.key});

  @override
  State<ReadOnlyStory> createState() => _ReadOnlyStoryState();
}

class _ReadOnlyStoryState extends State<ReadOnlyStory> {
  Timer? _timer;
  double _progress = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _progress = Random().nextDouble();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
              ProgressBar(value: _progress),
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
