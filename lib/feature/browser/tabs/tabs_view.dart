import 'dart:async';

import 'package:app/app/router/router.dart';
import 'package:app/event_bus/events/app_links/app_links_event.dart';
import 'package:app/event_bus/events/navigation/bottom_navigation_events.dart';
import 'package:app/event_bus/primary_bus.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/browser/tabs/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

// TODO(nesquikm): We should calculate this value based on the screen size
const _cardAspectRatio = 0.8;

class TabsView extends StatefulWidget {
  const TabsView({super.key});

  @override
  State<TabsView> createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> {
  StreamSubscription<BrowserAppLinkUriEvent>? _appLinksNavSubs;

  @override
  void initState() {
    _appLinksNavSubs =
        behaviorBus.on<BrowserAppLinkUriEvent>().listen(_listenAppLinks);
    super.initState();
  }

  @override
  void dispose() {
    _appLinksNavSubs?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [...context.watch<BrowserTabsBloc>().state.tabs]..sort(
        (a, b) => a.sortingOrder.compareTo(b.sortingOrder),
      );

    return Column(
      children: [
        Expanded(
          child: GridView.count(
            // ignore: no-magic-number
            padding: const EdgeInsets.only(
              top: DimensSizeV2.d24,
              bottom: DimensSizeV2.d16,
              left: DimensSizeV2.d16,
              right: DimensSizeV2.d16,
            ),
            crossAxisCount: 2,
            crossAxisSpacing: DimensSizeV2.d8,
            mainAxisSpacing: DimensSizeV2.d12,
            childAspectRatio: _cardAspectRatio,
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

  void _listenAppLinks(BrowserAppLinkUriEvent event) {
    context.read<BrowserTabsBloc>().add(
          BrowserTabsEvent.add(uri: event.uri),
        );
  }
}
