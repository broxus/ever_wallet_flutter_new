import 'dart:convert';

import 'package:app/app/router/app_route.dart';
import 'package:app/app/router/routs/add_seed/add_seed.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/onboarding/screen/welcome/welcome_screen.dart';
import 'package:app/feature/onboarding/screen/welcome/welcome_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Factory method for creating [WelcomeScreenWidgetModel]
WelcomeScreenWidgetModel defaultWelcomeScreenWidgetModelFactory(
  BuildContext context,
) {
  return WelcomeScreenWidgetModel(
    WelcomeScreenModel(
      createPrimaryErrorHandler(context),
    ),
  );
}

/// [WidgetModel] для [WelcomeScreen]
class WelcomeScreenWidgetModel
    extends CustomWidgetModel<WelcomeScreen, WelcomeScreenModel> {
  WelcomeScreenWidgetModel(
    super.model,
  );

  final _decentralizationPolicyLink =
      'https://l1.broxus.com/everscale/wallet/terms';

  ThemeStyleV2 get themeStyle => context.themeStyleV2;

  Future<void> onPressedCreateWallet() async {
    final seedData = jsonEncode(
      await model.createSeed(),
    );

    await _goToSelectNetwork();

    contextSafe?.goFurther(
      AppRoute.createSeedPassword.pathWithData(
        queryParameters: {
          addSeedPhraseQueryParam: seedData,
        },
      ),
    );
  }

  Future<void> onPressedWalletLogin() async {
    await _goToSelectNetwork();

    contextSafe?.goFurther(
      AppRoute.addExistingWallet.path,
    );
  }

  Future<void>? _goToSelectNetwork() {
    return contextSafe?.pushFurther(
      AppRoute.chooseNetwork.path,
    );
  }

  void onLinkTap() => launchUrlString(_decentralizationPolicyLink);
}
