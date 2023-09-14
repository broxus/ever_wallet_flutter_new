import 'dart:convert';

import 'package:app/app/service/nekoton_related/connection_service/network_presets.dart';
import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:collection/collection.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

const _connectionsDomain = 'connections';
const _connectionsKey = 'connections';
const _currentConnectionIdKey = 'current_connection_id';

/// This is a wrapper-class above [EncryptedStorage] that provides methods
/// to interact with custom connection - related data.
@singleton
class ConnectionsStorageService extends AbstractStorageService {
  ConnectionsStorageService(this._storage);

  final _log = Logger('ConnectionsStorageService');

  /// Storage that is used to store data
  final EncryptedStorage _storage;

  /// Subject of [ConnectionData] items
  final _connectionsSubject = BehaviorSubject<List<ConnectionData>>();

  /// Subject of currect connection id
  final _currentConnectionIdSubject = BehaviorSubject<String>();

  /// Stream of [ConnectionData] items
  BehaviorSubject<List<ConnectionData>> get connectionsStream =>
      _connectionsSubject;

  /// Stream of currect connection id
  BehaviorSubject<String> get currentConnectionIdStream =>
      _currentConnectionIdSubject;

  /// Get last cached [ConnectionData] items
  List<ConnectionData> get connections => _connectionsSubject.valueOrNull ?? [];

  /// Get last cached current connection id
  String get currentConnectionId => _currentConnectionIdSubject.value;

  /// Stream of currect connection id
  Stream<ConnectionData> get currentConnectionStream => Rx.combineLatest2(
        connectionsStream,
        currentConnectionIdStream,
        (connections, currentConnectionId) => connections.firstWhere(
          (connection) => connection.id == currentConnectionId,
          orElse: () {
            _log.warning(
              'Current connection with id $currentConnectionId not found. '
              'Returning default connection',
            );

            return defaultNetwork;
          },
        ),
      );

  // Get last cached currect connection
  ConnectionData get currentConnection {
    final connections = this.connections;
    final currentConnectionId = this.currentConnectionId;

    return connections.firstWhere(
      (connection) => connection.id == currentConnectionId,
      orElse: () {
        _log.warning(
          'Current connection with id $currentConnectionId not found. '
          'Returning default connection',
        );

        return defaultNetwork;
      },
    );
  }

  /// Put [ConnectionData] items to stream
  Future<void> _streamedConnections() async =>
      _connectionsSubject.add(await readConnections());

  /// Put current connection id to stream
  Future<void> _streamedCurrentConnectionId() async =>
      _currentConnectionIdSubject.add(await readCurrentConnectionId());

  /// Read list of [ConnectionData] items from presets and storage
  Future<List<ConnectionData>> readConnections() async {
    final encoded = await _storage.get(
      _connectionsKey,
      domain: _connectionsDomain,
    );

    // Return presets and custom connections
    var connections = networkPresets;

    if (encoded != null) {
      final list = jsonDecode(encoded) as List<dynamic>;
      final customConnections = list
          .map(
            (entry) => ConnectionData.fromJson(entry as Map<String, dynamic>),
          )
          .toList();

      connections = [
        ...connections,
        ...customConnections,
      ];
    }

    final connectionsText = connections
        .map(
          (connection) => 'name: ${connection.name} '
              'networkType: ${connection.networkType} '
              'isPreset: ${connection.isPreset} '
              'id: ${connection.id}',
        )
        .join(',\n');
    _log.info('Connections:\n$connectionsText');

    return connections;
  }

  /// Read current connection id from storage
  Future<String> readCurrentConnectionId() async {
    final id = await _storage.get(
      _currentConnectionIdKey,
      domain: _connectionsDomain,
    );

    final currentId = id ?? defaultNetworkId;

    _log.info('Current connection id:\n$currentId');

    return currentId;
  }

  /// Save list of [ConnectionData] items to storage
  Future<void> saveConnections(List<ConnectionData> connections) async {
    // Write only custom connections
    final customConnections =
        connections.where((connection) => !connection.isPreset).toList();

    await _storage.set(
      _connectionsKey,
      jsonEncode(customConnections),
      domain: _connectionsDomain,
    );

    await _streamedConnections();
  }

  /// Save list of [ConnectionData] items to storage
  Future<void> saveCurrentConnectionId(String id) async {
    var newId = id;
    if (connections.firstWhereOrNull((element) => element.id == id) == null) {
      _log.warning(
        'Trying to set current connection with id $id that not exists. '
        'Setting default connection as current',
      );
      newId = defaultNetworkId;
    }

    await _storage.set(
      _currentConnectionIdKey,
      newId,
      domain: _connectionsDomain,
    );

    await _streamedCurrentConnectionId();
  }

  /// Clear [ConnectionData] list
  Future<void> clear() async {
    await _storage.delete(
      _connectionsKey,
      domain: _connectionsDomain,
    );

    await _storage.delete(
      _currentConnectionIdKey,
      domain: _connectionsDomain,
    );

    await _streamedConnections();
    await _streamedCurrentConnectionId();
  }

  /// Add [ConnectionData]
  Future<void> addConnection(ConnectionData item) async {
    await saveConnections([...connections, item]);
  }

  /// Remove [ConnectionData] item by id
  Future<void> removeConnection(String id) async {
    if (id == currentConnectionId) {
      _log.warning(
        'Trying to remove current connection. '
        'Setting default connection as current',
      );
    }

    final items = [...connections]..removeWhere((item) => item.id == id);

    await saveCurrentConnectionId(defaultNetworkId);
    await saveConnections(items);
  }

  @override
  Future<void> init() => Future.wait([
        _streamedConnections(),
        _streamedCurrentConnectionId(),
      ]);

  @override
  Future<void> clearSensitiveData() => Future.wait([
        clear(),
      ]);
}
