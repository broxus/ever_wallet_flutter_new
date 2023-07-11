import 'package:flutter/material.dart';

class WebviewView extends StatefulWidget {
  const WebviewView({super.key});

  @override
  State<WebviewView> createState() => _WebviewViewState();
}

class _WebviewViewState extends State<WebviewView> {
  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.deepPurple,
      child: Center(
        child: Text('Webview'),
      ),
    );
  }
}
