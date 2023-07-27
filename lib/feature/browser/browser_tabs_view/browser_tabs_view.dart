import 'package:app/feature/browser/browser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BrowserTabsViewWidget extends StatefulWidget {
  const BrowserTabsViewWidget({
    this.onScroll,
    this.onOverScroll,
    this.onLoadStart,
    this.onLoadStop,
    this.onProgressChanged,
    this.onLoadError,
    super.key,
  });

  final BrowserOnScrollCallback? onScroll;
  final BrowserOnOverScrollCallback? onOverScroll;
  final BrowserOnNavigateCallback? onLoadStart;
  final BrowserOnNavigateCallback? onLoadStop;
  final BrowserOnProgressCallback? onProgressChanged;
  final BrowserOnErrorCallback? onLoadError;

  @override
  State<BrowserTabsViewWidget> createState() => _BrowserTabsViewState();
}

class _BrowserTabsViewState extends State<BrowserTabsViewWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrowserTabsBloc, BrowserTabsState>(
      buildWhen: (previous, current) {
        final tabId = current.currentTabId;
        if (tabId < 0) {
          return false;
        }

        if (tabId != previous.currentTabId) {
          return true;
        }

        final tab = current.tabs.elementAtOrNull(tabId);

        if (tab?.url != previous.tabs.elementAtOrNull(tabId)?.url) {
          return true;
        }

        return false;
      },
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
              onScroll: widget.onScroll,
              key: ValueKey(tab.id),
              onOverScroll: widget.onOverScroll,
              onLoadStart: widget.onLoadStart,
              onLoadStop: widget.onLoadStop,
              onProgressChanged: widget.onProgressChanged,
              onLoadError: widget.onLoadError,
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
}
