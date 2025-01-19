import 'dart:async';

import 'package:app/app/router/page_transitions.dart';
import 'package:app/app/router/router.dart';
import 'package:app/app/router/routs/network/network.dart';
import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/event_bus/events/bootstrap/bootstrap_event.dart';
import 'package:app/event_bus/primary_bus.dart';
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

    _bootstrapErrorEventSubscription =
        primaryBus.on<BootstrapEvent>().listen(_listenBootstrapErrorStep);
  }

  // Create a new router
  late final router = _createRouter();

  final BootstrapService _bootstrapService;
  final NavigationService _navigationService;
  final NekotonRepository _nekotonRepository;

  StreamSubscription<BootstrapEvent>? _bootstrapErrorEventSubscription;

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

  void dispose() {
    _bootstrapErrorEventSubscription?.cancel();
    router.dispose();
  }

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
    );

    // Redirect if needed
    if (redirectLocation != null) {
      router.go(redirectLocation);
    }
  }

  void _listenBootstrapErrorStep(BootstrapEvent event) {
    String? path;

    if (event is BootstrapCompleteEvent) {
      path = _shouldRedirect(
        fullPath: _navigationService.state.fullPath,
        hasSeeds: _nekotonRepository.hasSeeds.valueOrNull,
      );
    } else if (event is BootstrapErrorEvent) {
      final fullPath = getRootAppRoute(
        fullPath: _navigationService.state.fullPath,
      );

      path = fullPath != AppRoute.bootstrapFailedInit
          ? AppRoute.bootstrapFailedInit.pathWithData(
              pathParameters: {
                bootstrapFailedIndexPathParam:
                    _bootstrapService.bootstrapStep.index.toString(),
              },
            )
          : null;
    }

    if (path == null) {
      return;
    }
    router.go(path);
  }

  // Redirect to onboarding or wallet depending on the current location and if
  // the user has any seeds.
  String? _shouldRedirect({
    required String fullPath,
    required bool? hasSeeds,
  }) {
    final currentRoute = getRootAppRoute(fullPath: fullPath);

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

extension RouterExtension on GoRouter {
  static final _navigationService = inject<NavigationService>();

  void goFurther(
    String location, {
    bool preserveQueryParams = false,
    Object? extra,
  }) {
    return go(
      Uri.decodeComponent(
        _getUriLocation(
          location,
          preserveQueryParams: preserveQueryParams,
        ).toString(),
      ),
      extra: extra,
    );
  }

  Future<T?> pushFurther<T>(
    String location, {
    bool preserveQueryParams = false,
    Object? extra,
  }) async {
    return push<T>(
      Uri.decodeComponent(
        _getUriLocation(
          location,
          preserveQueryParams: preserveQueryParams,
        ).toString(),
      ),
      extra: extra,
    );
  }

  /// Navigate to current location, but without query parameters.
  void clearQueryParams() {
    final currentLocation = inject<NavigationService>().state.location;
    final resultLocation = Uri.parse(currentLocation).replace(
      queryParameters: {},
    );

    return go(
      Uri.decodeComponent(resultLocation.toString()),
    );
  }

  /// Pop current screen if possible.
  void maybePop({
    bool preserveQueryParams = true,
    List<String>? removeQueries,
  }) {
    try {
      if (!preserveQueryParams) {
        clearQueryParams();
      } else if (removeQueries != null) {
        _removeQueryParams(removeQueries);
      }

      if (canPop()) {
        pop();
      }
    } catch (_) {}
  }

  void clearQueryParamsAndPop<T extends Object?>([T? result]) {
    clearQueryParams();

    pop<T>(result);
  }

  void _removeQueryParams(
    List<String> removeQueries,
  ) {
    final uri = Uri.parse(_navigationService.state.location);

    final queryParameters = {...uri.queryParameters};

    for (final param in removeQueries) {
      queryParameters.remove(param);
    }

    final resultLocation = uri.replace(
      queryParameters: queryParameters,
    );

    return go(
      Uri.decodeComponent(resultLocation.toString()),
    );
  }

  Uri _getUriLocation(
    String path, {
    bool preserveQueryParams = false,
  }) {
    final location = Uri.parse(inject<NavigationService>().state.location);
    final pathUri = Uri.parse(path);
    late Uri resultLocation;
    // We have query params in old path that we should preserve, so we must
    // update it manually
    if (location.hasQuery && preserveQueryParams) {
      final query = <String, dynamic>{}
        ..addAll(location.queryParameters)
        ..addAll(pathUri.queryParameters);

      resultLocation = location.replace(
        path: '${location.path}/${pathUri.path}',
        queryParameters: query,
      );
    } else {
      // old location do not have query, new one may have it, we dont care
      resultLocation = location.replace(
        path: '${location.path}/${pathUri.path}',
        queryParameters: pathUri.queryParameters,
      );
    }

    return resultLocation;
  }
}
