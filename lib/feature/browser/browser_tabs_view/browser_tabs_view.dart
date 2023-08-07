import 'package:app/feature/browser/browser.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrowserTabsView extends StatefulWidget {
  const BrowserTabsView({
    super.key,
  });

  @override
  State<BrowserTabsView> createState() => _BrowserTabsViewState();
}

class _BrowserTabsViewState extends State<BrowserTabsView> {
  List<BrowserTabView> stackViews = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrowserTabsBloc, BrowserTabsState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        final currentTab = context.read<BrowserTabsBloc>().activeTab;
        final currentTabId = currentTab?.id;
        final tabs = context.read<BrowserTabsBloc>().state.tabs;
        final tabsState = context.read<BrowserTabsBloc>().state.tabsState;

        stackViews
          // replace changed
          ..forEachIndexed(
            (index, view) {
              final newTab = tabs.firstWhereOrNull(
                (tab) =>
                    view.tab.id == tab.id &&
                    (view.tab != tab || view.tabState != tabsState[tab.id]),
              );
              if (newTab == null) return;
              stackViews[index] = BrowserTabView(
                tab: newTab,
                tabState: tabsState[newTab.id] ?? const BrowserTabState(),
                key: ValueKey(newTab.id),
              );
            },
          )
          // remove views with non-existent tabs
          ..removeWhere(
            (view) => tabs.indexWhere((tab) => tab.id == view.tab.id) < 0,
          )
          // remove new views
          ..addAll(
            tabs
                .where(
                  (tab) =>
                      stackViews.indexWhere((view) => view.tab.id == tab.id) <
                      0,
                )
                .map(
                  (tab) => BrowserTabView(
                    tab: tab,
                    tabState: tabsState[tab.id] ?? const BrowserTabState(),
                    key: ValueKey(tab.id),
                  ),
                ),
          );

        final currentTabIndex =
            stackViews.indexWhere((view) => view.tab.id == currentTabId);

        return IndexedStack(
          index: currentTabIndex,
          children: stackViews,
        );
      },
    );
  }

  bool _buildWhen(BrowserTabsState previous, BrowserTabsState current) {
    final tabId = current.currentTabId;
    if (tabId == null) {
      return false;
    }

    if (tabId != previous.currentTabId) {
      return true;
    }

    final tab = current.tabs.firstWhereOrNull((t) => t.id == tabId);
    final previousTab = previous.tabs.firstWhereOrNull((t) => t.id == tabId);
    final tabState = current.tabsState[tabId];
    final previousTabState = previous.tabsState[tabId];

    if (tab?.url != previousTab?.url) {
      return true;
    }

    if (tabState?.state != previousTabState?.state) {
      return true;
    }

    return false;
  }
}
