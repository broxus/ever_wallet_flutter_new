import 'package:app/app/router/router.dart';
import 'package:app/app/service/services.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/error/error.dart';
import 'package:app/feature/onboarding/onboarding.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/root/root.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

export 'app_route.dart';

GoRouter getRouter(BuildContext context) {
  // Redirect to onboarding or wallet depending on the current location and if
  // the user has an account
  String? shouldRedirect({required String location, required bool hasAccount}) {
    final currentRoute = getRootAppRoute(location);

    if (hasAccount && currentRoute == AppRoute.onboarding) {
      // Already onboarded, redirect to wallet
      return AppRoute.wallet.path;
    } else if (!hasAccount && currentRoute != AppRoute.onboarding) {
      // Not onboarded, redirect to onboarding
      return AppRoute.onboarding.path;
    }
    // No need to redirect
    return null;
  }

  final router = GoRouter(
    redirect: (context, state) {
      final location = state.location;
      // Save current location in NavigationService
      inject<NavigationService>().setLocation(location);
      final hasAccount = inject<NekotonRepository>().accountsStream.value;

      // Actually redirect, this is when the router will actually change the
      // location, so we need to subscribe to the accountsStream for updates
      return shouldRedirect(location: location, hasAccount: hasAccount);
    },
    // Initial location from NavigationService
    initialLocation: inject<NavigationService>().location,
    routes: <RouteBase>[
      GoRoute(
        name: AppRoute.onboarding.name,
        path: AppRoute.onboarding.path,
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingPage();
        },
      ),
      ShellRoute(
        builder: (context, state, child) {
          return RootPage(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            name: AppRoute.wallet.name,
            path: AppRoute.wallet.path,
            builder: (BuildContext context, GoRouterState state) {
              return const WalletPage();
            },
          ),
          GoRoute(
            name: AppRoute.browser.name,
            path: AppRoute.browser.path,
            builder: (BuildContext context, GoRouterState state) {
              return const BrowserPage();
            },
          ),
          GoRoute(
            name: AppRoute.profile.name,
            path: AppRoute.profile.path,
            builder: (BuildContext context, GoRouterState state) {
              return const ProfilePage();
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(state.error),
  );

  // Subscribe to accountsStream to redirect if needed
  // This is a-la guard, it should redirect to onboarding or wallet depending
  // on the current location and if the user has an account
  inject<NekotonRepository>().accountsStream.listen((hasAccount) {
    final redirectLocation = shouldRedirect(
      location: inject<NavigationService>().location,
      hasAccount: hasAccount,
    );

    if (redirectLocation != null) {
      router.go(redirectLocation);
    }
  });

  return router;
}
