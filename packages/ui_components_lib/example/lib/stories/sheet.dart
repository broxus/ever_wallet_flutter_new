// ignore_for_file: no-magic-number

import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Page with sheets
class SheetStory extends StatelessWidget {
  const SheetStory({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return CommonSlidingPanel(
      panelBuilder: (context, controller) {
        return SingleChildScrollView(
          controller: controller,
          child: ContainerColumn(
            children: _generateItems(50),
          ),
        );
      },
      body: Scaffold(
        appBar: const DefaultAppBar(titleText: 'Sheets'),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonButton.primary(
                text: 'Show sheet 1 items',
                onPressed: () {
                  showCommonBottomSheet<void>(
                    context: context,
                    title: 'Sheet 1 item',
                    body: (context, _) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: _generateItems(1),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: DimensSize.d16),
              CommonButton.primary(
                text: 'Show sheet 5 items fullscreen',
                onPressed: () {
                  showCommonBottomSheet<void>(
                    context: context,
                    openFullScreen: true,
                    subtitle: 'Sheet 5 items fullscreen (subtitle)',
                    body: (context, _) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: _generateItems(5),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: DimensSize.d16),
              CommonButton.primary(
                text: 'Show sheet 10 items with appBackground',
                onPressed: () {
                  showCommonBottomSheet<void>(
                    context: context,
                    title: 'Sheet 10 items with appBackground',
                    subtitle: 'This is subtitle for sheet',
                    useAppBackgroundColor: true,
                    body: (context, controller) {
                      return Material(
                        color: colors.backgroundSecondary,
                        shape: const SquircleShapeBorder(
                          cornerRadius: DimensRadius.large,
                        ),
                        child: SingleChildScrollView(
                          controller: controller,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: _generateItems(10),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: DimensSize.d16),
              CommonButton.primary(
                text: 'Show sheet 30 items',
                onPressed: () {
                  showCommonBottomSheet<void>(
                    context: context,
                    title: 'Sheet 30 items',
                    body: (context, controller) {
                      return SingleChildScrollView(
                        controller: controller,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: _generateItems(30),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: DimensSize.d16),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _generateItems(int length) {
    return List.generate(
      length,
      (index) => ListTile(title: Text('Item ${index + 1}')),
    );
  }
}
