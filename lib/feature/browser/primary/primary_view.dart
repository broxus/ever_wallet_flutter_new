import 'package:app/feature/browser/browser.dart';
import 'package:flutter/material.dart';

class PrimaryView extends StatefulWidget {
  const PrimaryView({super.key});

  @override
  State<PrimaryView> createState() => _PrimaryViewState();
}

class _PrimaryViewState extends State<PrimaryView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const IndexedStack(
          index: 0,
          children: [
            BrowserTabView(),
          ],
        ),
        Align(
          alignment: Alignment.topCenter,
          child: BrowserSearchBar(
            onSubmit: () => {},
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: BrowserBottomMenuCommon(
            onBackPressed: () => {},
            onForwardPressed: null,
            onAddTabPressed: null,
            onTabsPressed: null,
            onOverflowPressed: null,
          ),
        ),
      ],
    );
  }
}
