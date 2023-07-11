import 'package:app/feature/browser/view/browser_view.dart';
import 'package:flutter/material.dart';

class BrowserPage extends StatelessWidget {
  const BrowserPage({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BrowserView(child: child);
  }
}
