import 'package:flutter/material.dart';

class BrowserView extends StatelessWidget {
  const BrowserView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.green,
      child: Center(
        child: Text('Browser'),
      ),
    );
  }
}
