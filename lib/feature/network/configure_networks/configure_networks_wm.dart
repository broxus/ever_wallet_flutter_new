import 'package:app/app/router/router.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/network/configure_networks/configure_networks_model.dart';
import 'package:app/feature/network/configure_networks/configure_networks_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

ConfigureNetworksWidgetModel defaultConfigureNetworksWidgetModelFactory(
  BuildContext context,
) =>
    ConfigureNetworksWidgetModel(
      ConfigureNetworksModel(
        createPrimaryErrorHandler(context),
        inject(),
      ),
    );

class ConfigureNetworksWidgetModel
    extends CustomWidgetModel<ConfigureNetworksWidget, ConfigureNetworksModel> {
  ConfigureNetworksWidgetModel(super.model);

  late final _connections = createNotifierFromStream(model.connections);

  ListenableState<List<ConnectionData>> get connections => _connections;

  ThemeStyleV2 get theme => context.themeStyleV2;

  void onItemTap(ConnectionData data) {
    context.goFurther(
      AppRoute.editNetwork.pathWithData(
        queryParameters: {
          networkConnectionDataIdQueryParam: data.id,
        },
      ),
    );
  }

  void onAddNetwork() {
    context.goFurther(AppRoute.editNetwork.path);
  }
}
