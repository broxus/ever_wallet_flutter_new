import 'package:app/feature/root/view/root_view.dart';
import 'package:flutter/material.dart';

class RootPage extends StatelessWidget {
  const RootPage({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RootView(child: child);
  }
}
