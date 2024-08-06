import 'package:app/app/router/app_route.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/v2/feature/choose_network/route_data.dart';
import 'package:app/v2/feature/onboarding/screen/welcome/welcome_screen.dart';
import 'package:app/v2/feature/onboarding/screen/welcome/welcome_screen_model.dart';
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

  void onPressedCreateWallet() {
    context.goFurther(
      AppRoute.chooseNetwork.path,
      extra: ChooseNetworkScreenRouteData(
        onSuccess: () {
          /// TODO
          context.goFurther(AppRoute.importWallet.path);
        },
      ),
    );
  }

  void onPressedWalletLogin() {
    context.goFurther(
      AppRoute.chooseNetwork.path,
      extra: ChooseNetworkScreenRouteData(
        onSuccess: () {
          /// TODO
          context.goFurther(AppRoute.enterSeed.path);
        },
      ),
    );
  }

  void onLinkTap() => launchUrlString(_decentralizationPolicyLink);
}
