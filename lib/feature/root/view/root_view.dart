import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/root/view/root_tab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class RootView extends StatefulWidget {
  const RootView({required this.child, super.key});
  final Widget child;

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  @override
  Widget build(BuildContext context) {
    final isBottomNavigationBarVisible =
        getCurrentAppRoute(GoRouterState.of(context).location)
            .isBottomNavigationBarVisible;

    return Scaffold(
      body: widget.child,
      extendBody: !isBottomNavigationBarVisible,
      bottomNavigationBar: AnimatedSlide(
        duration: defaultAnimationDuration,
        offset: Offset(0, isBottomNavigationBarVisible ? 0 : 1.0),
        child: BottomNavigationBar(
          items: _getItems(),
          currentIndex: _tabIndex(context),
          onTap: (int index) => _onTap(context, index),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _getItems() =>
      RootTab.values.map((tab) => tab.item).toList();

  void _onTap(BuildContext context, int value) {
    final tab = RootTab.values[value];
    context.goNamed(tab.name);
  }

  int _tabIndex(BuildContext _) {
    return RootTab.getByPath(
      getRootPath(inject<NavigationService>().location),
    ).index;
  }
}
