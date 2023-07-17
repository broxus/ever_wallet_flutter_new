import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BrowserTabView extends StatefulWidget {
  const BrowserTabView({required this.onScroll, super.key});

  final void Function({
    required int currentY,
    required int gestureDY,
  })? onScroll;

  @override
  State<BrowserTabView> createState() => _BrowserTabViewState();
}

class _BrowserTabViewState extends State<BrowserTabView> {
  int? _lastScrollY;
  int? _scrollGestureYStart;
  int? _scrollGestureDY;
  Timer? _delayedScrollTimer;
  static const Duration _scrollTimerDelay = Duration(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      onOverScrolled: _onOverScrolled,
      onScrollChanged: _onScrollChanged,
      initialUrlRequest: URLRequest(
        url: Uri.parse('https://app.flatqube.io/swap'),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _delayedScrollTimer?.cancel();
  }

  void _onScrollChanged(InAppWebViewController controller, int x, int y) {
    _delayedScrollTimer = Timer(
      _scrollTimerDelay,
      () => _onScrollSane(y),
    );
  }

  void _onOverScrolled(
    InAppWebViewController controller,
    int x,
    int y,
    bool clampedX,
    bool clampedY,
  ) {
    if (clampedY) {
      _delayedScrollTimer?.cancel();
    }
  }

  void _onScrollSane(int y) {
    _calcScrollGesture(y);

    _lastScrollY = y;
    if (_scrollGestureDY != null) {
      widget.onScroll?.call(
        currentY: y,
        gestureDY: _scrollGestureDY!,
      );
    }
  }

  void _calcScrollGesture(int y) {
    if (_scrollGestureYStart == null) {
      _scrollGestureYStart = y;
      return;
    }

    if (_lastScrollY == null) {
      return;
    }

    _scrollGestureDY = y - _scrollGestureYStart!;
    final scrollDY = y - _lastScrollY!;

    // We moving in opposite directions that gesture started
    if (_scrollGestureDY!.sign * scrollDY.sign < 0) {
      _scrollGestureYStart = y;
      _scrollGestureDY = 0;
    }
  }
}
