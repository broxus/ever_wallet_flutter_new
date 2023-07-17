import 'package:app/app/router/router.dart';
import 'package:app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

enum RootTab {
  wallet('Wallet', AppRoute.wallet),
  browser('Browser', AppRoute.browser),
  profile('Profile', AppRoute.profile);

  const RootTab(this.title, this.route);

  final String title;
  final AppRoute route;

  String get icon => switch (this) {
        RootTab.wallet => Assets.images.wallet.path,
        RootTab.browser => Assets.images.navigation.path,
        RootTab.profile => Assets.images.person.path,
      };

  BottomNavigationBarItem item(BuildContext context) {
    final colors = context.themeStyle.colors;

    return BottomNavigationBarItem(
      icon: CommonIconWidget.svg(svg: icon, color: colors.textSecondary),
      activeIcon: CommonIconWidget.svg(svg: icon, color: colors.blue),
      label: title,
    );
  }

  static RootTab getByPath(String path) {
    // ignore: prefer-enums-by-name
    return RootTab.values.firstWhere(
      (e) => e.route.path == path,
      orElse: () {
        Logger('RootTabs').warning('No route found for path: $path');

        return wallet;
      },
    );
  }
}
