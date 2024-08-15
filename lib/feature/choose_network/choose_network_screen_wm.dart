import 'package:app/app/router/app_route.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/choose_network/choose_network_screen.dart';
import 'package:app/feature/choose_network/choose_network_screen_model.dart';
import 'package:app/feature/choose_network/data/choose_network_item_data.dart';
import 'package:app/feature/choose_network/data/next_step.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Factory method for creating [ChooseNetworkScreenWidgetModel]
ChooseNetworkScreenWidgetModel defaultChooseNetworkScreenWidgetModelFactory(
  BuildContext context,
) {
  return ChooseNetworkScreenWidgetModel(
    ChooseNetworkScreenModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
    ),
  );
}

/// [WidgetModel] для [ChooseNetworkScreen]
class ChooseNetworkScreenWidgetModel
    extends CustomWidgetModel<ChooseNetworkScreen, ChooseNetworkScreenModel> {
  ChooseNetworkScreenWidgetModel(
    super.model,
  );

  StateNotifier<List<ChooseNetworkItemData>> get connectionsState =>
      model.connectionsState;

  Color get backgroundColor => _themeStyle.colors.background0;

  double get windowHeight => MediaQuery.of(context).size.height;

  ThemeStyleV2 get _themeStyle => context.themeStyleV2;

  Future<void> onPressedType(String id) async {
    final isSuccess = await model.selectType(id);

    final isCanPop = contextSafe?.canPop() ?? false;

    final nextPath = switch (widget.nextStep) {
      ChooseNetworkScreenNextStep.createWallet =>
        AppRoute.createSeedPassword.path,
      ChooseNetworkScreenNextStep.importSeed => AppRoute.addExistingWallet.path,
      _ => null,
    };

    if (nextPath != null) {
      contextSafe?.goFurther(
        nextPath,
        preserveQueryParams: true,
      );
    } else if (isCanPop) {
      contextSafe?.pop(isSuccess);
    }
  }
}
