import 'package:app/app/router/router.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

enum RootTab {
  wallet(AppRoute.wallet),
  browser(AppRoute.browser),
  profile(AppRoute.profile);

  const RootTab(this.route);

  final AppRoute route;

  IconData get icon => switch (this) {
        RootTab.wallet => LucideIcons.wallet,
        RootTab.browser => LucideIcons.compass,
        RootTab.profile => LucideIcons.box,
      };

  String get title => switch (this) {
        RootTab.wallet => LocaleKeys.walletWord.tr(),
        RootTab.browser => LocaleKeys.browserWord.tr(),
        RootTab.profile => LocaleKeys.profileWord.tr(),
      };

  BottomNavigationBarItem item() => BottomNavigationBarItem(
        icon: Icon(icon, size: DimensSizeV2.d24),
        label: title,
        tooltip: title,
      );

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
