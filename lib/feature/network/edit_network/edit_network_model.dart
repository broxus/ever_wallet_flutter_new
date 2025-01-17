import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/app/service/presets_connection/presets_connection_service.dart';
import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';

class EditNetworkModel extends ElementaryModel {
  EditNetworkModel(
    this._connectionsStorageService,
    this._presetsConnectionService,
  );

  final ConnectionsStorageService _connectionsStorageService;
  final PresetsConnectionService _presetsConnectionService;

  List<ConnectionData> get connections =>
      _connectionsStorageService.connections;

  List<String>? get networkTypesOptions =>
      _presetsConnectionService.customNetworkOptions;

  void addConnection(ConnectionData connection) =>
      _connectionsStorageService.addConnection(connection);

  void updateConnection(ConnectionData connection) =>
      _connectionsStorageService.updateConnection(connection);

  void removeConnection(String id) =>
      _connectionsStorageService.removeConnection(id);

  void saveCurrentConnectionId(String id) =>
      _connectionsStorageService.saveCurrentConnectionId(id);
}
