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
      appBar: const DefaultAppBar(titleText: 'Buttons'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SeparatedColumn(
                children: CommonButtonSize.values
                    .map(
                      (size) => SeparatedRow(
                        children: [
                          /// Primary
                          CommonButton.primary(
                            leading:
                                CommonButtonIconWidget.icon(icon: Icons.add),
                            trailing:
                                CommonButtonIconWidget.icon(icon: Icons.alarm),
                            text: 'PrimaryButton',
                            // ignore: no-empty-block
                            onPressed: () {},
                            size: size,
                          ),
                          CommonButton.primary(
                            leading:
                                CommonButtonIconWidget.icon(icon: Icons.add),
                            trailing:
                                CommonButtonIconWidget.icon(icon: Icons.alarm),
                            text: 'PrimaryButton Disabled',
                            size: size,
                          ),
                          CommonButton.primary(
                            leading:
                                CommonButtonIconWidget.icon(icon: Icons.add),
                            trailing:
                                CommonButtonIconWidget.icon(icon: Icons.alarm),
                            text: 'PrimaryButton fillWidth',
                            fillWidth: true,
                            // ignore: no-empty-block
                            onPressed: () {},
                            size: size,
                          ),
                          CommonButton.primary(
                            leading:
                                CommonButtonIconWidget.icon(icon: Icons.add),
                            trailing:
                                CommonButtonIconWidget.icon(icon: Icons.alarm),
                            text: 'PrimaryButton',
                            // ignore: no-empty-block
                            onPressed: () {},
                            isLoading: true,
                            size: size,
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),
              SeparatedColumn(
                children: CommonButtonSize.values
                    .map(
                      (size) => SeparatedRow(
                        children: [
                          /// Secondary
                          CommonButton.secondary(
                            leading:
                                CommonButtonIconWidget.icon(icon: Icons.add),
                            trailing:
                                CommonButtonIconWidget.icon(icon: Icons.alarm),
                            text: 'SecondaryButton',
                            // ignore: no-empty-block
                            onPressed: () {},
                            size: size,
                          ),
                          CommonButton.secondary(
                            leading:
                                CommonButtonIconWidget.icon(icon: Icons.add),
                            trailing:
                                CommonButtonIconWidget.icon(icon: Icons.alarm),
                            text: 'SecondaryButton Disabled',
                            size: size,
                          ),
                          CommonButton.secondary(
                            leading:
                                CommonButtonIconWidget.icon(icon: Icons.add),
                            trailing:
                                CommonButtonIconWidget.icon(icon: Icons.alarm),
                            text: 'SecondaryButton fillWidth',
                            fillWidth: true,
                            // ignore: no-empty-block
                            onPressed: () {},
                            size: size,
                          ),
                          CommonButton.secondary(
                            leading:
                                CommonButtonIconWidget.icon(icon: Icons.add),
                            trailing:
                                CommonButtonIconWidget.icon(icon: Icons.alarm),
                            text: 'SecondaryButton',
                            // ignore: no-empty-block
                            onPressed: () {},
                            isLoading: true,
                            size: size,
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),
              SeparatedColumn(
                children: CommonButtonSize.values
                    .map(
                      (size) => SeparatedRow(
                        children: [
                          /// Ghost
                          CommonButton.ghost(
                            leading:
                                CommonButtonIconWidget.icon(icon: Icons.add),
                            trailing:
                                CommonButtonIconWidget.icon(icon: Icons.alarm),
                            text: 'GhostButton',
                            // ignore: no-empty-block
                            onPressed: () {},
                            size: size,
                          ),
                          CommonButton.ghost(
                            leading:
                                CommonButtonIconWidget.icon(icon: Icons.add),
                            trailing:
                                CommonButtonIconWidget.icon(icon: Icons.alarm),
                            text: 'GhostButton Disabled',
                            size: size,
                          ),
                          CommonButton.ghost(
                            leading:
                                CommonButtonIconWidget.icon(icon: Icons.add),
                            trailing:
                                CommonButtonIconWidget.icon(icon: Icons.alarm),
                            text: 'GhostButton fillWidth',
                            fillWidth: true,
                            // ignore: no-empty-block
                            onPressed: () {},
                            size: size,
                          ),
                          CommonButton.ghost(
                            leading:
                                CommonButtonIconWidget.icon(icon: Icons.add),
                            trailing:
                                CommonButtonIconWidget.icon(icon: Icons.alarm),
                            text: 'GhostButton',
                            // ignore: no-empty-block
                            onPressed: () {},
                            isLoading: true,
                            size: size,
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),

              /// TabBar
              const SizedBox(height: 60),
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
              SeparatedColumn(
                children: CommonIconButtonSize.values
                    .map(
                      (size) => Row(
                        children: [
                          CommonIconButton.icon(
                            icon: Icons.add,
                            // ignore: no-empty-block
                            onPressed: () {},
                            buttonType: EverButtonType.primary,
                            size: size,
                          ),
                          const SizedBox(width: 10),
                          CommonIconButton.icon(
                            icon: Icons.add,
                            buttonType: EverButtonType.primary,
                            size: size,
                          ),
                          const SizedBox(width: 20),
                          CommonIconButton.icon(
                            icon: Icons.add,
                            // ignore: no-empty-block
                            onPressed: () {},
                            buttonType: EverButtonType.secondary,
                            size: size,
                          ),
                          const SizedBox(width: 10),
                          CommonIconButton.icon(
                            icon: Icons.add,
                            buttonType: EverButtonType.secondary,
                            size: size,
                          ),
                          const SizedBox(width: 20),
                          CommonIconButton.icon(
                            icon: Icons.add,
                            // ignore: no-empty-block
                            onPressed: () {},
                            buttonType: EverButtonType.ghost,
                            size: size,
                          ),
                          const SizedBox(width: 10),
                          CommonIconButton.icon(
                            icon: Icons.add,
                            buttonType: EverButtonType.ghost,
                            size: size,
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
