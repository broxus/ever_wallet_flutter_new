import 'package:app/app/router/app_route.dart';
import 'package:app/feature/choose_network/choose_network_screen.dart';
import 'package:go_router/go_router.dart';

const chooseNetworkNextPathQueryParam = 'chooseNetworkNextPath';

GoRoute chooseNetworkRoute({
  List<RouteBase> routes = const [],
}) {
  return GoRoute(
    name: AppRoute.chooseNetwork.name,
    path: AppRoute.chooseNetwork.path,
    builder: (_, state) {
      return const ChooseNetworkScreen();
    },
    routes: routes,
  );
}
