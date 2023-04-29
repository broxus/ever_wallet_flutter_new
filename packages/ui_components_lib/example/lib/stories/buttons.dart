import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page with buttons
class ButtonsStory extends StatelessWidget {
  const ButtonsStory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buttons'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Primary
              CommonButton.primary(
                text: 'PrimaryButton',
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              CommonButton.primary(
                text: 'PrimaryButton Disabled',
              ),
              const SizedBox(height: 10),
              CommonButton.primary(
                text: 'PrimaryButton fillWidth',
                fillWidth: true,
                onPressed: () {},
              ),
              const SizedBox(height: 20),

              /// Secondary
              CommonButton.secondary(
                text: 'SecondaryButton',
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              CommonButton.secondary(
                text: 'SecondaryButton Disabled',
              ),
              const SizedBox(height: 10),
              CommonButton.secondary(
                text: 'SecondaryButton fillWidth',
                fillWidth: true,
                onPressed: () {},
              ),

              /// Tertiary
              const SizedBox(height: 20),
              CommonButton.tertiary(
                text: 'TertiaryButton',
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              CommonButton.tertiary(
                text: 'TertiaryButton Disabled',
              ),
              const SizedBox(height: 10),
              CommonButton.tertiary(
                text: 'TertiaryButton fillWidth',
                fillWidth: true,
                onPressed: () {},
              ),

              /// Ghost
              const SizedBox(height: 20),
              CommonButton.ghost(
                text: 'GhostButton',
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              CommonButton.ghost(
                text: 'GhostButton Disabled',
              ),
              const SizedBox(height: 10),
              CommonButton.ghost(
                text: 'GhostButton fillWidth',
                fillWidth: true,
                onPressed: () {},
              ),

              /// GhostNoPadding
              const SizedBox(height: 20),
              CommonButton.ghostNoPadding(
                text: 'GhostNoPaddingButton',
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              CommonButton.ghostNoPadding(
                text: 'GhostNoPaddingButton Disabled',
              ),
              const SizedBox(height: 10),
              CommonButton.ghostNoPadding(
                text: 'GhostNoPaddingButton fillWidth',
                fillWidth: true,
                onPressed: () {},
              ),

              /// Attention
              const SizedBox(height: 20),
              CommonButton.attention(
                text: 'AttentionButton',
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              CommonButton.attention(
                text: 'AttentionButton Disabled',
              ),
              const SizedBox(height: 10),
              CommonButton.attention(
                text: 'AttentionButton fillWidth',
                fillWidth: true,
                onPressed: () {},
              ),

              /// IconButton
              const SizedBox(height: 20),
              CommonIconButton.icon(icon: Icons.add, onPressed: () {}),
              const SizedBox(height: 10),
              CommonIconButton.icon(icon: Icons.add),
            ],
          ),
        ),
      ),
    );
  }
}
