import 'package:app/app/router/app_route.dart';
import 'package:app/feature/choose_network/choose_network_screen.dart';
import 'package:app/feature/choose_network/data/next_step.dart';
import 'package:go_router/go_router.dart';
import 'package:string_extensions/string_extensions.dart';

const chooseNetworkNextPathQueryParam = 'chooseNetworkNextPath';

GoRoute chooseNetworkRoute({
  List<RouteBase> routes = const [],
}) {
  return GoRoute(
    name: AppRoute.chooseNetwork.name,
    path: AppRoute.chooseNetwork.path,
    builder: (_, state) {
      final nextStep =
          state.uri.queryParameters[chooseNetworkScreenNextStepQuery];
      return ChooseNetworkScreen(
        nextStep: ChooseNetworkScreenNextStep.byValue(nextStep),
      );
    },
    routes: routes,
  );
}
