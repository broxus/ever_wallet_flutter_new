import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';

class EditNetworkModel extends ElementaryModel {
  EditNetworkModel(
    this._connectionsStorageService,
  );

  final ConnectionsStorageService _connectionsStorageService;

  List<ConnectionData> get connections =>
      _connectionsStorageService.connections;

  void addConnection(ConnectionData connection) =>
      _connectionsStorageService.addConnection(connection);

  void updateConnection(ConnectionData connection) =>
      _connectionsStorageService.updateConnection(connection);

  void removeConnection(String id) =>
      _connectionsStorageService.removeConnection(id);
}
