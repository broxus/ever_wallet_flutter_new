import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page with buttons
class ButtonsStory extends StatefulWidget {
  const ButtonsStory({super.key});

  @override
  State<ButtonsStory> createState() => _ButtonsStoryState();
}

class _ButtonsStoryState extends State<ButtonsStory> {
  static const tabs = ['Tab1', 'Tab2', 'Tab3'];
  final tabBar1Notifier = ValueNotifier<String>(tabs.first);
  final tabBar2Notifier = ValueNotifier<String>(tabs.first);

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
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                child: const Text('BUTTON'),
              ),
              Material(
                shape: const SquircleShapeBorder(cornerRadius: 100),
                color: Colors.black,
                child: InkResponse(
                  onTap: () {},
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.grey[200],
                  splashFactory: const SquircleShapeFactory(cornerRadius: 100),
                  customBorder: const SquircleShapeBorder(cornerRadius: 100),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Plain Squircle',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

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
              const SizedBox(height: 20),

              /// TabBar
              const Text('TabBar without fillWidth'),
              ValueListenableBuilder(
                valueListenable: tabBar1Notifier,
                builder: (_, value, __) {
                  return CommonTabBar<String>(
                    values: tabs,
                    builder: (_, v) => v,
                    selectedValue: value,
                    onChanged: (v) => tabBar1Notifier.value = v,
                  );
                },
              ),
              const SizedBox(height: 10),

              const Text('TabBar with fillWidth'),
              ValueListenableBuilder(
                valueListenable: tabBar2Notifier,
                builder: (_, value, __) {
                  return CommonTabBar<String>(
                    values: tabs,
                    fillWidth: true,
                    builder: (_, v) => v,
                    selectedValue: value,
                    onChanged: (v) => tabBar2Notifier.value = v,
                  );
                },
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
