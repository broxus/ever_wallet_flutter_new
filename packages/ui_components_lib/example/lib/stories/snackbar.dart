import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page with snackbars
class SnackbarStory extends StatelessWidget {
  const SnackbarStory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snackbar'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonButton.primary(
              text: 'Default snackbar',
              onPressed: () {
                showSnackbar(
                  context: context,
                  type: SnackbarType.info,
                  message: 'Default snackbar',
                  duration: const Duration(seconds: 3),
                );
              },
            ),
            const SizedBox(height: 20),
            CommonButton.primary(
              text: 'Error snackbar',
              onPressed: () => showSnackbar(
                context: context,
                type: SnackbarType.error,
                message: 'Error snackbar',
                duration: const Duration(seconds: 3),
              ),
            ),
            const SizedBox(height: 20),
            CommonButton.primary(
              text: 'Snackbar with action',
              onPressed: () => showSnackbar(
                context: context,
                type: SnackbarType.info,
                message: 'Action snackbar',
                duration: const Duration(seconds: 3),
                actionText: 'Action',
                onAction: () => showSnackbar(
                  context: context,
                  type: SnackbarType.info,
                  message: 'Another snackbar',
                  duration: const Duration(seconds: 3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
