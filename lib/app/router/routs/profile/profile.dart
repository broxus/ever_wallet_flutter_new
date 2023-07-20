import 'package:app/app/router/router.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Get branch for profile root.
StatefulShellBranch get profileBranch {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        name: AppRoute.profile.name,
        path: AppRoute.profile.path,
        builder: (context, state) => const ProfilePage(),
        routes: [
          manageSeedAccountsRoute,
        ],
      ),
    ],
  );
}

/// Get route for manage seed accounts.
GoRoute get manageSeedAccountsRoute {
  return GoRoute(
    path: AppRoute.manageSeedsAccounts.path,
    name: AppRoute.manageSeedsAccounts.name,
    builder: (_, __) => const ManageSeedsAccountsPage(),
    routes: [
      addSeedNamedRoute,
      seedDetailRoute,
    ],
  );
}

/// Get route for seed detail screen.
GoRoute get seedDetailRoute {
  return GoRoute(
    path: AppRoute.seedDetail.path,
    builder: (_, state) => SeedDetailPage(
      publicKey: PublicKey(
        publicKey: state.pathParameters[seedDetailPublicKeyPathParam]!,
      ),
    ),
    routes: [keyDetailRoute],
  );
}

GoRoute get keyDetailRoute {
  return GoRoute(
    path: AppRoute.keyDetail.path,
    builder: (_, state) => KeyDetailPage(
      publicKey: PublicKey(
        publicKey: state.pathParameters[keyDetailPublicKeyPathParam]!,
      ),
    ),
    routes: [accountDetailRoute],
  );
}

GoRoute get accountDetailRoute {
  return GoRoute(
    path: AppRoute.accountDetail.path,
    builder: (_, state) => AccountDetailPage(
      address: Address(
        address: state.pathParameters[accountDetailAddressPathParam]!,
      ),
    ),
  );
}
