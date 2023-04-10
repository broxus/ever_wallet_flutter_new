import 'package:app/app/router/app_route.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

enum RootTab {
  wallet('Wallet', Icons.account_balance_wallet, AppRoute.wallet),
  browser('Browser', Icons.web, AppRoute.browser),
  profile('Profile', Icons.person, AppRoute.profile);

  const RootTab(this.title, this.icon, this.route);

  final String title;
  final IconData icon;
  final AppRoute route;

  BottomNavigationBarItem get item => BottomNavigationBarItem(
        icon: Icon(icon),
        label: title,
      );

  static RootTab getByPath(String path) {
    return RootTab.values.firstWhere(
      (e) => e.route.path == path,
      orElse: () {
        Logger('RootTabs').warning('No route found for path: $path');
        return wallet;
      },
    );
  }
}
