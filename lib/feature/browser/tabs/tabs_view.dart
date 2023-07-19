import 'package:app/feature/browser/browser.dart';
import 'package:flutter/material.dart';

class TabsView extends StatefulWidget {
  const TabsView({super.key});

  @override
  State<TabsView> createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          child: ColoredBox(
            color: Colors.amber,
            child: Center(
              child: Text('Tabs'),
            ),
          ),
        ),
        BrowserBottomMenuTabs(
          onCloseAllPressed: null,
          // ignore: no-empty-block
          onAddTabPressed: () {},
          // ignore: no-empty-block
          onDonePressed: () {},
        ),
      ],
    );
  }
}
