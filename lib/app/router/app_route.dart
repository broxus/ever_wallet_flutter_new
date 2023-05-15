import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

enum AppRoute {
  onboarding('onboarding', '/onboarding', isSaveLocation: true),
  wallet('wallet', '/wallet', isSaveLocation: true),
  browser('browser', '/browser', isSaveLocation: true),
  profile('profile', '/profile', isSaveLocation: true),
  createSeed('', 'createSeed', isSaveLocation: true),
  checkSeed('', 'checkSeed'),
  enterSeed('', 'enterSeed', isSaveLocation: true),
  createSeedPassword('', 'createSeedPassword');

  const AppRoute(this.name, this.path, {this.isSaveLocation = false});

  static final _log = Logger('AppRoute');

  final String name;
  final String path;

  /// If location is saved in NavigationService.
  final bool isSaveLocation;

  static AppRoute getByPath(String path) {
    return AppRoute.values.firstWhere(
      (e) => e.path == path,
      orElse: () => defaultRoute,
    );
  }

  static AppRoute get defaultRoute => onboarding;
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

/// Get first segment from [location] and return [AppRoute].
AppRoute getRootAppRoute(String location) {
  return AppRoute.getByPath(getRootPath(location));
}

/// Returns true, if every segment from [location] can be saved in
/// NavigationService.
bool canSaveLocation(String location) {
  final uri = Uri.parse(location);
  final allSaved = uri.pathSegments
      .every((segment) => AppRoute.getByPath(segment).isSaveLocation);

  return allSaved;
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
    return GoRouter.of(this)
        .go('${GoRouter.of(this).location}/$location', extra: extra);
  }

  /// Pop current screen if possible.
  void maybePop() {
    final goRouter = GoRouter.of(this);
    if (goRouter.canPop()) {
      goRouter.pop();
    }
  }
}
