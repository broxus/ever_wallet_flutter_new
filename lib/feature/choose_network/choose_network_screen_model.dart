import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/app/service/nekoton_related/connection_service/network_presets.dart';
import 'package:app/app/service/network_connection/network_connection_service.dart';
import 'package:app/app/service/storage_service/connections_storage_service.dart';
import 'package:app/feature/choose_network/choose_network_screen.dart';
import 'package:app/feature/choose_network/data/choose_network_item_data.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

/// [ElementaryModel] for [ChooseNetworkScreen]
class ChooseNetworkScreenModel extends ElementaryModel {
  ChooseNetworkScreenModel(
    ErrorHandler errorHandler,
    this._connectionsStorageService,
    this._messengerService,
    this._networkConnectionService,
  ) : super(errorHandler: errorHandler);

  final ConnectionsStorageService _connectionsStorageService;
  final MessengerService _messengerService;
  final NetworkConnectionService _networkConnectionService;

  final connectionsState = StateNotifier<List<ChooseNetworkItemData>>(
    initValue: [],
  );

  Future<bool> get isConnected => _networkConnectionService.isConnected;

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

  Future<bool> selectType(String id) async {
    try {
      await _connectionsStorageService.saveCurrentConnectionId(id);
    } on Object catch (e) {
      _messengerService.show(
        Message.error(
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
              description: LocaleKeys.chooseNetworkEverDescription.tr(),
            ),
          );
          continue;
        case venomMainnetProtoID:
          list.add(
            ChooseNetworkItemData(
              id: venomMainnetProtoID,
              icon: Assets.images.venomVector,
              title: LocaleKeys.venom.tr(),
              description: LocaleKeys.chooseNetworkVenomDescription.tr(),
            ),
          );
          continue;
      }
    }

    connectionsState.accept(
      list,
    );
  }

  void showConnectionError() {
    _messengerService.show(
      Message.error(
        message: LocaleKeys.connectingNetworkFailed.tr(),
      ),
    );
  }
}
