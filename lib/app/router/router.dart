// ignore_for_file: lines_longer_than_80_chars

import 'package:app/app/router/page_transitions.dart';
import 'package:app/app/router/router.dart';
import 'package:app/app/router/routs/network/network.dart';
import 'package:app/app/service/service.dart';
import 'package:app/feature/error/error.dart';
import 'package:app/feature/onboarding/screen/welcome/welcome_screen.dart';
import 'package:app/feature/root/root.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

export 'app_route.dart';
export 'routs/routs.dart';

class AppRouter {
  AppRouter(
    this._bootstrapService,
    this._navigationService,
    this._nekotonRepository,
  ) {
    // Subscribe to hasSeeds to redirect if needed
    // This is a-la guard, it should redirect to onboarding or wallet depending
    // on the current location and if the user has any seeds.
    _nekotonRepository.hasSeeds.listen(_listenSeed);

    // Subscribe to bootstrapStep to redirect if needed
    // This is a-la guard, it should redirect to onboarding or wallet depending
    // on the current location and if the user has any seeds.
    // This happends when user was sent to bootstrap failed screen to make some
    // action and then bootstrap process was completed.
    _bootstrapService.bootstrapStepStream.listen(_listenBootstrapStep);
  }

  // Create a new router
  late final router = _createRouter();

  final BootstrapService _bootstrapService;
  final NavigationService _navigationService;
  final NekotonRepository _nekotonRepository;

  final _log = Logger('RouterHelper');

  // Last saved root app route
  AppRoute? _lastRootAppRoute;

  // Just for debouncing, because setLocation() can be called multiple times
  // with the same location
  String? _lastSetlocation;

  // Saved subroutes for each root app route
  final _savedSubroutes = <AppRoute, String>{};

  bool get _isConfigured => _bootstrapService.isConfigured;

  String get _currentPath =>
      router.routerDelegate.currentConfiguration.fullPath;

  String get _savedLocation => _navigationService.state.location;

  bool get _isExistSavedLocation => _savedLocation.isNotEmpty;

  GoRouter _createRouter() {
    return GoRouter(
      restorationScopeId: 'app',
      navigatorKey: NavigationService.navigatorKey,
      redirect: (context, state) {
        if (!_bootstrapService.isConfigured) {
          return null;
        }

        // Get current location and full path
        final location = state.uri.toString();
        final fullPath = state.fullPath ?? location;

        // Get root app route
        final rootAppRoute = getRootAppRoute(fullPath: fullPath);
        final segments = AppRoute.pathSegments(fullPath: fullPath);
        final isSubroute = segments.length > 1;

        // Get saved subroute for the root app route (if any)
        final savedSubroute = _savedSubroutes[rootAppRoute];

        // Check if the root app route changed
        final rootAppRouteChaned = _lastRootAppRoute != rootAppRoute;

        // Set location
        _setLocation(location, fullPath);

        // Check if the user should be redirected
        final guardRedirect = _shouldRedirect(
          fullPath: fullPath,
          hasSeeds: _nekotonRepository.hasSeeds.valueOrNull,
          step: _bootstrapService.bootstrapStep,
        );

        if (guardRedirect != null) {
          return guardRedirect;
        }

        // If the root app route changed and there is a saved subroute,
        // return it
        // This is for the case when the user navigates to a subroute, then
        // navigates to another root app route and returns back to the previous
        // root app route using bottom tab bar. In this case, the subroute
        // should be restored.
        // Skip subroute restoration if navigatad directry to subrout.
        if (rootAppRouteChaned && !isSubroute && savedSubroute != null) {
          return savedSubroute;
        }

        // Nothing to do, return null
        return null;
      },
      initialLocation: AppRoute.splash.path,
      routes: [
        bootstrapFailedRoute,
        noInternetRoute,
        splashScreenRoute,
        GoRoute(
          name: AppRoute.onboarding.name,
          path: AppRoute.onboarding.path,
          pageBuilder: (context, state) => onboardingTransitionPageBuilder(
            context,
            state,
            const WelcomeScreen(),
          ),
          routes: [
            chooseNetworkRoute(
              routes: [
                createOnboardingSeedPasswordRoute,
                addExistingWalletRoute,
              ],
            ),
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
        _log.severe('GoRouter error: ${state.error}');
        _savedSubroutes.clear();

        // Get current location and full path
        final location = state.uri.toString();
        final fullPath = state.fullPath ?? location;

        final currentRoute = getRootAppRoute(fullPath: fullPath);
        final isOnboarding = currentRoute == AppRoute.onboarding;

        return ErrorPage(isOnboarding: isOnboarding);
      },
    )

      // Subscribe to routerDelegate changes to set location
      ..routerDelegate.addListener(
        () {
          final currentConfiguration =
              router.routerDelegate.currentConfiguration;
          _setLocation(
            currentConfiguration.uri.toString(),
            currentConfiguration.fullPath,
          );
        },
      );
  }

  void _listenSeed(bool hasSeeds) {
    // Again, check if the user should be redirected depending on the current
    // location and if the user has any seeds.
    final redirectLocation = _shouldRedirect(
      fullPath: _navigationService.state.fullPath,
      hasSeeds: hasSeeds,
      step: _bootstrapService.bootstrapStep,
    );

    // Redirect if needed
    if (redirectLocation != null) {
      router.go(redirectLocation);
    }
  }

  void _listenBootstrapStep(BootstrapSteps step) {
    // Again, check if the user should be redirected depending on the current
    // location and if the user has any seeds and bootstrap completed.
    final redirectLocation = _shouldRedirect(
      fullPath: _navigationService.state.fullPath,
      hasSeeds: _nekotonRepository.hasSeeds.valueOrNull,
      step: _bootstrapService.bootstrapStep,
    );

    // Redirect if needed
    if (redirectLocation != null) {
      router.go(redirectLocation);
    }
  }

  // Redirect to onboarding or wallet depending on the current location and if
  // the user has any seeds.
  String? _shouldRedirect({
    required String fullPath,
    required bool? hasSeeds,
    required BootstrapSteps step,
  }) {
    final currentRoute = getRootAppRoute(fullPath: fullPath);

    if (step == BootstrapSteps.error &&
        currentRoute != AppRoute.bootstrapFailedInit) {
      return AppRoute.bootstrapFailedInit.pathWithData(
        pathParameters: {
          bootstrapFailedIndexPathParam: step.index.toString(),
        },
      );
    }

    if (!_isConfigured || hasSeeds == null) {
      return null;
    }

    if (!hasSeeds && currentRoute != AppRoute.onboarding) {
      // Not onboarded, redirect to onboarding
      return AppRoute.onboarding.path;
    }

    if (_currentPath == AppRoute.splash.path) {
      return _isExistSavedLocation ? _savedLocation : currentRoute.path;
    }

    // No need to redirect
    return null;
  }

  // Set location, it will be called in multiple places
  // because GoRouter's 'redirect' handler doesn't call it after pop()
  void _setLocation(String location, String fullPath) {
    // And because of that, we need to check if the location is the same
    // as the last one to avoid duplicate calls of NavigationService.setLocation
    if (_lastSetlocation == location) {
      return;
    }

    _lastSetlocation = location;

    // Set current location in NavigationService
    _navigationService.setState(
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
      _savedSubroutes[rootAppRoute] = location;
    }

    // Save last root app route
    _lastRootAppRoute = rootAppRoute;
  }
}
