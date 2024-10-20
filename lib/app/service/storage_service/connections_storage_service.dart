import 'dart:convert';

import 'package:app/app/service/nekoton_related/connection_service/network_presets.dart';
import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:rxdart/rxdart.dart';

const _connectionsDomain = 'connections';
const _connectionsKey = 'connections';
const _currentConnectionIdKey = 'current_connection_id';
const _networksIdsKey = 'networks_ids';

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

  /// Subject of current connection id
  final _currentConnectionIdSubject = BehaviorSubject<String>();

  /// Subject of conntection id to network id (global id) map
  /// This map is used to cache network id, which can only be obtained
  /// only from network
  final _networksIdsSubject = BehaviorSubject<Map<String, int>>();

  /// Stream of [ConnectionData] items
  BehaviorSubject<List<ConnectionData>> get connectionsStream =>
      _connectionsSubject;

  /// Stream of currect connection id
  BehaviorSubject<String> get currentConnectionIdStream =>
      _currentConnectionIdSubject;

  /// Stream of conntection id to network id map
  BehaviorSubject<Map<String, int>> get networksIdsStream =>
      _networksIdsSubject;

  /// Get last cached [ConnectionData] items
  List<ConnectionData> get connections => _connectionsSubject.valueOrNull ?? [];

  /// Get last cached current connection id
  String get currentConnectionId => _currentConnectionIdSubject.value;

  /// Get last cached conntection id to network id map
  Map<String, int> get networksIds => _networksIdsSubject.value;

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
  Future<void> _streamedConnections() async => _connectionsSubject.add(
        [...(await readConnections())]..sort(
            (a, b) => (a.sortingOrder - b.sortingOrder).sign.toInt(),
          ),
      );

  /// Put current connection id to stream
  Future<void> _streamedCurrentConnectionId() async =>
      _currentConnectionIdSubject.add(await readCurrentConnectionId());

  Future<void> _streamedNetworksIds() async =>
      _networksIdsSubject.add(await readNetworksIds());

  /// Read list of [ConnectionData] items from presets and storage
  Future<List<ConnectionData>> readConnections() async {
    final encoded = await _storage.get(
      _connectionsKey,
      domain: _connectionsDomain,
    );

    var connections = <ConnectionData>[];

    if (encoded != null) {
      final list = jsonDecode(encoded) as List<dynamic>;
      final customConnections = list
          .map(
            (entry) => ConnectionData.fromJson(entry as Map<String, dynamic>),
          )
          .toList();

      if (customConnections.isNotEmpty) {
        final persistentPresets = networkPresets.where(
          (preset) => !preset.canBeEdited,
        );
        // Remove persistent presets from custom connections
        customConnections.removeWhere(
          (connection) =>
              connection.isPreset && connection.canBeEdited == false,
        );
        // And add them from presets because we want to update them from
        // code
        connections = [...persistentPresets, ...customConnections];
      }
    }

    if (connections.isEmpty) {
      _log.info('Connections not found. Using presets.');
      connections = networkPresets;
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

    final currentId = id ?? defaultConnectionkId;

    _log.info('Current connection id:\n$currentId');

    return currentId;
  }

  /// Read networks ids from storage
  Future<Map<String, int>> readNetworksIds() async {
    final encoded = await _storage.get(
      _networksIdsKey,
      domain: _connectionsDomain,
    );

    var map = <String, int>{};

    if (encoded != null) {
      map = Map.castFrom(jsonDecode(encoded) as Map<String, dynamic>);
    }

    return map;
  }

  /// Save list of [ConnectionData] items to storage
  Future<void> _saveConnections(List<ConnectionData> connections) async {
    await _storage.set(
      _connectionsKey,
      jsonEncode(connections),
      domain: _connectionsDomain,
    );

    await _streamedConnections();
  }

  /// Save current connection id to storage
  Future<void> saveCurrentConnectionId(String id) async {
    var newId = id;
    if (connections.firstWhereOrNull((element) => element.id == id) == null) {
      _log.warning(
        'Trying to set current connection with id $id that not exists. '
        'Setting default connection as current',
      );
      newId = defaultConnectionkId;
    }

    await _storage.set(
      _currentConnectionIdKey,
      newId,
      domain: _connectionsDomain,
    );

    await _streamedCurrentConnectionId();
  }

  /// Save current connection id to storage
  Future<void> updateNetworksIds(Iterable<(String, int)> values) async {
    final map = Map<String, int>.from(networksIds)
      ..addEntries(
        values.map((value) => MapEntry(value.$1, value.$2)),
      );

    await _storage.set(
      _networksIdsKey,
      jsonEncode(map),
      domain: _connectionsDomain,
    );

    await _streamedNetworksIds();
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

    await _storage.delete(
      _networksIdsKey,
      domain: _connectionsDomain,
    );

    await _streamedConnections();
    await _streamedCurrentConnectionId();
    await _streamedNetworksIds();
  }

  /// Add [ConnectionData] item
  Future<void> addConnection(ConnectionData item) async {
    await _saveConnections([...connections, item]);
  }

  /// Remove [ConnectionData] item by id
  Future<void> removeConnection(String id) async {
    if (id == currentConnectionId) {
      _log.info(
        'Trying to remove current connection. '
        'Setting default connection as current',
      );
      await saveCurrentConnectionId(defaultConnectionkId);
    }

    final savedConnections = connections;
    final items = [...savedConnections]..removeWhere((item) => item.id == id);

    await _saveConnections(items);

    inject<MessengerService>().show(
      Message.info(
        message: LocaleKeys.networkDeleted.tr(),
        actionText: LocaleKeys.networkDeletedUndo.tr(),
        onAction: () => _saveConnections(savedConnections),
      ),
    );
  }

  /// Update [ConnectionData] item
  Future<void> updateConnection(ConnectionData item) async {
    final index = connections.indexWhere((element) => element.id == item.id);
    if (index < 0) {
      _log.warning('Unable to update connection with id ${item.id}. '
          'Connection not found.');

      return;
    }
    final newConnections = [...connections];
    newConnections[index] = item;

    await _saveConnections(newConnections);

    inject<MessengerService>().show(
      Message.info(
        message: LocaleKeys.networkSaved.tr(),
      ),
    );
  }

  /// Revert item to defaults from preset
  Future<void> revertConnection(String id) async {
    final preset =
        networkPresets.firstWhereOrNull((element) => element.id == id);
    if (preset == null) {
      _log.warning('Unable to revert connection from preset with id $id. '
          'Connection not found');

      return;
    }

    return updateConnection(preset);
  }

  @override
  Future<void> init() => Future.wait([
        _streamedConnections(),
        _streamedCurrentConnectionId(),
        _streamedNetworksIds(),
      ]);

  @override
  Future<void> clearSensitiveData() => Future.wait([
        clear(),
      ]);
}
