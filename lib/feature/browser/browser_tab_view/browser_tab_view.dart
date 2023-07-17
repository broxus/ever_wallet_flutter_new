import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BrowserTabView extends StatefulWidget {
  const BrowserTabView({super.key});

  @override
  State<BrowserTabView> createState() => _BrowserTabViewState();
}

class _BrowserTabViewState extends State<BrowserTabView> {
  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      onWebViewCreated: (InAppWebViewController controller) async {
        await controller.loadUrl(
          urlRequest: URLRequest(
            url: Uri.parse('https://app.flatqube.io/swap'),
          ),
        );
      },
    );
  }
}
