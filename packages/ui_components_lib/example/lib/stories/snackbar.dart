import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page with snackbars
class SnackbarStory extends StatelessWidget {
  const SnackbarStory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(titleText: 'SnackBars'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonButton.primary(
              text: 'Default snackbar',
              onPressed: () {
                showSnackbar(context: context, message: 'Default snackbar');
              },
            ),
            const SizedBox(height: 20),
            CommonButton.primary(
              text: 'Error snackbar',
              onPressed: () {
                showErrorSnackbar(context: context, message: 'Error snackbar');
              },
            ),
            const SizedBox(height: 20),
            CommonButton.primary(
              text: 'Snackbar with action',
              onPressed: () {
                showSnackbarWithAction(
                  context: context,
                  message: 'Snackbar with action',
                  action: () {
                    showSnackbar(context: context, message: 'Another snackbar');
                  },
                  actionText: 'Action',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
