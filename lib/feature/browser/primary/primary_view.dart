import 'dart:async';

import 'package:app/app/service/app_links/app_links_data.dart';
import 'package:app/app/service/app_links/app_links_service.dart';
import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const _searchEngineUri = 'https://duckduckgo.com/?q=';

class PrimaryView extends StatefulWidget {
  const PrimaryView({super.key});

  @override
  State<PrimaryView> createState() => _PrimaryViewState();
}

class _PrimaryViewState extends State<PrimaryView>
    with SingleTickerProviderStateMixin {
  final _appLinksService = inject<AppLinksService>();

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

  StreamSubscription<BrowserAppLinksData>? _appLinksNavSubs;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _appLinksNavSubs =
          _appLinksService.browserLinksStream.listen(_listenAppLinks);
    });

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

  @override
  void dispose() {
    _appLinksNavSubs?.cancel();
    _animationController.dispose();
    super.dispose();
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
                    const BrowserProgressBar(),
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
                    onChanged: _onSearchChanged,
                  ),
                ),
              ),
              // 3. HUD: bottom menu
              Align(
                alignment: Alignment.bottomCenter,
                child: SlideTransition(
                  position: _bottomMenuAnimation,
                  child: const BrowserBottomMenuCommon(),
                ),
              ),
            ],
          );
        },
        // We use child to prevent webview from rebuilding when HUD
        child: const BrowserTabsView(),
      ),
    );
  }

  Future<void> _onSearchSubmitted(String? text) async {
    if (text == null) {
      return;
    }

    final browserTabsBloc = context.read<BrowserTabsBloc>();

    var (uri, isSchemeFound) = _getUri(text);
    if (!isSchemeFound) {
      final isResolvable = await inject<DnsResolveService>().isResolvable(uri);
      if (!isResolvable) {
        uri = Uri.parse('$_searchEngineUri$text');
      }
    }

    final activeTab = browserTabsBloc.activeTab;
    browserTabsBloc.add(
      activeTab != null
          ? BrowserTabsEvent.setUrl(id: activeTab.id, uri: uri)
          : BrowserTabsEvent.add(uri: uri),
    );
  }

  Future<void> _onSearchChanged(String? text) async {
    if (text == null) {
      return;
    }

    final uri = _getUri(text).$1;
    // Just try to resolve host and cache the result
    unawaited(inject<DnsResolveService>().isResolvable(uri));

    context
        .read<BrowserTabsBloc>()
        .add(BrowserTabsEvent.setSearchText(text: text));
  }

  (Uri, bool) _getUri(String text) {
    final uri = Uri.parse(text);
    if (uri.hasScheme) {
      return (uri, true);
    }

    return (Uri.parse('https://$text'), false);
  }

  void _listenAppLinks(BrowserAppLinksData event) {
    context.read<BrowserTabsBloc>().add(
          BrowserTabsEvent.add(uri: event.url),
        );
  }
}
