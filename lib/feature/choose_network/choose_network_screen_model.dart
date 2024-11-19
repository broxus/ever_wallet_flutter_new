// ignore_for_file: use_build_context_synchronously

import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/app/service/nekoton_related/connection_service/network_presets.dart';
import 'package:app/app/service/network_connection/network_connection_service.dart';
import 'package:app/app/service/storage_service/connections_storage_service.dart';
import 'package:app/feature/choose_network/choose_network_screen.dart';
import 'package:app/feature/choose_network/data/choose_network_item_data.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/mixins/connection_mixin.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

/// [ElementaryModel] for [ChooseNetworkScreen]
class ChooseNetworkScreenModel extends ElementaryModel with ConnectionMixin {
  ChooseNetworkScreenModel(
    ErrorHandler errorHandler,
    this.messengerService,
    this.networkConnectionService,
    this._connectionsStorageService,
  ) : super(errorHandler: errorHandler);

  @override
  @protected
  final MessengerService messengerService;

  @override
  @protected
  final NetworkConnectionService networkConnectionService;

  final connectionsState = StateNotifier<List<ChooseNetworkItemData>>(
    initValue: [],
  );

  final ConnectionsStorageService _connectionsStorageService;

  @override
  void init() {
    _initNetworksData();
    super.init();
  }

  @override
  void dispose() {
    connectionsState.dispose();
    super.dispose();
  }

  Future<bool> selectType(BuildContext context, String id) async {
    try {
      _connectionsStorageService.saveCurrentConnectionId(id);
    } on Object catch (e) {
      messengerService.show(
        Message.error(
          context: context,
          message: e.toString(),
        ),
      );
      return false;
    }

    return true;
  }

  void _initNetworksData() {
    final connections = _connectionsStorageService.connections;

    final list = <ChooseNetworkItemData>[];

    for (final connection in connections) {
      switch (connection.id) {
        case everMainnetProtoID:
          list.add(
            ChooseNetworkItemData(
              id: everMainnetProtoID,
              icon: Assets.images.everVector,
              title: LocaleKeys.everscale.tr(),
            ),
          );
          continue;
        case venomMainnetProtoID:
          list.add(
            ChooseNetworkItemData(
              id: venomMainnetProtoID,
              icon: Assets.images.venomVector,
              title: LocaleKeys.venom.tr(),
            ),
          );
          continue;
        case tychoTestnetProtoID:
          list.add(
            ChooseNetworkItemData(
              id: tychoTestnetProtoID,
              icon: Assets.images.tychoVector,
              title: LocaleKeys.tychoTestnet.tr(),
            ),
          );
          continue;
      }
    }

    connectionsState.accept(
      list,
    );
  }
}
