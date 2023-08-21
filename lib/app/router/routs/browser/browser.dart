import 'package:app/app/router/router.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:go_router/go_router.dart';

const browserUrlPathParam = 'url';
const browserTabIdPathParam = 'tabId';

/// Get branch for browser root.
StatefulShellBranch get browserBranch {
  return StatefulShellBranch(
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => BrowserPage(
          child: navigationShell,
        ),
        branches: [
          primaryBranch,
          tabsBranch,
        ],
      ),
    ],
  );
}

/// Get branch for browser primary page.
StatefulShellBranch get primaryBranch {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        name: AppRoute.browser.name,
        path: AppRoute.browser.path,
        builder: (context, state) => PrimaryPage(
          url: state.uri.queryParameters[browserUrlPathParam],
          tabId: state.uri.queryParameters[browserTabIdPathParam],
        ),
        routes: [
          historyRoute,
          bookmarksRoute,
        ],
      ),
    ],
  );
}

/// Get route for browser primary page.
GoRoute get bookmarksRoute {
  return GoRoute(
    name: AppRoute.browserBookmarks.name,
    path: AppRoute.browserBookmarks.path,
    builder: (context, state) => const BookmarksPage(),
  );
}

/// Get route for browser history page.
GoRoute get historyRoute {
  return GoRoute(
    name: AppRoute.browserHistory.name,
    path: AppRoute.browserHistory.path,
    builder: (_, __) => const HistoryPage(),
  );
}

/// Get branch for browser tabs page.
StatefulShellBranch get tabsBranch {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        name: AppRoute.browserTabs.name,
        path: AppRoute.browserTabs.path,
        builder: (context, state) => const TabsPage(),
      ),
    ],
  );
}
