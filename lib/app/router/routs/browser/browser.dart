import 'package:app/app/router/page_transitions.dart';
import 'package:app/app/router/router.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Route that is root for browser.
GoRoute get browserRoute {
  return GoRoute(
    name: AppRoute.browser.name,
    path: AppRoute.browser.path,
    pageBuilder: (BuildContext context, GoRouterState state) =>
        rootTabsTransitionPageBuilder(
      context,
      state,
      const BrowserPage(),
    ),
  );
}
