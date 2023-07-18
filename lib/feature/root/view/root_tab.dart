import 'package:app/app/router/router.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

enum RootTab {
  wallet(AppRoute.wallet),
  browser(AppRoute.browser),
  profile(AppRoute.profile);

  const RootTab(this.route);

  final AppRoute route;

  String get icon => switch (this) {
        RootTab.wallet => Assets.images.wallet.path,
        RootTab.browser => Assets.images.navigation.path,
        RootTab.profile => Assets.images.person.path,
      };

  String get title => switch (this) {
        RootTab.wallet => LocaleKeys.walletWord.tr(),
        RootTab.browser => LocaleKeys.browserWord.tr(),
        RootTab.profile => LocaleKeys.profileWord.tr(),
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
