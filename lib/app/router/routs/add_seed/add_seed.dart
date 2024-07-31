import 'dart:convert';

import 'package:app/app/router/router.dart';
import 'package:app/v1/feature/add_seed/check_seed_phrase/check_seed_phrase.dart';
import 'package:app/v1/feature/add_seed/create_seed/create_seed.dart';
import 'package:app/v2/feature/add_seed/add_existing_wallet/view/view.dart';
import 'package:app/v2/feature/add_seed/create_password/create_password.dart';
import 'package:app/v2/feature/add_seed/enter_seed_name/enter_seed_name.dart';
import 'package:app/v2/feature/add_seed/enter_seed_phrase/enter_seed_phrase.dart';
import 'package:app/v2/feature/add_seed/import_wallet/import_wallet.dart';
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

GoRoute get addExistingWalletRoute {
  return GoRoute(
    path: AppRoute.addExistingWallet.path,
    builder: (_, __) => const AddExistingWalletPage(),
  );
}

GoRoute get importWalletRoute {
  return GoRoute(
    path: AppRoute.importWallet.path,
    builder: (_, __) => const ImportWalletPage(),
  );
}

/// Route that allows to create a seed phrase in onboarding without name.
@Deprecated('Use v2 version')
GoRoute get createSeedNoNamedOnboardingRoute {
  return createSeedNoNamedRoute(
    GoRoute(
      path: AppRoute.createSeedPassword.path,
      builder: (_, state) => CreateSeedPasswordOnboardingPage(
        phrase: (jsonDecode(
          state.uri.queryParameters[addSeedPhraseQueryParam]!,
        ) as List<dynamic>)
            .cast<String>(),
      ),
    ),
  );
}

/// Route that allows to enter a seed phrase in onboarding without name.
@Deprecated('Use v2 version')
GoRoute get enterSeedNoNamedOnboardingRoute {
  return enterSeedNoNamedRoute(
    GoRoute(
      path: AppRoute.createSeedPassword.path,
      builder: (_, GoRouterState state) => CreateSeedPasswordOnboardingPage(
        phrase: (jsonDecode(
          state.uri.queryParameters[addSeedPhraseQueryParam]!,
        ) as List<dynamic>)
            .cast<String>(),
      ),
    ),
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
@Deprecated('Use v2 version')
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
