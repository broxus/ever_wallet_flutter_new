import 'package:app/app/router/page_transitions.dart';
import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/add_seed/check_seed_phrase/check_seed_phrase.dart';
import 'package:app/feature/add_seed/create_password/create_password.dart';
import 'package:app/feature/add_seed/create_seed/create_seed.dart';
import 'package:app/feature/add_seed/enter_seed_name/enter_seed_name.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/enter_seed_phrase.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/error/error.dart';
import 'package:app/feature/onboarding/onboarding.dart';
import 'package:app/feature/profile/manage_seeds_accounts/manage_seeds_accounts.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/root/root.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

export 'app_route.dart';

// ignore: long-method
GoRouter getRouter(BuildContext _) {
  // Redirect to onboarding or wallet depending on the current location and if
  // the user has any seeds.
  String? shouldRedirect({required String location, required bool hasSeeds}) {
    final currentRoute = getRootAppRoute(location);

    if (hasSeeds && currentRoute == AppRoute.onboarding) {
      // Already onboarded, redirect to wallet
      return AppRoute.wallet.path;
    } else if (!hasSeeds && currentRoute != AppRoute.onboarding) {
      // Not onboarded, redirect to onboarding
      return AppRoute.onboarding.path;
    }

    // No need to redirect
    return null;
  }

  final router = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    redirect: (context, state) {
      final location = state.location;
      // Save current location in NavigationService
      if (canSaveLocation(location)) {
        inject<NavigationService>().setLocation(location);
      }
      final hasSeeds = inject<NekotonRepository>().hasSeeds.value;

      // Actually redirect, this is when the router will actually change the
      // location, so we need to subscribe to the hasSeeds for updates
      return shouldRedirect(location: location, hasSeeds: hasSeeds);
    },
    // Initial location from NavigationService
    initialLocation: inject<NavigationService>().location,
    routes: <RouteBase>[
      GoRoute(
        name: AppRoute.onboarding.name,
        path: AppRoute.onboarding.path,
        pageBuilder: (context, state) => onboardingTransitionPageBuilder(
          context,
          state,
          const OnboardingPage(),
        ),
        routes: [
          GoRoute(
            path: AppRoute.createSeed.path,
            builder: (_, __) => const CreateSeedPage(),
            routes: [
              GoRoute(
                path: AppRoute.checkSeed.path,
                builder: (_, state) => CheckSeedPhrasePage(
                  extra: state.extra! as CreateSeedRouteExtra,
                ),
                routes: [
                  GoRoute(
                    path: AppRoute.createSeedPassword.path,
                    builder: (_, state) => CreateSeedPasswordOnboardingPage(
                      extra: state.extra! as CreateSeedRouteExtra,
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: AppRoute.createSeedPassword.path,
                builder: (_, GoRouterState state) =>
                    CreateSeedPasswordOnboardingPage(
                  extra: state.extra! as CreateSeedRouteExtra,
                ),
              ),
            ],
          ),
          GoRoute(
            path: AppRoute.enterSeed.path,
            builder: (_, __) => const EnterSeedPhrasePage(),
            routes: [
              GoRoute(
                path: AppRoute.createSeedPassword.path,
                builder: (_, GoRouterState state) =>
                    CreateSeedPasswordOnboardingPage(
                  extra: state.extra! as CreateSeedRouteExtra,
                ),
              ),
            ],
          ),
        ],
      ),
      ShellRoute(
        pageBuilder: (context, state, child) => rootTransitionPageBuilder(
          context,
          state,
          RootPage(child: child),
        ),
        routes: <RouteBase>[
          GoRoute(
            name: AppRoute.wallet.name,
            path: AppRoute.wallet.path,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                rootTabsTransitionPageBuilder(
              context,
              state,
              const WalletPage(),
            ),
          ),
          GoRoute(
            name: AppRoute.browser.name,
            path: AppRoute.browser.path,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                rootTabsTransitionPageBuilder(
              context,
              state,
              const BrowserPage(),
            ),
          ),
          GoRoute(
            name: AppRoute.profile.name,
            path: AppRoute.profile.path,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                rootTabsTransitionPageBuilder(
              context,
              state,
              const ProfilePage(),
            ),
            routes: [
              GoRoute(
                path: AppRoute.manageSeedsAccounts.path,
                name: AppRoute.manageSeedsAccounts.name,
                builder: (_, __) => const ManageSeedsAccountsPage(),
                routes: [
                  GoRoute(
                    path: AppRoute.enterSeedName.path,
                    builder: (_, state) => EnterSeedNamePage(
                      command: state.pathParameters['command'] ??
                          enterSeedNameImportCommand,
                    ),
                    routes: [
                      GoRoute(
                        path: AppRoute.createSeed.path,
                        builder: (_, state) => CreateSeedPage(
                          name: state.queryParameters['name'],
                        ),
                        routes: [
                          GoRoute(
                            path: AppRoute.checkSeed.path,
                            builder: (_, state) => CheckSeedPhrasePage(
                              extra: state.extra! as CreateSeedRouteExtra,
                            ),
                            routes: [
                              GoRoute(
                                path: AppRoute.createSeedPassword.path,
                                builder: (_, state) =>
                                    CreateSeedPasswordProfilePage(
                                  extra: state.extra! as CreateSeedRouteExtra,
                                ),
                              ),
                            ],
                          ),
                          GoRoute(
                            path: AppRoute.createSeedPassword.path,
                            builder: (_, GoRouterState state) =>
                                CreateSeedPasswordProfilePage(
                              extra: state.extra! as CreateSeedRouteExtra,
                            ),
                          ),
                        ],
                      ),
                      GoRoute(
                        path: AppRoute.enterSeed.path,
                        builder: (_, state) => EnterSeedPhrasePage(
                          name: state.queryParameters['name'],
                        ),
                        routes: [
                          GoRoute(
                            path: AppRoute.createSeedPassword.path,
                            builder: (_, GoRouterState state) =>
                                CreateSeedPasswordProfilePage(
                              extra: state.extra! as CreateSeedRouteExtra,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(state.error),
  );

  // Subscribe to hasSeeds to redirect if needed
  // This is a-la guard, it should redirect to onboarding or wallet depending
  // on the current location and if the user has any seeds.
  inject<NekotonRepository>().hasSeeds.listen((hasSeeds) {
    final redirectLocation = shouldRedirect(
      location: inject<NavigationService>().location,
      hasSeeds: hasSeeds,
    );

    if (redirectLocation != null) {
      router.go(redirectLocation);
    }
  });

  return router;
}
