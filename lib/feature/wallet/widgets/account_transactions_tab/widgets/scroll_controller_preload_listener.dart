import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

const loadingZone = 100.0;

/// Widget that subscribes to [scrollController] and listens when it achieves
/// the end of list.
class ScrollControllerPreloadListener extends StatefulWidget {
  const ScrollControllerPreloadListener({
    required this.scrollController,
    required this.preloadAction,
    required this.child,
    super.key,
  });

  final ScrollController scrollController;
  final VoidCallback preloadAction;
  final Widget child;

  @override
  State<ScrollControllerPreloadListener> createState() =>
      _ScrollControllerPreloadListenerState();
}

class _ScrollControllerPreloadListenerState
    extends State<ScrollControllerPreloadListener> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;

  void _scrollListener() {
    if (!mounted) return;

    final isDown = widget.scrollController.position.userScrollDirection ==
        ScrollDirection.reverse;
    final pixels = widget.scrollController.position.pixels;
    final maxScrollExtent = widget.scrollController.position.maxScrollExtent;

    if (isDown && pixels > maxScrollExtent - loadingZone) {
      widget.preloadAction();
    }
  }
}
