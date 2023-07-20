import 'package:app/app/router/router.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:go_router/go_router.dart';

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
          bookmarksBranch,
          historyBranch,
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
        builder: (context, state) => const PrimaryPage(),
      ),
    ],
  );
}

/// Get branch for browser primary page.
StatefulShellBranch get bookmarksBranch {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        name: AppRoute.browserBookmarks.name,
        path: AppRoute.browserBookmarks.path,
        builder: (context, state) => const BookmarksPage(),
      )
    ],
  );
}

/// Get branch for browser history page.
StatefulShellBranch get historyBranch {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        name: AppRoute.browserHistory.name,
        path: AppRoute.browserHistory.path,
        builder: (context, state) => const HistoryPage(),
      )
    ],
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
      )
    ],
  );
}
