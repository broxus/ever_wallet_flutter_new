import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

// TODO(nesquikm): move to ui package
const _duration = Duration(milliseconds: 150);

CustomTransitionPage<void> onboardingTransitionPageBuilder(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: _duration,
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      return SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).chain(
            CurveTween(curve: Curves.easeInOut),
          ),
        ),
        child: child,
      );
    },
  );
}

CustomTransitionPage<void> rootTransitionPageBuilder(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: _duration,
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      return SlideTransition(
        position: animation.drive(
          Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).chain(
            CurveTween(curve: Curves.easeInOut),
          ),
        ),
        child: child,
      );
    },
  );
}

CustomTransitionPage<void> rootTabsTransitionPageBuilder(
  BuildContext context,
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: _duration,
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
        child: child,
      );
    },
  );
}
