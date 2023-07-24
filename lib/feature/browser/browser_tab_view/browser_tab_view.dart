import 'dart:async';

import 'package:app/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

typedef BrowserOnScrollCallback = void Function({
  required int currentY,
  required int gestureDY,
});

typedef BrowserOnOverScrollCallback = void Function({
  required int y,
});

class BrowserTabView extends StatefulWidget {
  const BrowserTabView({
    required this.tab,
    required this.onScroll,
    required this.onOverScroll,
    super.key,
  });

  final BrowserTab tab;
  final BrowserOnScrollCallback? onScroll;
  final BrowserOnOverScrollCallback? onOverScroll;

  @override
  State<BrowserTabView> createState() => _BrowserTabViewState();
}

class _BrowserTabViewState extends State<BrowserTabView> {
  // Last SANE Y position (i.e. not overscrolled)
  int? _lastScrollY;
  // Position of gesture start: every direction change resets it
  int? _scrollGestureYStart;
  // Distance from gesture start to current position
  int? _scrollGestureDY;
  // Delayed scroll events are used to detect overscrolling
  final List<DelayedScrollEvent> _delayedScrollEvents = [];
  // How long to wait before considering scroll event as not overscroll
  static const Duration _scrollTimerDelay = Duration(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      onOverScrolled: _onOverScrolled,
      onScrollChanged: _onScrollChanged,
      initialUrlRequest: URLRequest(
        url: widget.tab.url,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    for (final event in _delayedScrollEvents) {
      event.timer.cancel();
    }
  }

  void _onScrollChanged(_, __, int y) {
    // Remove all events that are not active anymore (cancelled, executed)
    _delayedScrollEvents.removeWhere((event) => !event.timer.isActive);

    // New delayed scroll event, at this point we don't know if it's overscroll
    final event = DelayedScrollEvent(
      timer: Timer(
        _scrollTimerDelay,
        () => _onScrollSane(y),
      ),
      y: y,
    );
    // Add it to the list of delayed events
    _delayedScrollEvents.add(
      event,
    );
  }

  void _onOverScrolled(
    _,
    __,
    int y,
    ___,
    bool clampedY,
  ) {
    if (clampedY) {
      widget.onOverScroll?.call(y: y);

      // Hey, we are overscrolled!
      // Remove all that contains overscrolled y position
      // Hopefully it will be before any of timers will fire
      _delayedScrollEvents.removeWhere((event) {
        // Is this event overscrolled?
        if (event.y < y) return false;
        // Cancel timer
        event.timer.cancel();

        // Remove event from the list
        return true;
      });
    }
  }

  // Here we are sure that scroll event is not overscrolled
  void _onScrollSane(int y) {
    // Calculate scroll gesture
    _calcScrollGesture(y);

    _lastScrollY = y;
    // Call onScroll callback with current position and gesture dY
    if (_scrollGestureDY != null) {
      widget.onScroll?.call(
        currentY: y,
        gestureDY: _scrollGestureDY!,
      );
    }
  }

  // Calculate scroll gesture
  void _calcScrollGesture(int y) {
    // If we don't have start position, set it and return
    if (_scrollGestureYStart == null) {
      _scrollGestureYStart = y;

      return;
    }

    // If we don't have last position, return. We need it to calculate gesture
    // direction
    if (_lastScrollY == null) {
      return;
    }

    // Calculate gesture dY
    _scrollGestureDY = y - _scrollGestureYStart!;
    // Calculate scroll dY
    final scrollDY = y - _lastScrollY!;

    // If we moving in opposite directions that gesture started
    if (_scrollGestureDY!.sign * scrollDY.sign < 0) {
      // Reset gesture start position
      _scrollGestureYStart = y;
      // Reset gesture dY
      _scrollGestureDY = 0;
    }
  }
}

// Delayed scroll event dataclass
class DelayedScrollEvent {
  const DelayedScrollEvent({
    required this.timer,
    required this.y,
  });

  // Timer that will fire when scroll event is not overscrolled
  final Timer timer;
  // Scroll position
  final int y;
}
