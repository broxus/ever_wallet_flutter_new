import 'package:app/app/service/nekoton_related/connection_service/network_presets.dart';
import 'package:app/app/service/storage_service/connections_storage_service.dart';
import 'package:app/v2/feature/choose_network/choose_network_screen.dart';
import 'package:app/v2/feature/choose_network/data/choose_network_item_data.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

/// [ElementaryModel] for [ChooseNetworkScreen]
class ChooseNetworkScreenModel extends ElementaryModel {
  ChooseNetworkScreenModel(
    ErrorHandler errorHandler,
    this._connectionsStorageService,
  ) : super(errorHandler: errorHandler);

  final ConnectionsStorageService _connectionsStorageService;

  final connectionsState = StateNotifier<List<ChooseNetworkItemData>>(
    initValue: [],
  );

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
    } on Object catch (_) {
      // TODO(knightforce): show error with elementary error handler
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
              networkType: ChooseNetworkType.ever,
            ),
          );
          continue;
        case venomMainnetProtoID:
          list.add(
            ChooseNetworkItemData(
              id: venomMainnetProtoID,
              networkType: ChooseNetworkType.venom,
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
