import 'package:app/app/router/app_route.dart';
import 'package:app/feature/choose_network/choose_network_screen.dart';
import 'package:app/feature/choose_network/route_data.dart';
import 'package:go_router/go_router.dart';

GoRoute chooseNetworkRoute({
  List<RouteBase> routes = const [],
}) {
  return GoRoute(
    name: AppRoute.chooseNetwork.name,
    path: AppRoute.chooseNetwork.path,
    builder: (_, state) {
      final extra = state.extra;

      SuccessCallback? onSuccess;

      if (extra is ChooseNetworkScreenRouteData) {
        onSuccess = extra.onSuccess;
      }

      return ChooseNetworkScreen(
        onSuccess: onSuccess,
      );
    },
    routes: routes,
  );
}
