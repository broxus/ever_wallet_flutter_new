import 'package:app/app/router/page_transitions.dart';
import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/error/error.dart';
import 'package:app/feature/onboarding/onboarding.dart';
import 'package:app/feature/root/root.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

export 'app_route.dart';
export 'routs/routs.dart';

// ignore: long-method
GoRouter getRouter(BuildContext _) {
  final log = Logger('RouterHelper');

  // Last saved root app route
  AppRoute? lastRootAppRoute;

  // Just for debouncing, because setLocation() can be called multiple times
  // with the same location
  String? lastSetlocation;

  // Saved subroutes for each root app route
  final savedSubroutes = <AppRoute, String>{};

  // Redirect to onboarding or wallet depending on the current location and if
  // the user has any seeds.
  String? shouldRedirect({required String fullPath, required bool hasSeeds}) {
    final currentRoute = getRootAppRoute(fullPath: fullPath);

    // If the user has seeds and is on onboarding, redirect to wallet
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

  // Set location, it will be called in multiple places
  // because GoRouter's 'redirect' handler doesn't call it after pop()
  void setLocation(String location, String fullPath) {
    // And because of that, we need to check if the location is the same
    // as the last one to avoid duplicate calls of NavigationService.setLocation
    if (lastSetlocation == location) {
      return;
    }

    lastSetlocation = location;

    // Set current location in NavigationService
    inject<NavigationService>().setState(
      state: NavigationServiceState(
        location: location,
        fullPath: fullPath,
      ),
      save: canSaveLocation(fullPath: fullPath),
    );

    // Get root app route
    final rootAppRoute = getRootAppRoute(fullPath: fullPath);

    // Save subroute for the root app route
    if (rootAppRoute.isSaveSubroutes) {
      savedSubroutes[rootAppRoute] = location;
    }

    // Save last root app route
    lastRootAppRoute = rootAppRoute;
  }

  // Create a new router
  final router = GoRouter(
    restorationScopeId: 'app',
    navigatorKey: NavigationService.navigatorKey,
    redirect: (context, state) {
      // Get current location and full path
      final location = state.uri.toString();
      final fullPath = state.fullPath ?? location;

      // Get root app route
      final rootAppRoute = getRootAppRoute(fullPath: fullPath);

      // Get saved subroute for the root app route (if any)
      final savedSubroute = savedSubroutes[rootAppRoute];

      // Check if the root app route changed
      final rootAppRouteChaned = lastRootAppRoute != rootAppRoute;

      // Set location
      setLocation(location, fullPath);

      // Check if the user has seeds
      final hasSeeds = inject<NekotonRepository>().hasSeeds.value;

      // Check if the user should be redirected
      final guardRedirect =
          shouldRedirect(fullPath: fullPath, hasSeeds: hasSeeds);

      // Redirect if needed
      if (guardRedirect != null) {
        return guardRedirect;
      }

      // If the root app route changed and there is a saved subroute, return it
      // This is for the case when the user navigates to a subroute, then
      // navigates to another root app route and returns back to the previous
      // root app route using bottom tab bar. In this case, the subroute should
      // be restored.
      if (rootAppRouteChaned && savedSubroute != null) {
        return savedSubroute;
      }

      // Nothing to do, return null
      return null;
    },
    // Initial location from NavigationService
    initialLocation: inject<NavigationService>().savedState.location,
    routes: [
      GoRoute(
        name: AppRoute.onboarding.name,
        path: AppRoute.onboarding.path,
        pageBuilder: (context, state) => onboardingTransitionPageBuilder(
          context,
          state,
          const OnboardingPage(),
        ),
        routes: [
          createSeedNoNamedOnboardingRoute,
          enterSeedNoNamedOnboardingRoute,
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => RootPage(
          child: navigationShell,
        ),
        branches: [
          walletBranch,
          browserBranch,
          profileBranch,
        ],
      ),
    ],
    errorBuilder: (context, state) {
      // Something went wrong, clear saved subroutes
      log.severe('GoRouter error: ${state.error}');
      savedSubroutes.clear();

      return ErrorPage(state.error);
    },
  );

  // Subscribe to hasSeeds to redirect if needed
  // This is a-la guard, it should redirect to onboarding or wallet depending
  // on the current location and if the user has any seeds.
  inject<NekotonRepository>().hasSeeds.listen((hasSeeds) {
    // Again, check if the user should be redirected depending on the current
    // location and if the user has any seeds.
    final redirectLocation = shouldRedirect(
      fullPath: inject<NavigationService>().state.fullPath,
      hasSeeds: hasSeeds,
    );

    // Redirect if needed
    if (redirectLocation != null) {
      router.go(redirectLocation);
    }
  });

  // Subscribe to routerDelegate changes to set location
  router.routerDelegate.addListener(
    () {
      final currentConfiguration = router.routerDelegate.currentConfiguration;
      setLocation(
        currentConfiguration.uri.toString(),
        currentConfiguration.fullPath,
      );
    },
  );

  return router;
}
