import 'package:flutter/material.dart';

class TabsView extends StatefulWidget {
  const TabsView({super.key});

  @override
  State<TabsView> createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> {
  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.amber,
      child: Center(
        child: Text('Tabs'),
      ),
    );
  }
}
