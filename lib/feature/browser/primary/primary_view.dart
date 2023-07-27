import 'package:app/app/router/router.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/browser/primary/hud_bloc/hud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const _searchEngineUri = 'https://duckduckgo.com/?q=';

class PrimaryView extends StatefulWidget {
  const PrimaryView({super.key});

  @override
  State<PrimaryView> createState() => _PrimaryViewState();
}

class _PrimaryViewState extends State<PrimaryView>
    with SingleTickerProviderStateMixin {
  // Scroll position of the webview, used to hide the HUD when the user scrolls
  // further than a certain threshold.
  static const int _hudScrollMinYThreshold = 4;
  // Scroll dY of the webview, used to hide and show the HUD when the user
  // scrolls up and down.
  static const int _hudScrollDYThresholdDown = 64;
  static const int _hudScrollDYThresholdUp = 128;

  // Main animation controller of the HUD.
  late AnimationController _animationController;
  // Search bar animation
  late final Animation<Offset> _searchBarAnimation;
  // Bottom menu animation
  late final Animation<Offset> _bottomMenuAnimation;
  // Content (webview) animation
  late final Animation<RelativeRect> _contentAnimation;

  static const Curve _curve = Curves.easeOutCubic;

  static const _animationHalfValue = 0.5;

  // It's when the HUD is visible. It's true only when its FULLY visible beacuse
  // it's used to change the size of the content (webview), and we should
  // change it behind the HUD.
  bool _isHudVisible = true;

  @override
  void initState() {
    super.initState();

    // Init animations. It's a long list of animations, so we moved it to
    // separate method.
    _initAminations();

    // We can't use HudBloc here because we need to listen to the animation
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        // Animation start playing 1->0, i.e. HUD was visible, but became not
        // So, we should extend content below HUD to make it fill entire screen
        // befor HUD will be hidden
        if (_animationController.value > _animationHalfValue) {
          setState(() {
            _isHudVisible = false;
          });
        }
      }
      // Animation is completed, so we can change HUD visibility according to
      // animation value
      if (status == AnimationStatus.completed) {
        setState(() {
          _isHudVisible = _animationController.value > _animationHalfValue;
        });
      }
    });
  }

  void _initAminations() {
    _animationController = AnimationController(
      value: 1,
      vsync: this,
      duration: defaultAnimationDuration,
    );

    _searchBarAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: _curve,
      ),
    );

    _bottomMenuAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: _curve,
      ),
    );

    _contentAnimation = RelativeRectTween(
      begin: RelativeRect.fill,
      // Yeah, we don't change height of the content!
      // We just move it up and down
      end: const RelativeRect.fromLTRB(
        0,
        BrowserSearchBar.height,
        0,
        -BrowserSearchBar.height,
      ),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: _curve,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // We use only listener (without builder) because we don't need to rebuild
    // the entire widget tree when HUD visibility changes
    return BlocListener<HudBloc, HudState>(
      listener: (context, state) {
        // Just animate HUD visibility according to the bloc state
        _animationController.animateTo(
          state.when(
            visible: () => 1.0,
            invisible: () => 0.0,
          ),
        );
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          // There are 3 layers:
          return Stack(
            children: [
              // 1. Content (webview)
              // It should be below HUD when HUD is visible, and fill entire
              // screen when HUD is not visible
              // We don't animate height of the content because it's a webview

              // But animate content position to follow search
              // bar animation
              PositionedTransition(
                rect: _contentAnimation,
                child: Stack(
                  children: [
                    Positioned.fill(
                      bottom: _isHudVisible
                          ? BrowserSearchBar.height +
                              BrowserBottomMenuCommon.height
                          : 0,
                      child: child!,
                    ),
                  ],
                ),
              ),
              // 2. HUD: search bar
              Align(
                alignment: Alignment.topCenter,
                child: SlideTransition(
                  position: _searchBarAnimation,
                  child: BrowserSearchBar(
                    onSubmitted: _onSearchSubmitted,
                  ),
                ),
              ),
              // 3. HUD: bottom menu
              Align(
                alignment: Alignment.bottomCenter,
                child: SlideTransition(
                  position: _bottomMenuAnimation,
                  child: BrowserBottomMenuCommon(
                    onBackPressed: () => {},
                    onForwardPressed: null,
                    onAddTabPressed: null,
                    onTabsPressed: _onTabsPressed,
                    onOverflowPressed: null,
                  ),
                ),
              ),
            ],
          );
        },
        // We use child to prevent webview from rebuilding when HUD
        child: BrowserTabsViewWidget(
          onScroll: _onScroll,
          onOverScroll: _onOverScroll,
          onLoadStart: _onLoadStart,
          onLoadStop: _onLoadStop,
          onProgressChanged: _onProgressChanged,
          onLoadError: _onLoadError,
        ),
      ),
    );
  }

  void _onSearchSubmitted(String? text) {
    if (text == null) {
      return;
    }

    var uri = Uri.parse(text);
    if (!uri.hasScheme) {
      uri = Uri.parse('$_searchEngineUri$text');
    }

    final browserTabsBloc = context.read<BrowserTabsBloc>();
    final activeTab = browserTabsBloc.activeTab;
    browserTabsBloc.add(
      activeTab != null
          ? BrowserTabsEvent.setUrl(id: activeTab.id, uri: uri)
          : BrowserTabsEvent.add(uri: uri),
    );
  }

  void _onTabsPressed() {
    context.goNamed(AppRoute.browserTabs.name);
  }

  void _onScroll({required int currentY, required int gestureDY}) {
    if (currentY < _hudScrollMinYThreshold) {
      // If we are at the top of the page, we should show HUD
      context.read<HudBloc>().add(const HudEvent.show());
    } else {
      // Elsewise, we should show and  hide HUD according to gesture direction.
      // Here we check if gesture is long enough to hide or show HUD
      if (gestureDY > 0 && gestureDY.abs() > _hudScrollDYThresholdDown) {
        // If gesture is down, we should hide HUD
        context.read<HudBloc>().add(const HudEvent.hide());
      } else if (gestureDY < 0 && gestureDY.abs() > _hudScrollDYThresholdUp) {
        // If gesture is up, we should show HUD
        context.read<HudBloc>().add(const HudEvent.show());
      }
    }
  }

  void _onOverScroll({required int y}) {
    if (y > 0) {
      context.read<HudBloc>().add(const HudEvent.hide());
    }
  }

  void _onLoadStart({required String id, required Uri? url}) {
    _setUrl(id, url);
    _setState(id, BrowserTabState.loading);
  }

  void _onLoadStop({required String id, required Uri? url}) {
    _setUrl(id, url);
    _setState(id, BrowserTabState.loaded);
  }

  void _onProgressChanged({required String id, required int progress}) {
    context.read<BrowserTabsBloc>().add(
          BrowserTabsEvent.setProgress(
            id: id,
            progress: progress,
          ),
        );
  }

  void _onLoadError({
    required String id,
    // ignore: avoid-unused-parameters
    required int code,
    // ignore: avoid-unused-parameters
    required String message,
    // ignore: avoid-unused-parameters
    required Uri? url,
  }) {
    context.read<BrowserTabsBloc>().add(
          BrowserTabsEvent.setState(
            id: id,
            state: BrowserTabState.error,
          ),
        );
  }

  void _setUrl(String id, Uri? url) {
    final browserTabsBloc = context.read<BrowserTabsBloc>();
    if (url != null) {
      browserTabsBloc.add(BrowserTabsEvent.setUrl(id: id, uri: url));
    }
  }

  void _setState(String id, BrowserTabState state) {
    context.read<BrowserTabsBloc>().add(
          BrowserTabsEvent.setState(
            id: id,
            state: state,
          ),
        );
  }
}
