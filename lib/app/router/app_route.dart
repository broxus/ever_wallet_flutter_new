enum AppRoute {
  onboarding('onboarding', '/onboarding'),
  wallet('wallet', '/wallet'),
  browser('browser', '/browser'),
  profile('profile', '/profile');

  const AppRoute(this.name, this.path);

  final String name;
  final String path;

  static AppRoute getByPath(String path) {
    return AppRoute.values.firstWhere(
      (e) => e.path == path,
      orElse: () => defaultRoute,
    );
  }

  static AppRoute get defaultRoute => onboarding;
}

String getRootPath(String location) {
  return RegExp(r'/[\w\d]+').firstMatch(location)?.group(0) ?? '';
}

AppRoute getRootAppRoute(String location) {
  return AppRoute.getByPath(getRootPath(location));
}
