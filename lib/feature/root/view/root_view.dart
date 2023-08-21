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
    final colors = context.themeStyle.colors;
    final isBottomNavigationBarVisible =
        getCurrentAppRoute(GoRouterState.of(context).uri.toString())
            .isBottomNavigationBarVisible;

    return Scaffold(
      // We disable this isets, because this is a root Scaffold and we have
      // Scaffold -> Scaffold -> Content on a pages below, so if screen need
      // this insets, it can use resizeToAvoidBottomInset: true,
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (context) {
          return MediaQuery(
            // we need to directly remove bottom padding if bottom bar is not
            // visible, because scaffold do not remove this padding if BottomBar
            // exists in the tree (but we do not remove it, just hide).
            data: MediaQuery.of(context).removePadding(
              removeBottom: !isBottomNavigationBarVisible,
            ),
            child: widget.child,
          );
        },
      ),
      extendBody: !isBottomNavigationBarVisible,
      // IF WE HAVE PROBLEM with deleting MQ above, we need to replace Slide
      // widget to some ExpandablePanel, may be it will help.
      bottomNavigationBar: AnimatedSlide(
        duration: defaultAnimationDuration,
        offset: Offset(0, isBottomNavigationBarVisible ? 0 : 1.0),
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: colors.strokeSecondary,
                spreadRadius: DimensStroke.small,
              ),
            ],
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(DimensRadius.large),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: colors.backgroundSecondary,
            selectedItemColor: colors.blue,
            unselectedItemColor: colors.textSecondary,
            selectedLabelStyle: StyleRes.addBold,
            unselectedLabelStyle: StyleRes.addBold,
            items: _getItems(context),
            currentIndex: _tabIndex(context),
            onTap: (int index) => _onTap(context, index),
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _getItems(BuildContext context) =>
      RootTab.values.map((tab) => tab.item(context)).toList();

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
