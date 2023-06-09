import 'package:app/app/router/page_transitions.dart';
import 'package:app/app/router/router.dart';
import 'package:app/feature/add_seed/add_seed_enable_biometry/add_seed_enable_biometry.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Route that is root for wallet.
GoRoute get walletRoute {
  return GoRoute(
    name: AppRoute.wallet.name,
    path: AppRoute.wallet.path,
    pageBuilder: (BuildContext context, GoRouterState state) =>
        rootTabsTransitionPageBuilder(
      context,
      state,
      const WalletPage(),
    ),
    routes: [
      GoRoute(
        path: AppRoute.enableBiometryAfterOnboarding.path,
        builder: (_, __) => const AddSeedEnableBiometryPage(),
      ),
    ],
  );
}
