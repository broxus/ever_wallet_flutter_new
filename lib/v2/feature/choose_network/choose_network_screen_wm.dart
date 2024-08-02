import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/network_type.dart';
import 'package:app/v2/feature/choose_network/choose_network_screen.dart';
import 'package:app/v2/feature/choose_network/choose_network_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Factory method for creating [ChooseNetworkScreenWidgetModel]
ChooseNetworkScreenWidgetModel defaultChooseNetworkScreenWidgetModelFactory(
  BuildContext context,
) {
  return ChooseNetworkScreenWidgetModel(
    ChooseNetworkScreenModel(
      createPrimaryErrorHandler(context),
    ),
  );
}

/// [WidgetModel] для [ChooseNetworkScreen]
class ChooseNetworkScreenWidgetModel
    extends CustomWidgetModel<ChooseNetworkScreen, ChooseNetworkScreenModel> {
  ChooseNetworkScreenWidgetModel(
    super.model,
  );

  StateNotifier<List<NetworkType>> get connectionsState =>
      model.connectionsState;

  Color get backgroundColor => _themeStyle.colors.background0;

  double get windowHeight => MediaQuery.of(context).size.height;

  ThemeStyleV2 get _themeStyle => context.themeStyleV2;

  Future<void> onPressedType(NetworkType type) async {
    final isSuccess = await model.selectType(type);

    if (!isSuccess) {
      return;
    }

    widget.onSuccess?.call();
  }
}
