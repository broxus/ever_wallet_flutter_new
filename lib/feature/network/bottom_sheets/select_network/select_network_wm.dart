import 'package:app/app/router/router.dart';
import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/network/bottom_sheets/select_network/select_network_model.dart';
import 'package:app/feature/network/bottom_sheets/select_network/select_network_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

SelectNetworkWidgetModel defaultSelectNetworkWidgetModelFactory(
  BuildContext context,
) =>
    SelectNetworkWidgetModel(
      SelectNetworkModel(
        createPrimaryErrorHandler(context),
        inject(),
      ),
    );

class SelectNetworkWidgetModel
    extends CustomWidgetModel<SelectNetworkWidget, SelectNetworkModel> {
  SelectNetworkWidgetModel(super.model);

  late final _currentConnectionId =
      createNotifierFromStream(model.currentConnectionId);
  late final _connections = createNotifierFromStream(model.connections);

  ListenableState<String> get currentConnectionId => _currentConnectionId;

  ListenableState<List<ConnectionData>> get connections => _connections;

  void onConfigure() {
    if (widget.needPopAfterAction) Navigator.of(context).pop();
    context.goFurther(AppRoute.configureNetworks.path);
  }

  void onItemTap(ConnectionData data) {
    if (widget.needPopAfterAction) Navigator.of(context).pop();
    model.changeCurrentConnection(data.id);
  }
}
