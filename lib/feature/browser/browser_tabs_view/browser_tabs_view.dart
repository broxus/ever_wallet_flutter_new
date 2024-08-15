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
        final currentTab = state.tabs.firstWhereOrNull(
          (t) => t.id == state.currentTabId,
        );
        final currentTabId = currentTab?.id;
        final showStartView = currentTab?.url.toString().isEmpty ?? true;
        final index = state.tabs.indexWhere((tab) => tab.id == currentTabId);

        final stackViews = state.tabs
            .map(
              (tab) => BrowserTabView(
                tab: tab,
                tabState: state.tabsState[tab.id] ?? const BrowserTabState(),
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
