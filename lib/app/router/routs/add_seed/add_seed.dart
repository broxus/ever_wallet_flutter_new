import 'package:app/app/router/router.dart';
import 'package:app/feature/add_seed/check_seed_phrase/check_seed_phrase.dart';
import 'package:app/feature/add_seed/create_password/create_password.dart';
import 'package:app/feature/add_seed/create_seed/create_seed.dart';
import 'package:app/feature/add_seed/enter_seed_name/enter_seed_name.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/enter_seed_phrase.dart';
import 'package:go_router/go_router.dart';

/// Name of path field for navigation
const enterSeedNameCommandPathParam = 'command';

/// Name of path field for navigation
const enterSeedNameNamePathParam = 'name';

/// Route that allows to create a seed phrase without entering name.
/// This route may be used in onboarding or profile section, depends
/// on [passwordRoute].
GoRoute createSeedNoNamedRoute(GoRoute passwordRoute) {
  return GoRoute(
    path: AppRoute.createSeed.path,
    builder: (_, __) => const CreateSeedPage(),
    routes: [
      GoRoute(
        path: AppRoute.checkSeed.path,
        builder: (_, state) => CheckSeedPhrasePage(
          extra: state.extra! as CreateSeedRouteExtra,
        ),
        routes: [
          passwordRoute,
        ],
      ),
      passwordRoute,
    ],
  );
}

/// Route that allows to enter a seed phrase without entering name.
/// This route may be used in onboarding or profile section, depends
/// on [passwordRoute].
GoRoute enterSeedNoNamedRoute(GoRoute passwordRoute) {
  return GoRoute(
    path: AppRoute.enterSeed.path,
    builder: (_, __) => const EnterSeedPhrasePage(),
    routes: [
      passwordRoute,
    ],
  );
}

/// Route that allows to create a seed phrase in onboarding without name.
GoRoute get createSeedNoNamedOnboardingRoute {
  return createSeedNoNamedRoute(
    GoRoute(
      path: AppRoute.createSeedPassword.path,
      builder: (_, state) => CreateSeedPasswordOnboardingPage(
        extra: state.extra! as CreateSeedRouteExtra,
      ),
    ),
  );
}

/// Route that allows to enter a seed phrase in onboarding without name.
GoRoute get enterSeedNoNamedOnboardingRoute {
  return enterSeedNoNamedRoute(
    GoRoute(
      path: AppRoute.createSeedPassword.path,
      builder: (_, GoRouterState state) => CreateSeedPasswordOnboardingPage(
        extra: state.extra! as CreateSeedRouteExtra,
      ),
    ),
  );
}

/// Route that allows to create a seed phrase in profile without name.
GoRoute get createSeedNoNamedProfileRoute {
  return createSeedNoNamedRoute(
    GoRoute(
      path: AppRoute.createSeedPassword.path,
      builder: (_, state) => CreateSeedPasswordProfilePage(
        extra: state.extra! as CreateSeedRouteExtra,
      ),
    ),
  );
}

/// Route that allows to enter a seed phrase in profile without name.
GoRoute get enterSeedNoNamedProfileRoute {
  return enterSeedNoNamedRoute(
    GoRoute(
      path: AppRoute.createSeedPassword.path,
      builder: (_, GoRouterState state) => CreateSeedPasswordProfilePage(
        extra: state.extra! as CreateSeedRouteExtra,
      ),
    ),
  );
}

/// Route that allows to create a seed phrase with entering name.
/// Typically used in profile.
GoRoute get createSeedNamedProfileRoute {
  final passwordRoute = GoRoute(
    path: AppRoute.createSeedPassword.path,
    builder: (_, GoRouterState state) => CreateSeedPasswordProfilePage(
      extra: state.extra! as CreateSeedRouteExtra,
    ),
  );

  return GoRoute(
    path: AppRoute.createSeedNamed.path,
    builder: (_, state) => CreateSeedPage(
      name: state.pathParameters[enterSeedNameNamePathParam],
    ),
    routes: [
      GoRoute(
        path: AppRoute.checkSeed.path,
        builder: (_, state) => CheckSeedPhrasePage(
          extra: state.extra! as CreateSeedRouteExtra,
        ),
        routes: [
          passwordRoute,
        ],
      ),
      passwordRoute,
    ],
  );
}

/// Route that allows to enter a seed phrase with entering name.
/// Typically used in profile.
GoRoute get enterSeedNamedProfileRoute {
  return GoRoute(
    path: AppRoute.enterSeedNamed.path,
    builder: (_, state) => EnterSeedPhrasePage(
      name: state.pathParameters[enterSeedNameNamePathParam],
    ),
    routes: [
      GoRoute(
        path: AppRoute.createSeedPassword.path,
        builder: (_, GoRouterState state) => CreateSeedPasswordProfilePage(
          extra: state.extra! as CreateSeedRouteExtra,
        ),
      ),
    ],
  );
}

/// Route that allows CRATE or ENTER seed phrase with entering name.
GoRoute get addSeedNamedRoute {
  return GoRoute(
    path: AppRoute.enterSeedName.path,
    builder: (_, state) => EnterSeedNamePage(
      commandName: state.pathParameters[enterSeedNameCommandPathParam],
    ),
    routes: [
      createSeedNoNamedProfileRoute,
      createSeedNamedProfileRoute,
      enterSeedNoNamedProfileRoute,
      enterSeedNamedProfileRoute,
    ],
  );
}
