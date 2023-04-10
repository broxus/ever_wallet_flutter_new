import 'package:app/app/cubit/nav_cubit.dart';
import 'package:app/app/router/app_route.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/error/error.dart';
import 'package:app/feature/onboarding/onboarding.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/root/root.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

GoRouter getRouter(BuildContext context) {
  return GoRouter(
    redirect: (context, state) {
      // Save current location in NavCubit
      final location = state.location;
      context.read<NavCubit>().setLocation(location);

      final hasAccount = inject<NekotonRepository>().accountsStream.value;
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
    },
    initialLocation: context.read<NavCubit>().state.location,
    routes: <RouteBase>[
      GoRoute(
        name: AppRoute.onboarding.name,
        path: AppRoute.onboarding.path,
        builder: (BuildContext context, GoRouterState state) {
          return const OnboardingPage();
        },
      ),
      ShellRoute(
        // navigatorKey: _shellNavigatorKey,
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
}
