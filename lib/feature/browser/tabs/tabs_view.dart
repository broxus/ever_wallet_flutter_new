import 'package:app/app/router/router.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/browser/tabs/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class TabsView extends StatefulWidget {
  const TabsView({super.key});

  @override
  State<TabsView> createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> {
  @override
  Widget build(BuildContext context) {
    final tabs = [...context.watch<BrowserTabsBloc>().state.tabs]..sort(
        (a, b) => a.sortingOrder.compareTo(b.sortingOrder),
      );
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: DimensSize.d16),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: DimensSize.d8,
              mainAxisSpacing: DimensSize.d12,
              childAspectRatio: 0.8,
              children: [
                for (final tab in tabs)
                  TabView(
                    tab: tab,
                    key: ValueKey(tab.id),
                    onPressed: () => _onChangeTab(tab.id),
                    onClosePressed: () => _onCloseTab(tab.id, tabs.length == 1),
                  ),
              ],
            ),
          ),
        ),
        const BrowserBottomMenuTabs(),
      ],
    );
  }

  void _onChangeTab(String id) {
    context.read<BrowserTabsBloc>().add(
          BrowserTabsEvent.setActive(id: id),
        );
    context.goNamed(AppRoute.browser.name);
  }

  void _onCloseTab(String id, bool wasLast) {
    context.read<BrowserTabsBloc>().add(
          BrowserTabsEvent.remove(id: id),
        );
    if (wasLast) {
      context.goNamed(AppRoute.browser.name);
    }
  }
}
