import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/browser/primary/hud_bloc/hud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class PrimaryView extends StatefulWidget {
  const PrimaryView({super.key});

  @override
  State<PrimaryView> createState() => _PrimaryViewState();
}

class _PrimaryViewState extends State<PrimaryView>
    with SingleTickerProviderStateMixin {
  static const int _hudScrollMinYThreshold = 64;
  static const int _hudScrollDYThreshold = 64;

  late AnimationController _animationController;
  late final Animation<Offset> _searchBarAnimation;
  late final Animation<Offset> _bottomMenuAnimation;
  late final Animation<RelativeRect> _contentAnimation;

  bool _isHudVisible = true;

  @override
  void initState() {
    super.initState();
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
        curve: Curves.easeOutCubic,
      ),
    );

    _bottomMenuAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _contentAnimation = RelativeRectTween(
      begin: RelativeRect.fill,
      end: const RelativeRect.fromLTRB(
        0,
        BrowserSearchBar.height,
        0,
        -BrowserSearchBar.height,
      ),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        if (_animationController.value > 0.5) {
          setState(() {
            _isHudVisible = false;
          });
        }
      }
      if (status == AnimationStatus.completed) {
        setState(() {
          _isHudVisible = _animationController.value > 0.5;
        });
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HudBloc, HudState>(
      listener: (context, state) {
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
          return Stack(
            children: [
              Positioned.fill(
                bottom: _isHudVisible ? BrowserBottomMenuCommon.height : 0,
                child: Stack(
                  children: [
                    PositionedTransition(
                      rect: _contentAnimation,
                      child: child!,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SlideTransition(
                  position: _searchBarAnimation,
                  child: BrowserSearchBar(
                    onSubmit: () => {},
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SlideTransition(
                  position: _bottomMenuAnimation,
                  child: BrowserBottomMenuCommon(
                    onBackPressed: () => {},
                    onForwardPressed: null,
                    onAddTabPressed: null,
                    onTabsPressed: null,
                    onOverflowPressed: null,
                  ),
                ),
              ),
            ],
          );
        },
        child: IndexedStack(
          index: 0,
          children: [
            BrowserTabView(onScroll: _onScroll),
          ],
        ),
      ),
    );
  }

  void _onScroll({required int currentY, required int gestureDY}) {
    if (currentY < _hudScrollMinYThreshold) {
      context.read<HudBloc>().add(const HudEvent.show());
    } else {
      if (gestureDY.abs() > _hudScrollDYThreshold) {
        if (gestureDY > 0) {
          context.read<HudBloc>().add(const HudEvent.hide());
        } else {
          context.read<HudBloc>().add(const HudEvent.show());
        }
      }
    }
  }
}
