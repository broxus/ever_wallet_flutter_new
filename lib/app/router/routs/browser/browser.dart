import 'package:app/app/router/page_transitions.dart';
import 'package:app/app/router/router.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

ShellRoute get browserRoute {
  return ShellRoute(
    pageBuilder: (context, state, child) =>
        browserSubscreensTransitionPageBuilder(
      context,
      state,
      BrowserPage(child: child),
    ),
    routes: <RouteBase>[
      primaryRoute,
      bookmarksRoute,
      historyRoute,
      tabsRoute,
      webviewRoute,
    ],
  );
}

/// Get route for browser primary page.
GoRoute get primaryRoute {
  return GoRoute(
    name: AppRoute.browser.name,
    path: AppRoute.browser.path,
    pageBuilder: (BuildContext context, GoRouterState state) =>
        browserSubscreensTransitionPageBuilder(
      context,
      state,
      const PrimaryPage(),
    ),
  );
}

/// Get route for browser primary page.
GoRoute get bookmarksRoute {
  return GoRoute(
    name: AppRoute.browserBookmarks.name,
    path: AppRoute.browserBookmarks.path,
    pageBuilder: (BuildContext context, GoRouterState state) =>
        browserSubscreensTransitionPageBuilder(
      context,
      state,
      const BookmarksPage(),
    ),
  );
}

/// Get route for browser history page.
GoRoute get historyRoute {
  return GoRoute(
    name: AppRoute.browserHistory.name,
    path: AppRoute.browserHistory.path,
    pageBuilder: (BuildContext context, GoRouterState state) =>
        browserSubscreensTransitionPageBuilder(
      context,
      state,
      const HistoryPage(),
    ),
  );
}

/// Get route for browser tabs page.
GoRoute get tabsRoute {
  return GoRoute(
    name: AppRoute.browserTabs.name,
    path: AppRoute.browserTabs.path,
    pageBuilder: (BuildContext context, GoRouterState state) =>
        browserSubscreensTransitionPageBuilder(
      context,
      state,
      const TabsPage(),
    ),
  );
}

/// Get route for browser tabs page.
GoRoute get webviewRoute {
  return GoRoute(
    name: AppRoute.browserWebview.name,
    path: AppRoute.browserWebview.path,
    pageBuilder: (BuildContext context, GoRouterState state) =>
        browserSubscreensTransitionPageBuilder(
      context,
      state,
      const WebviewPage(),
    ),
  );
}
