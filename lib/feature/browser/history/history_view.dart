import 'package:flutter/material.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.lightGreen,
      child: Center(
        child: Text('History'),
      ),
    );
  }
}
