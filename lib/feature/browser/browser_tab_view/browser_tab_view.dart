import 'dart:async';
import 'dart:io';

import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logging/logging.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:uuid/uuid.dart';

// Scroll position of the webview, used to hide the HUD when the user scrolls
// further than a certain threshold.
const int _hudScrollMinYThreshold = 4;
// Scroll dY of the webview, used to hide and show the HUD when the user
// scrolls up and down.
const int _hudScrollDYThresholdDown = 64;
const int _hudScrollDYThresholdUp = 128;

const Duration _screenShotTimerDuration = Duration(seconds: 5);
final ScreenshotConfiguration _screenshotConfiguration =
    ScreenshotConfiguration(
  compressFormat: CompressFormat.JPEG,
  // ignore: no-magic-number
  quality: 70,
  // ignore: no-magic-number
  snapshotWidth: 160,
);

class BrowserTabView extends StatefulWidget {
  const BrowserTabView({
    required this.tab,
    super.key,
  });

  final BrowserTab tab;

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

  InAppWebViewController? _webViewController;
  PullToRefreshController? _pullToRefreshController;

  Timer? _screenshotTimer;

  final _initialOptions = InAppWebViewGroupOptions(
    ios: IOSInAppWebViewOptions(),
    android: AndroidInAppWebViewOptions(),
    crossPlatform: InAppWebViewOptions(),
  );

  static final _log = Logger('BrowserTabView');

  @override
  void initState() {
    super.initState();

    _setBrowserTabCallbacks();
  }

  @override
  void didUpdateWidget(BrowserTabView oldWidget) {
    super.didUpdateWidget(oldWidget);

    _handleUrlChanged(widget.tab, oldWidget.tab);
    _handleTabChanged(widget.tab, oldWidget.tab);
  }

  Future<void> _handleUrlChanged(BrowserTab newTab, BrowserTab oldTab) async {
    final url = await _webViewController?.getUrl();

    // Reload the webview if the tab URL changed and the new URL is not the same
    // as the current URL.
    if (newTab.url != oldTab.url && url != newTab.url) {
      await _webViewController?.loadUrl(
        urlRequest: URLRequest(
          url: newTab.url,
        ),
      );
    }
  }

  Future<void> _handleTabChanged(BrowserTab newTab, BrowserTab oldTab) async {
    // Show HUD if the tab changed.
    if (newTab.id != oldTab.id) {
      context.read<HudBloc>().add(const HudEvent.show());
    }
  }

  @override
  Widget build(BuildContext context) {
    _initPTRController();

    return InAppWebView(
      key: ValueKey(widget.tab.id),
      pullToRefreshController: _pullToRefreshController,
      initialOptions: _initialOptions,
      onOverScrolled: _onOverScrolled,
      onScrollChanged: _onScrollChanged,
      onWebViewCreated: _onWebViewCreated,
      onLoadStart: _onLoadStart,
      onLoadStop: _onLoadStop,
      onProgressChanged: _onProgressChanged,
      onLoadError: _onLoadError,
    );
  }

  @override
  void dispose() {
    for (final event in _delayedScrollEvents) {
      event.timer.cancel();
    }

    _screenshotTimer?.cancel();

    super.dispose();
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

    if (y == 0) {
      context.read<HudBloc>().add(const HudEvent.show());
    }
  }

  void _onOverScrolled(
    _,
    __,
    int y,
    ___,
    bool clampedY,
  ) {
    if (clampedY) {
      // If we are overscrolled down hide HUD
      if (y > 0) {
        context.read<HudBloc>().add(const HudEvent.hide());
      }

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
      if (y < _hudScrollMinYThreshold) {
        // If we are at the top of the page, we should show HUD
        context.read<HudBloc>().add(const HudEvent.show());
      } else {
        // Elsewise, we should show and  hide HUD according to gesture direction
        // Here we check if gesture is long enough to hide or show HUD
        if (_scrollGestureDY! > 0 &&
            _scrollGestureDY!.abs() > _hudScrollDYThresholdDown) {
          // If gesture is down, we should hide HUD
          context.read<HudBloc>().add(const HudEvent.hide());
        } else if (_scrollGestureDY! < 0 &&
            _scrollGestureDY!.abs() > _hudScrollDYThresholdUp) {
          // If gesture is up, we should show HUD
          context.read<HudBloc>().add(const HudEvent.show());
        }
      }
    }

    _saveScreenshot();
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

  void _onWebViewCreated(InAppWebViewController controller) {
    _webViewController = controller;
    if (widget.tab.url.toString().isNotEmpty) {
      controller.loadUrl(urlRequest: URLRequest(url: widget.tab.url));
    }
  }

  void _onLoadStart(
    _,
    Uri? url,
  ) {
    _setUrl(url);
    _setState(state: BrowserTabStateType.loading);
  }

  void _onLoadStop(
    _,
    Uri? url,
  ) {
    _pullToRefreshController?.endRefreshing();
    _setUrl(url);
    _setState(state: BrowserTabStateType.loaded);
    _saveScreenshot(force: true);
  }

  void _onProgressChanged(
    _,
    int progress,
  ) {
    // Seems very strange, but they do it in example ¯\_(ツ)_/¯
    // ignore: no-magic-number
    if (progress == 100) {
      _pullToRefreshController?.endRefreshing();
    }

    _setState(progress: progress);
    _saveScreenshot();
  }

  void _onLoadError(
    _,
    Uri? url,
    int code,
    String message,
  ) {
    _pullToRefreshController?.endRefreshing();
    _log.warning(
      'Failed to load $url: $code $message',
    );
    _setState(state: BrowserTabStateType.error);
  }

  void _onRefresh() {
    _webViewController?.reload();
  }

  void _onGoBack() {
    _webViewController?.goBack();
  }

  void _onGoForward() {
    _webViewController?.goForward();
  }

  void _initPTRController() {
    final colors = context.themeStyle.colors;
    _pullToRefreshController = _pullToRefreshController ??
        PullToRefreshController(
          options: PullToRefreshOptions(
            color: colors.textSecondary,
          ),
          onRefresh: _onRefresh,
        );
  }

  void _setUrl(Uri? url) {
    final browserTabsBloc = context.read<BrowserTabsBloc>();
    if (url != null) {
      browserTabsBloc.add(BrowserTabsEvent.setUrl(id: widget.tab.id, uri: url));
    }
  }

  Future<void> _setState({
    BrowserTabStateType? state,
    int? progress,
  }) async {
    final canGoBack = await _webViewController?.canGoBack() ?? false;
    final canGoForward = await _webViewController?.canGoForward() ?? false;

    _addSetStateEvent(
      state: state,
      canGoBack: canGoBack,
      canGoForward: canGoForward,
      progress: progress,
    );
  }

  // Should be sync because context calls are not allowed in async callbacks
  void _addSetStateEvent({
    BrowserTabStateType? state,
    bool? canGoBack,
    bool? canGoForward,
    int? progress,
  }) {
    context.read<BrowserTabsBloc>().add(
          BrowserTabsEvent.setState(
            id: widget.tab.id,
            state: state,
            canGoBack: canGoBack,
            canGoForward: canGoForward,
            progress: progress,
          ),
        );
  }

  // Should be sync because context calls are not allowed in async callbacks
  void _addSetScreenshotEvent({
    required String imagePath,
  }) {
    context.read<BrowserTabsBloc>().add(
          BrowserTabsEvent.setScreenshot(
            id: widget.tab.id,
            imagePath: imagePath,
          ),
        );
  }

  void _setBrowserTabCallbacks() {
    context.read<BrowserTabsBloc>().add(
          BrowserTabsEvent.setState(
            id: widget.tab.id,
            goBack: _onGoBack,
            goForward: _onGoForward,
            refresh: _onRefresh,
          ),
        );
  }

  Future<void> _saveScreenshot({bool force = false}) async {
    if ((_screenshotTimer?.isActive ?? false) && !force) {
      return;
    }

    _screenshotTimer?.cancel();
    _screenshotTimer = Timer(
      force ? Duration.zero : _screenShotTimerDuration,
      () async {
        final image = await _webViewController?.takeScreenshot(
          screenshotConfiguration: _screenshotConfiguration,
        );
        if (image == null) {
          _log.warning('Failed to take screenshot');
          return;
        }

        final imageDirectoryPath = await widget.tab.imageDirectoryPath;

        try {
          await Directory(imageDirectoryPath).delete(recursive: true);
        } catch (_) {}

        try {
          await Directory(imageDirectoryPath).create(recursive: true);
        } catch (_) {}

        final imagePath = '$imageDirectoryPath/${const Uuid().v4()}.jpg';
        final file = File(imagePath);
        await file.writeAsBytes(image);
        _addSetScreenshotEvent(imagePath: imagePath);
      },
    );
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
