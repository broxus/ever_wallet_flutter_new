import 'package:app/feature/add_seed/enter_seed_name/enter_seed_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

const publicKeyPathParam = 'publicKey';

enum AppRoute {
  onboarding(
    'onboarding',
    '/onboarding',
    isSaveLocation: true,
  ),
  wallet(
    'wallet',
    '/wallet',
    isSaveLocation: true,
    isBottomNavigationBarVisible: true,
  ),
  browser(
    'browser',
    '/browser',
    isSaveLocation: true,
    isBottomNavigationBarVisible: true,
  ),

  /// Profile section
  profile(
    'profile',
    '/profile',
    isSaveLocation: true,
    isBottomNavigationBarVisible: true,
  ),
  manageSeedsAccounts(
    'manageSeeds',
    'manageSeeds',
    isSaveLocation: true,
  ),
  seedDetail(
    'seedDetail',
    'seedDetail/:$publicKeyPathParam',
    isSaveLocation: true,
  ),

  /// Adding seed
  createSeed(
    '',
    'createSeed',
    isSaveLocation: true,
  ),
  createSeedNamed(
    '',
    'createSeed/:$enterSeedNameName',
    isSaveLocation: true,
  ),
  enterSeed(
    '',
    'enterSeed',
    isSaveLocation: true,
  ),
  enterSeedNamed(
    '',
    'enterSeed/:name',
    isSaveLocation: true,
  ),

  // command flag means: 'import' - import, 'create' (or other) - create,
  // see <enterSeedNameImportCommand> and <enterSeedNameCreateCommand>.
  enterSeedName(
    '',
    'enterSeedName/:$enterSeedNameCommand',
    isSaveLocation: true,
  ),
  checkSeed(
    '',
    'checkSeed',
  ),
  createSeedPassword(
    '',
    'createSeedPassword',
  ),
  enableBiometryAfterOnboarding(
    '',
    'enableBiometryAfterOnboarding',
  );

  const AppRoute(
    this.name,
    this.path, {
    this.isSaveLocation = false,
    this.isBottomNavigationBarVisible = false,
  });

  static final _log = Logger('AppRoute');

  final String name;
  final String path;

  /// If location is saved in NavigationService.
  final bool isSaveLocation;

  /// Should BottomNavigationBar be visible.
  final bool isBottomNavigationBarVisible;

  static AppRoute getByPath(String path) {
    // ignore: prefer-enums-by-name
    return AppRoute.values.firstWhere(
      (e) => e.path == path,
      orElse: () => defaultRoute,
    );
  }

  static AppRoute get defaultRoute => onboarding;

  /// Helper method, that allows add path parameter to [path].
  ///
  /// If [path] field of [AppRoute] contains [':'] then [data] will replace this
  /// parameter.
  // TODO(alex-a4): we need check if this will work in a nested routes with data
  //   I mean, if routes above this will contains :data in their path or it was
  //   replace by them when they were pushed.
  String pathWithData(String data) {
    if (path.contains(':')) {
      return path.replaceAll(RegExp(r':\w*'), data);
    }

    return path;
  }

  /// Helper method, that allows add query parameters to [path].
  String pathWithQuery(Map<String, String>? query) {
    return Uri(path: path, queryParameters: query).toString();
  }
}

/// Get first segment from [location].
String getRootPath(String location) {
  final segments = Uri.parse(location).pathSegments;
  if (segments.isEmpty) {
    AppRoute._log.severe('getRootPath: no root location found');

    return AppRoute.defaultRoute.path;
  }

  return '/${segments.first}';
}

/// Get last segment from [location].
String getCurrentPath(String location) {
  final segments = Uri.parse(location).pathSegments;
  if (segments.isEmpty) {
    AppRoute._log.severe('getCurrentPath: no current location found');

    return AppRoute.defaultRoute.path;
  }

  // If we have only one segment, then we are on root location
  return '${segments.length == 1 ? '/' : ''}${segments.last}';
}

/// Get first segment from [location] and return [AppRoute].
AppRoute getRootAppRoute(String location) {
  return AppRoute.getByPath(getRootPath(location));
}

/// Get last segment from [location] and return [AppRoute].
AppRoute getCurrentAppRoute(String location) {
  return AppRoute.getByPath(getCurrentPath(location));
}

/// Returns true, if every segment from [location] can be saved in
/// NavigationService.
bool canSaveLocation(String location) {
  final uri = Uri.parse(location);

  return uri.pathSegments
      .every((segment) => AppRoute.getByPath(segment).isSaveLocation);
}

extension NavigationHelper on BuildContext {
  /// Navigate to a location above current.
  /// Instead of:
  /// ```
  /// onPressed: () => context.go(
  ///   '${AppRoute.onboarding.path}/${AppRoute.multiuse.path}',
  /// ),
  /// ```
  ///
  /// USE:
  /// ```
  /// onPressed: () => context.goFurther(AppRoute.multiuse.path),
  /// ```
  void goFurther(String location, {Object? extra}) {
    if (!mounted) return;

    var resultLocation = Uri.parse(GoRouter.of(this).location);
    // We have query params in old path and we must update it manually
    if (resultLocation.hasQuery) {
      final newLocation = Uri.parse(location);
      final query = <String, dynamic>{}
        ..addAll(resultLocation.queryParameters)
        ..addAll(newLocation.queryParameters);

      resultLocation = resultLocation.replace(
        path: '${resultLocation.path}/${newLocation.path}',
        queryParameters: query,
      );
    } else {
      // old location do not have query, new one may have it, we dont care
      resultLocation =
          resultLocation.replace(path: '${resultLocation.path}/$location');
    }

    return GoRouter.of(this).go(
      Uri.decodeComponent(resultLocation.toString()),
      extra: extra,
    );
  }

  /// Pop current screen if possible.
  void maybePop() {
    final goRouter = GoRouter.of(this);
    if (goRouter.canPop()) {
      goRouter.pop();
    }
  }
}
