import 'package:app/data/models/models.dart';
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
        final currentTab = context.watch<BrowserTabsBloc>().activeTab;
        final value = switch (currentTab?.state) {
          BrowserTabState.loading => (currentTab?.progress ?? 0.0) / 100.0,
          _ => null,
        };

        return value != null
            ? ProgressBar(
                value: value,
              )
            : const SizedBox();
      },
    );
  }
}
