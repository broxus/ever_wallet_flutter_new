import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/buttons/button.dart';
import 'package:ui_components_lib/v2/widgets/toasts/toasts.dart';

class ToastsV2 extends StatelessWidget {
  const ToastsV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buttons v2')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DimensSize.d16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Toast(
              icon: LucideIcons.check,
              description: 'Paragraph',
              type: ToastType.normal,
              heading: 'Heading',
            ),
            const SizedBox(height: DimensSize.d8),
            const Toast(
              icon: LucideIcons.check,
              description: 'Its a very long test just for test flexibility '
                  'our description. If itll be look ok.',
              type: ToastType.error,
              heading: 'Heading',
            ),
            const SizedBox(height: DimensSize.d8),
            const Toast(
              icon: LucideIcons.check,
              description: 'The sun dipped below the horizon, casting a golden '
                  'glow over the tranquil sea. Birds chirped softly as the '
                  'first stars began to twinkle in the evening sky.',
              type: ToastType.warning,
            ),
            const SizedBox(height: DimensSize.d8),
            const Toast(
              icon: LucideIcons.check,
              description: 'The sun dipped below the horizon, casting a golden '
                  'glow over the tranquil sea. Birds chirped softly as the '
                  'first stars began to twinkle in the evening sky.',
              type: ToastType.success,
              heading: 'Test long title, this title will be more than one line',
            ),
            const SizedBox(height: DimensSize.d8),
            Toast(
              icon: LucideIcons.check,
              description: 'The sun dipped below the horizon, casting a golden '
                  'glow over the tranquil sea. Birds chirped softly as the '
                  'first stars began to twinkle in the evening sky.',
              type: ToastType.success,
              heading: 'Test long title, this title will be more than one line',
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
            const SizedBox(height: DimensSize.d8),
            Toast(
              icon: LucideIcons.check,
              description: 'The sun dipped below the horizon, casting a golden '
                  'glow over the tranquil sea. Birds chirped softly as the '
                  'first stars began to twinkle in the evening sky.',
              type: ToastType.error,
              heading: 'Test long title, this title will be more than one line',
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
          ],
        ),
      ),
    );
  }
}
