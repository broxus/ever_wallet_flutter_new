import 'package:app/app/router/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserView extends StatefulWidget {
  const BrowserView({required this.child, super.key});

  final Widget child;

  @override
  State<BrowserView> createState() => _BrowserViewState();
}

class _BrowserViewState extends State<BrowserView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: widget.child),
        ColoredBox(
          color: Colors.green,
          child: Row(
            children: [
              CommonButton(
                text: 'pr',
                onPressed: () => context.goNamed(AppRoute.browser.name),
              ),
              CommonButton(
                text: 'bk',
                onPressed: () =>
                    context.goNamed(AppRoute.browserBookmarks.name),
              ),
              CommonButton(
                text: 'hi',
                onPressed: () => context.goNamed(AppRoute.browserHistory.name),
              ),
              CommonButton(
                text: 'tb',
                onPressed: () => context.goNamed(AppRoute.browserTabs.name),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
