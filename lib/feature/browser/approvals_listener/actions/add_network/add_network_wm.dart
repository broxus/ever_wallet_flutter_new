import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/approvals_listener/actions/add_network/add_network_model.dart';
import 'package:app/feature/browser/approvals_listener/actions/add_network/add_network_widget.dart';
import 'package:app/feature/browser/utils.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

AddNetworkWidgetModel defaultAddNetworkWidgetModelFactory(
  BuildContext context,
) =>
    AddNetworkWidgetModel(
      AddNetworkModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
        inject(),
      ),
    );

class AddNetworkWidgetModel
    extends CustomWidgetModel<AddNetworkWidget, AddNetworkModel> {
  AddNetworkWidgetModel(super.model);

  late final _loading = createValueNotifier(false);
  late final _switchNetwork = createValueNotifier(widget.switchNetwork);

  ValueListenable<bool> get loading => _loading;

  ValueListenable<bool> get switchNetwork => _switchNetwork;

  ThemeStyleV2 get theme => context.themeStyleV2;

  Future<void> onConfirm() async {
    _loading.value = true;
    try {
      final connection = widget.network.getConnection();
      final network = await model.addConnection(connection);

      if (_switchNetwork.value) {
        await model.changeNetwork(connection.id);
      }

      if (contextSafe != null) {
        Navigator.of(contextSafe!).pop(network);
      }
    } on TimeoutException catch (_) {
      if (contextSafe != null) {
        model.showError(contextSafe!, LocaleKeys.operationTimeout.tr());
      }
    } catch (e) {
      if (contextSafe != null) {
        model.showError(contextSafe!, e.toString());
      }
    } finally {
      _loading.value = false;
    }
  }

  // ignore: use_setters_to_change_properties, avoid_positional_boolean_parameters
  void onSwitchChanged(bool value) => _switchNetwork.value = value;
}
