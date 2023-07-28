import 'package:app/feature/browser/browser.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrowserTabsViewWidget extends StatefulWidget {
  const BrowserTabsViewWidget({
    super.key,
  });

  @override
  State<BrowserTabsViewWidget> createState() => _BrowserTabsViewState();
}

class _BrowserTabsViewState extends State<BrowserTabsViewWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrowserTabsBloc, BrowserTabsState>(
      buildWhen: _buildWhen,
      builder: (context, state) {
        final currentTab = context.read<BrowserTabsBloc>().activeTab;
        final currentTabId = currentTab?.id;
        final tabs = context.read<BrowserTabsBloc>().state.tabs;
        final currentTabIndex =
            tabs.indexWhere((tab) => tab.id == currentTabId);
        final currentStackIndex = currentTabIndex < 0 ? 0 : currentTabIndex + 1;

        final stackViews = [
          const Text(
            'empty',
          ),
          ...tabs.map(
            (tab) => BrowserTabView(
              tab: tab,
              key: ValueKey(tab.id),
            ),
          ),
        ];

        return IndexedStack(
          index: currentStackIndex,
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

    if (tab?.url != previous.tabs.firstWhereOrNull((t) => t.id == tabId)?.url) {
      return true;
    }

    return false;
  }
}
