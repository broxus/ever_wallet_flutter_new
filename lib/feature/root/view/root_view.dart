import 'package:app/app/router/router.dart';
import 'package:app/app/service/navigation_service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/root/view/root_tab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootView extends StatelessWidget {
  const RootView({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: _getItems(),
        currentIndex: _tabIndex(context),
        onTap: (int index) => _onTap(context, index),
      ),
    );
  }

  List<BottomNavigationBarItem> _getItems() =>
      RootTab.values.map((tab) => tab.item).toList();

  void _onTap(BuildContext context, int value) {
    final tab = RootTab.values[value];
    context.goNamed(tab.name);
  }

  int _tabIndex(BuildContext context) {
    return RootTab.getByPath(
      getRootPath(inject<NavigationService>().location),
    ).index;
  }
}
