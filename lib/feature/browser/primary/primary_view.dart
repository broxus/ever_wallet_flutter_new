import 'package:flutter/material.dart';

class PrimaryView extends StatefulWidget {
  const PrimaryView({super.key});

  @override
  State<PrimaryView> createState() => _PrimaryViewState();
}

class _PrimaryViewState extends State<PrimaryView> {
  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.pink,
      child: Center(
        child: Text('Primary'),
      ),
    );
  }
}
