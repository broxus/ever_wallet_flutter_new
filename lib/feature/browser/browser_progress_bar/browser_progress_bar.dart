import 'package:app/feature/browser/browser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserProgressBar extends StatelessWidget {
  const BrowserProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrowserTabsBloc, BrowserTabsState>(
      builder: (context, state) {
        final currentTabState = context.watch<BrowserTabsBloc>().activeTabState;
        final value = switch (currentTabState?.state) {
          BrowserTabStateType.loading =>
            (currentTabState?.progress ?? 0.0) / 100.0,
          _ => null,
        };

        return value != null
            ? ProgressBar(
                value: value,
                color: context.themeStyleV2.colors.accent,
                height: DimensSizeV2.d3,
              )
            : const SizedBox();
      },
    );
  }
}
