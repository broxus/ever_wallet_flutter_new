import 'dart:convert';

import 'package:app/app/router/router.dart';
import 'package:app/feature/add_seed/add_existing_wallet/view/add_existing_wallet_page.dart';
import 'package:app/feature/add_seed/add_seed_enable_biometry/view/add_seed_enable_biometry_page.dart';
import 'package:app/feature/add_seed/create_password/screens/create_seed_password/create_seed_password_screen.dart';
import 'package:app/feature/add_seed/create_password/view/create_seed_password_page.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/view/enter_seed_phrase_page.dart';
import 'package:app/feature/add_seed/import_wallet/import_wallet_screen.dart';
import 'package:app/v1/feature/add_seed/check_seed_phrase/check_seed_phrase.dart';
import 'package:app/v1/feature/add_seed/create_seed/create_seed.dart';
import 'package:app/v1/feature/add_seed/enter_seed_name/view/enter_seed_name_page.dart';
import 'package:go_router/go_router.dart';

/// Name for phrase from queryParams to create or import seed.
const addSeedPhraseQueryParam = 'addSeedPhrase';

/// Name of path field for navigation
const enterSeedNameCommandPathParam = 'command';

/// Name of path field for navigation
const enterSeedNameNamePathParam = 'nameParam';

/// Route that allows to create a seed phrase without entering name.
/// This route may be used in onboarding or profile section, depends
/// on [passwordRoute].
@Deprecated('Use v2 version')
GoRoute createSeedNoNamedRoute(GoRoute passwordRoute) {
  return GoRoute(
    path: AppRoute.createSeed.path,
    builder: (_, __) => const CreateSeedPage(),
    routes: [
      GoRoute(
        path: AppRoute.checkSeed.path,
        builder: (_, state) => CheckSeedPhrasePage(
          phrase: (jsonDecode(
            state.uri.queryParameters[addSeedPhraseQueryParam]!,
          ) as List<dynamic>)
              .cast<String>(),
        ),
        routes: [
          passwordRoute,
        ],
      ),
      passwordRoute,
    ],
  );
}

/// Route that allows to enter a seed phrase without entering name.
/// This route may be used in onboarding or profile section, depends
/// on [passwordRoute].
GoRoute enterSeedNoNamedRoute(GoRoute passwordRoute) {
  return GoRoute(
    path: AppRoute.enterSeed.path,
    builder: (_, __) => const EnterSeedPhrasePage(),
    routes: [
      passwordRoute,
    ],
  );
}

GoRoute get enterSeedOnboardingRoute {
  return enterSeedNoNamedRoute(
    createOnboardingSeedPasswordRoute,
  );
}

GoRoute get addExistingWalletRoute {
  return GoRoute(
    name: AppRoute.addExistingWallet.name,
    path: AppRoute.addExistingWallet.path,
    builder: (_, __) => const AddExistingWalletPage(),
    routes: [
      importWalletRoute,
    ],
  );
}

GoRoute get importWalletRoute {
  return GoRoute(
    path: AppRoute.importWallet.path,
    builder: (_, __) => const ImportWalletScreen(),
    routes: [
      enterSeedOnboardingRoute,
      createOnboardingSeedPasswordRoute,
    ],
  );
}

GoRoute get createOnboardingSeedPasswordRoute {
  return GoRoute(
    path: AppRoute.createSeedPassword.path,
    builder: (_, GoRouterState state) {
      return const CreateSeedPasswordScreen();
    },
    routes: [
      seedEnableBiometryRoute,
    ],
  );
}

GoRoute get seedEnableBiometryRoute {
  return GoRoute(
    path: AppRoute.enableBiometryAfterOnboarding.path,
    builder: (_, GoRouterState state) => const AddSeedEnableBiometryPage(),
  );
}

/// Route that allows to create a seed phrase in profile without name.
@Deprecated('Use v2 version')
GoRoute get createSeedNoNamedProfileRoute {
  return createSeedNoNamedRoute(
    GoRoute(
      path: AppRoute.createSeedPassword.path,
      builder: (_, state) => CreateSeedPasswordProfilePage(
        phrase: (jsonDecode(
          state.uri.queryParameters[addSeedPhraseQueryParam]!,
        ) as List<dynamic>)
            .cast<String>(),
        name: state.pathParameters[enterSeedNameNamePathParam],
      ),
    ),
  );
}

/// Route that allows to enter a seed phrase in profile without name.
GoRoute get enterSeedNoNamedProfileRoute {
  return enterSeedNoNamedRoute(
    GoRoute(
      path: AppRoute.createSeedPassword.path,
      builder: (_, GoRouterState state) => CreateSeedPasswordProfilePage(
        phrase: (jsonDecode(
          state.uri.queryParameters[addSeedPhraseQueryParam]!,
        ) as List<dynamic>)
            .cast<String>(),
        name: state.pathParameters[enterSeedNameNamePathParam],
      ),
    ),
  );
}

/// Route that allows to create a seed phrase with entering name.
/// Typically used in profile.
@Deprecated('Use v2 version')
GoRoute get createSeedNamedProfileRoute {
  final passwordRoute = GoRoute(
    path: AppRoute.createSeedPassword.path,
    builder: (_, GoRouterState state) => CreateSeedPasswordProfilePage(
      phrase: (jsonDecode(
        state.uri.queryParameters[addSeedPhraseQueryParam]!,
      ) as List<dynamic>)
          .cast<String>(),
      name: state.pathParameters[enterSeedNameNamePathParam],
    ),
  );

  return GoRoute(
    path: AppRoute.createSeedNamed.path,
    builder: (_, state) => const CreateSeedPage(),
    routes: [
      GoRoute(
        path: AppRoute.checkSeed.path,
        builder: (_, state) => CheckSeedPhrasePage(
          phrase: (jsonDecode(
            state.uri.queryParameters[addSeedPhraseQueryParam]!,
          ) as List<dynamic>)
              .cast<String>(),
        ),
        routes: [
          passwordRoute,
        ],
      ),
      passwordRoute,
    ],
  );
}

/// Route that allows to enter a seed phrase with entering name.
/// Typically used in profile.
@Deprecated('Use v2 version')
GoRoute get enterSeedNamedProfileRoute {
  return GoRoute(
    path: AppRoute.enterSeedNamed.path,
    builder: (_, state) => const EnterSeedPhrasePage(),
    routes: [
      GoRoute(
        path: AppRoute.createSeedPassword.path,
        builder: (_, GoRouterState state) => CreateSeedPasswordProfilePage(
          phrase: (jsonDecode(
            state.uri.queryParameters[addSeedPhraseQueryParam]!,
          ) as List<dynamic>)
              .cast<String>(),
          name: state.pathParameters[enterSeedNameNamePathParam],
        ),
      ),
    ],
  );
}

/// Route that allows CRATE or ENTER seed phrase with entering name.
@Deprecated('Use v2 version')
GoRoute get addSeedNamedRoute {
  return GoRoute(
    path: AppRoute.enterSeedName.path,
    builder: (_, state) => EnterSeedNamePage(
      commandName: state.pathParameters[enterSeedNameCommandPathParam],
    ),
    routes: [
      createSeedNoNamedProfileRoute,
      createSeedNamedProfileRoute,
      enterSeedNoNamedProfileRoute,
      enterSeedNamedProfileRoute,
    ],
  );
}
