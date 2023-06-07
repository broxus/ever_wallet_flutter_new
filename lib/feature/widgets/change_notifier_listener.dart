import 'package:flutter/material.dart';

/// Widgets that listens for [ChangeNotifier] and builds subtree
class ChangeNotifierListener extends StatefulWidget {
  const ChangeNotifierListener({
    required this.changeNotifier,
    required this.builder,
    super.key,
  });

  final WidgetBuilder builder;
  final ChangeNotifier changeNotifier;

  @override
  State<ChangeNotifierListener> createState() => _ChangeNotifierListenerState();
}

class _ChangeNotifierListenerState extends State<ChangeNotifierListener> {
  @override
  void initState() {
    super.initState();
    widget.changeNotifier.addListener(_updater);
  }

  @override
  void dispose() {
    widget.changeNotifier.removeListener(_updater);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ChangeNotifierListener oldWidget) {
    if (oldWidget.changeNotifier != widget.changeNotifier) {
      oldWidget.changeNotifier.removeListener(_updater);
      widget.changeNotifier.addListener(_updater);
    }
    super.didUpdateWidget(oldWidget);
  }

  // ignore: no-empty-block
  void _updater() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
