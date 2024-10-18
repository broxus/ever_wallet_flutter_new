import 'dart:async';

import 'package:app/app/router/app_route.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/choose_network/choose_network_screen.dart';
import 'package:app/feature/contact_support/widgets/widgets.dart';
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
      inject(),
    ),
  );
}

/// [WidgetModel] для [WelcomeScreen]
class WelcomeScreenWidgetModel
    extends CustomWidgetModel<WelcomeScreen, WelcomeScreenModel> {
  WelcomeScreenWidgetModel(
    super.model,
  );

  final _decentralizationPolicyLink = 'https://l1.broxus.com/sparx/terms/';

  ThemeStyleV2 get themeStyle => context.themeStyleV2;

  Future<void> onPressedCreateWallet() async {
    unawaited(model.saveUserNew(userWithNewWallet: true));
    _goNext(AppRoute.createSeedPassword.path);
  }

  void onPressedWalletLogin() {
    model.saveUserNew(userWithNewWallet: false);
    _goNext(AppRoute.addExistingWallet.path);
  }

  void _goNext(String nextStep) {
    contextSafe?.goFurther(
      AppRoute.chooseNetwork.pathWithData(
        queryParameters: {
          chooseNetworkScreenNextStepQuery: nextStep,
        },
      ),
    );
  }

  void onLinkTap() => launchUrlString(_decentralizationPolicyLink);

  void onClickSupport() => showContactSupportSheet(
        context: context,
        mode: ContactSupportMode.initiatedByUser,
      );
}
