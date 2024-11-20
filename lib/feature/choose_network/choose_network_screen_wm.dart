// ignore_for_file: use_build_context_synchronously

import 'package:app/app/router/app_route.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/choose_network/choose_network_screen.dart';
import 'package:app/feature/choose_network/choose_network_screen_model.dart';
import 'package:app/feature/choose_network/data/choose_network_item_data.dart';
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

  late final _loadingItemId = createNotifier<String?>();

  StateNotifier<List<ChooseNetworkItemData>> get connectionsState =>
      model.connectionsState;

  StateNotifier<String?> get loadingItemId => _loadingItemId;

  Color get backgroundColor => _themeStyle.colors.background0;

  double get windowHeight => MediaQuery.of(context).size.height;

  ThemeStyleV2 get _themeStyle => context.themeStyleV2;

  Future<void> onPressedType(String id) async {
    if (_loadingItemId.value != null) return;

    try {
      _loadingItemId.accept(id);

      if (!await model.checkConnection(context)) {
        return;
      }

      final isSuccess = await model.selectType(context, id);

      final isCanPop = contextSafe?.canPop() ?? false;

      final nextPath = widget.nextStep;

      if (nextPath != null) {
        contextSafe?.goFurther(
          nextPath,
          preserveQueryParams: true,
        );
      } else if (isCanPop) {
        contextSafe?.pop(isSuccess);
      }
    } finally {
      _loadingItemId.accept(null);
    }
  }
}
