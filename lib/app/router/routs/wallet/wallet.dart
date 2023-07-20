import 'package:app/app/router/router.dart';
import 'package:app/feature/add_seed/add_seed_enable_biometry/add_seed_enable_biometry.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:go_router/go_router.dart';

/// Branch that is root for wallet.
StatefulShellBranch get walletBranch {
  return StatefulShellBranch(
    routes: [
      GoRoute(
        name: AppRoute.wallet.name,
        path: AppRoute.wallet.path,
        builder: (context, state) => const WalletPage(),
        routes: [
          GoRoute(
            path: AppRoute.enableBiometryAfterOnboarding.path,
            builder: (_, __) => const AddSeedEnableBiometryPage(),
          ),
        ],
      ),
    ],
  );
}
