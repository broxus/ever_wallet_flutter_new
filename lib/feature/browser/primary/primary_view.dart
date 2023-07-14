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
    return Column(
      children: [
        const Expanded(
          child: ColoredBox(
            color: Colors.pink,
            child: Center(
              child: Text('Primary'),
            ),
          ),
        ),
        BrowserBottomMenuCommon(
          onBackPressed: () => {},
          onForwardPressed: null,
          onAddTabPressed: null,
          onTabsPressed: null,
          onOverflowPressed: null,
        ),
      ],
    );
  }
}
