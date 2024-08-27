import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

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
              text: 'Default snackbar (icon is wrong)',
              onPressed: () {
                showSnackbar(
                  context: context,
                  toast: const Toast(
                    type: ToastType.warning,
                    icon: LucideIcons.triangleAlert,
                    description: 'Warning',
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            CommonButton.primary(
              text: 'Error snackbar',
              onPressed: () => showSnackbar(
                context: context,
                toast: const Toast(
                  type: ToastType.error,
                  icon: LucideIcons.triangle,
                  description: 'Error',
                ),
              ),
            ),
            const SizedBox(height: 20),
            CommonButton.primary(
              text: 'Snackbar with action',
              onPressed: () => showSnackbar(
                context: context,
                toast: Toast(
                  type: ToastType.success,
                  description: 'Success with action',
                  icon: LucideIcons.triangleAlert,
                  actions: [
                    FloatButton(
                      buttonShape: ButtonShape.rectangle,
                      buttonSize: ButtonSize.small,
                      title: 'Okay',
                      onPressed: () {},
                    ),
                    GhostButton(
                      buttonShape: ButtonShape.rectangle,
                      buttonSize: ButtonSize.small,
                      title: 'Contact Support',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            CommonButton.primary(
              text: 'Successful snackbar',
              onPressed: () => showSnackbar(
                context: context,
                toast: const Toast(
                  type: ToastType.success,
                  description: 'Success',
                  icon: LucideIcons.triangleAlert,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
