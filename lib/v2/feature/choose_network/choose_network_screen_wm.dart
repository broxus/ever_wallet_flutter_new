import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/v2/feature/choose_network/choose_network_screen.dart';
import 'package:app/v2/feature/choose_network/choose_network_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';

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
}
