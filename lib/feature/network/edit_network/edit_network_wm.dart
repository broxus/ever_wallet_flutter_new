import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/network/network.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

EditNetworkWidgetModel defaultEditNetworkWidgetModelFactory(
  BuildContext context,
) =>
    EditNetworkWidgetModel(
      EditNetworkModel(
        inject(),
      ),
    );

class EditNetworkWidgetModel
    extends CustomWidgetModel<EditNetworkPageWidget, EditNetworkModel> {
  EditNetworkWidgetModel(super.model);

  ConnectionData? get connection => model.connections.firstWhereOrNull(
        (element) => element.id == widget.connectionDataId,
      );

  void addConnection(ConnectionData connection) =>
      model.addConnection(connection);

  void updateConnection(ConnectionData connection) =>
      model.updateConnection(connection);

  void removeConnection(String id) => model.removeConnection(id);
}
