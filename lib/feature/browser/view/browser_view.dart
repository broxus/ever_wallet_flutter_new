import 'package:flutter/material.dart';

class BrowserView extends StatefulWidget {
  const BrowserView({required this.child, super.key});

  final Widget child;

  @override
  State<BrowserView> createState() => _BrowserViewState();
}

class _BrowserViewState extends State<BrowserView> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
