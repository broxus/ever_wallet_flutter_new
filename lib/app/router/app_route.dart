import 'package:app/app/router/routs/routs.dart';
import 'package:app/app/service/navigation/service/navigation_service.dart';
import 'package:app/di/di.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

final RegExp _parameterRegExp = RegExp(r':(\w+)(\((?:\\.|[^\\()])+\))?');

enum AppRoute {
  onboarding(
    'onboarding',
    '/onboarding',
    isSaveLocation: true,
  ),

  /// Wallet section
  wallet(
    'wallet',
    '/wallet',
    isSaveLocation: true,
    isBottomNavigationBarVisible: true,
  ),
  selectNewAsset(
    '',
    'selectNewAsset/:$selectNewAssetAddress',
  ),

  /// Browser section
  browser(
    'browser',
    '/browser',
    isSaveLocation: true,
    isBottomNavigationBarVisible: true,
    isSaveSubroutes: true,
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
    '',
    'seedDetail/:$seedDetailPublicKeyPathParam',
    isSaveLocation: true,
  ),
  keyDetail(
    '',
    'keyDetail/:$keyDetailPublicKeyPathParam',
    isSaveLocation: true,
  ),
  accountDetail(
    '',
    'accountDetail/:$accountDetailAddressPathParam',
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
    'createSeed/:$enterSeedNameNamePathParam',
    isSaveLocation: true,
  ),
  enterSeed(
    '',
    'enterSeed',
    isSaveLocation: true,
  ),
  enterSeedNamed(
    '',
    'enterSeed/:$enterSeedNameNamePathParam',
    isSaveLocation: true,
  ),

  // command flag means: 'import' - import, 'create' (or other) - create,
  // see <enterSeedNameImportCommand> and <enterSeedNameCreateCommand>.
  enterSeedName(
    '',
    'enterSeedName/:$enterSeedNameCommandPathParam',
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
  ),

  /// Browser section

  /// Bookmarks browser page
  browserBookmarks(
    'browserBookmarks',
    '/browser/browserBookmarks',
    isSaveLocation: true,
    isBottomNavigationBarVisible: true,
  ),

  /// History browser page
  browserHistory(
    'browserHistory',
    '/browser/browserHistory',
    isSaveLocation: true,
    isBottomNavigationBarVisible: true,
  ),

  /// Tabs browser page
  browserTabs(
    'browserTabs',
    '/browser/browserTabs',
    isSaveLocation: true,
    isBottomNavigationBarVisible: true,
  );

  const AppRoute(
    this.name,
    this.path, {
    this.isSaveLocation = false,
    this.isBottomNavigationBarVisible = false,
    this.isSaveSubroutes = false,
  });

  static final _log = Logger('AppRoute');

  final String name;
  final String path;

  /// If location is saved in NavigationService.
  final bool isSaveLocation;

  /// Should BottomNavigationBar be visible.
  final bool isBottomNavigationBarVisible;

  /// Should subroutes be saved and restored when user navigates between
  /// root routes. It's effective only for root routes
  final bool isSaveSubroutes;

  static AppRoute? getByPath(String path) {
    // ignore: prefer-enums-by-name
    return AppRoute.values.firstWhereOrNull(
      (e) => e.path == path,
    );
  }

  static AppRoute get defaultRoute => onboarding;

  // Reconstructs the full path from a [pattern] and path parameters.
  // This thing is directly copied from the go_router package ¯\_(ツ)_/¯
  ///
  /// This is useful for restoring the original path from a [RegExpMatch].
  ///
  /// For example, A path matched a [RegExp] returned from patternToRegExp and
  /// produced a [RegExpMatch]. To reconstruct the path from the match, one
  /// can follow these steps:
  ///
  /// 1. Get the `pathParameters` by calling extractPathParameters with the
  ///    [RegExpMatch] and the parameters used for generating the [RegExp].
  /// 2. Call [patternToPath] with the `pathParameters` from the first step and
  ///    the original `pattern` used for generating the [RegExp].
  String patternToPath(String pattern, Map<String, String> pathParameters) {
    final buffer = StringBuffer();
    var start = 0;
    for (final match in _parameterRegExp.allMatches(pattern)) {
      if (match.start > start) {
        buffer.write(pattern.substring(start, match.start));
      }
      final name = match[1]!;
      buffer.write(pathParameters[name]);
      start = match.end;
    }

    if (start < pattern.length) {
      buffer.write(pattern.substring(start));
    }

    return buffer.toString();
  }

  /// Helper method, that allows add path and query parameter to [path].
  String pathWithData({
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) {
    final encodedParams = <String, String>{
      for (final MapEntry<String, String> param in pathParameters.entries)
        param.key: Uri.encodeComponent(param.value),
    };

    final location = patternToPath(path, encodedParams);

    return Uri(
      path: location,
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    ).toString();
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

/// Get [AppRoute].
AppRoute getAppRoute(String location) {
  return AppRoute.getByPath(location) ?? AppRoute.defaultRoute;
}

/// Get first segment from [location] and return [AppRoute].
AppRoute getRootAppRoute(String location) {
  return AppRoute.getByPath(getRootPath(location)) ?? AppRoute.defaultRoute;
}

/// Get last segment from [location] and return [AppRoute].
AppRoute getCurrentAppRoute(String location) {
  return AppRoute.getByPath(getCurrentPath(location)) ??
      AppRoute.getByPath(location) ??
      AppRoute.defaultRoute;
}

/// Returns true, if every segment from [location] can be saved in
/// NavigationService.
bool canSaveLocation(String location) {
  final uri = Uri.parse(location);

  return uri.pathSegments
      .every((segment) => AppRoute.getByPath(segment)?.isSaveLocation ?? false);
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

    final currentLocation = inject<NavigationService>().location;
    var resultLocation = Uri.parse(currentLocation);
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

  /// Navigate to current location, but without query parameters.
  void clearQueryParams() {
    if (!mounted) return;

    final currentLocation = inject<NavigationService>().location;
    final resultLocation = Uri.parse(currentLocation).replace(
      queryParameters: {},
    );

    return GoRouter.of(this).go(
      Uri.decodeComponent(resultLocation.toString()),
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
