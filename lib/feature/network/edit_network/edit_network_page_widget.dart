import 'package:app/feature/network/edit_network/edit_network_view.dart';
import 'package:app/feature/network/edit_network/edit_network_wm.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class EditNetworkPageWidget extends ElementaryWidget<EditNetworkWidgetModel> {
  const EditNetworkPageWidget({
    this.connectionDataId,
    Key? key,
    WidgetModelFactory wmFactory = defaultEditNetworkWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final String? connectionDataId;

  @override
  Widget build(EditNetworkWidgetModel wm) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: wm.connection?.name ?? LocaleKeys.addCustomNetwork.tr(),
      ),
      body: EditNetworkView(
        connection: wm.connection,
        onAdd: wm.addConnection,
        onUpdate: wm.updateConnection,
        onRemove: wm.removeConnection,
        onSwitch: wm.saveCurrentConnectionId,
      ),
    );
  }
}
