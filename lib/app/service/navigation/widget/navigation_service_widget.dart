import 'package:app/app/router/app_route.dart';
import 'package:app/app/service/navigation/bloc/navigation_bloc.dart';
import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationServiceWidget extends StatefulWidget {
  const NavigationServiceWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<NavigationServiceWidget> createState() =>
      _NavigationServiceWidgetState();
}

class _NavigationServiceWidgetState extends State<NavigationServiceWidget> {
  final NavigationBloc _bloc = NavigationBloc();

  @override
  void initState() {
    super.initState();

    _bloc.init();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  void _onNavigationEvent(NavigationState state) {
    _onLocationChange(state.oldLocation, state.location);
  }

  // Handle location change
  void _onLocationChange(String? oldLocation, String? location) {
    // Handle every location change
    switch ((oldLocation, location)) {
      // Skip if location is not yet set
      case (_, null):
        break;
      // When both locations are not null
      case (final String oldLocation, final String location):
        // Calculate root app route change
        final oldRoute = getRootAppRoute(oldLocation);
        final route = getRootAppRoute(location);

        // And if it's changed
        if (oldRoute != route) {
          // Then call the handler
          _onRootAppRouteChange(
            getRootAppRoute(oldLocation),
            getRootAppRoute(location),
          );
        }
    }
  }

  // Handle root app route change
  void _onRootAppRouteChange(AppRoute oldRoute, AppRoute route) {
    switch ((oldRoute, route)) {
      // When user navigates from onboarding it means that he has created a seed
      case (AppRoute.onboarding, AppRoute.wallet):
        _onboardingToWalletNavigation();
      default:
    }
  }

  Future<void> _onboardingToWalletNavigation() async {
    // We can't use current context here because it's not contains Navigator
    final context = NavigationService.navigatorKey.currentState?.context;
    if (context == null) {
      return;
    }

    final biometry = inject<BiometryService>();
    if (biometry.available) {
      if (context.mounted) {
        context.goFurther(AppRoute.enableBiometryAfterOnboarding.path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      bloc: _bloc,
      listener: (context, state) => _onNavigationEvent(state),
      child: widget.child,
    );
  }
}
