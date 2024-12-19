import 'dart:async';

import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/approvals_listener/actions/change_network/change_network_model.dart';
import 'package:app/feature/browser/approvals_listener/actions/change_network/change_network_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

ChangeNetworkWidgetModel defaultChangeNetworkWidgetModelFactory(
  BuildContext context,
) =>
    ChangeNetworkWidgetModel(
      ChangeNetworkModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class ChangeNetworkWidgetModel
    extends CustomWidgetModel<ChangeNetworkWidget, ChangeNetworkModel> {
  ChangeNetworkWidgetModel(super.model);

  late final _loading = createValueNotifier(false);
  late final _connection = createValueNotifier<ConnectionData>(
    widget.connections.first,
  );

  ValueListenable<bool> get loading => _loading;

  ValueListenable<ConnectionData> get connection => _connection;

  ThemeStyleV2 get theme => context.themeStyleV2;

  Future<void> onConfirm() async {
    _loading.value = true;
    try {
      final strategy = await model.changeNetwork(_connection.value.id);

      if (contextSafe != null) {
        Navigator.of(contextSafe!).pop(strategy);
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

  // ignore: use_setters_to_change_properties
  void onConnectionChanged(ConnectionData value) => _connection.value = value;
}
