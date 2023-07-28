import 'package:app/app/router/router.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
    final onCloseAllPressed = tabs.isNotEmpty ? _onCloseAllPressed : null;

    return Column(
      children: [
        Expanded(
          child: ColoredBox(
            color: Colors.amber,
            child: ListView(
              children: [
                for (final tab in tabs)
                  ListTile(
                    title: Text(tab.url.toString()),
                    subtitle: Text('${tab.sortingOrder} ${tab.id}'),
                    onTap: () {
                      context.read<BrowserTabsBloc>().add(
                            BrowserTabsEvent.setActive(id: tab.id),
                          );
                      context.goNamed(AppRoute.browser.name);
                    },
                  ),
              ],
            ),
          ),
        ),
        BrowserBottomMenuTabs(
          onCloseAllPressed: onCloseAllPressed,
          onAddTabPressed: _onAddTabPressed,
          onDonePressed: _onDonePressed,
        ),
      ],
    );
  }

  void _onCloseAllPressed() {
    context.read<BrowserTabsBloc>().add(
          const BrowserTabsEvent.closeAll(),
        );
    context.goNamed(AppRoute.browser.name);
  }

  void _onAddTabPressed() {
    context.read<BrowserTabsBloc>().add(
          const BrowserTabsEvent.addEmpty(),
        );
    context.goNamed(AppRoute.browser.name);
  }

  void _onDonePressed() {
    context.goNamed(AppRoute.browser.name);
  }
}
