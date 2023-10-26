import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/feature/bootstrap_failed/bootstrap_failed.dart';
import 'package:go_router/go_router.dart';

const bootstrapFailedIndexPathParam = 'bootstrapStepIndexPathParam';

GoRoute get bootstrapFailedRoute {
  return GoRoute(
    name: AppRoute.bootstrapFailedInit.name,
    path: AppRoute.bootstrapFailedInit.path,
    builder: (_, state) => BootstrapFailedPage(
      step: BootstrapSteps.values[int.parse(
        state.pathParameters[bootstrapFailedIndexPathParam]!,
      )],
    ),
    routes: [
      configureNetworksRoute,
    ],
  );
}
