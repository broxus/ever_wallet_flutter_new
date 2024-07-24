import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/browser/browser_tabs_view/browser_start_page.dart';
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
        final showStartView = currentTab?.url.toString().isEmpty ?? true;
        final index = tabs.indexWhere((tab) => tab.id == currentTabId);

        final stackViews = tabs
            .map(
              (tab) => BrowserTabView(
                tab: tab,
                tabState: tabsState[tab.id] ?? const BrowserTabState(),
                active: tab.id == currentTabId,
                key: ValueKey(tab.id),
              ),
            )
            .toList();

        return Stack(
          children: [
            IndexedStack(
              index: index,
              children: stackViews,
            ),
            if (showStartView) const BrowserStartPage(),
          ],
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
