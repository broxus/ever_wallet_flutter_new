import 'package:app/app/service/nekoton_related/connection_service/network_presets.dart';
import 'package:app/app/service/nekoton_related/connection_service/transport_strategies/transport_strategies.dart';
import 'package:app/app/service/remote/http_service.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/data/models/connection_data.dart';
import 'package:app/data/models/network_type.dart';
import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide ConnectionData;

/// This is a service that stores information about different connections
@singleton
class ConnectionService {
  ConnectionService(
    this._storageService,
    this._nekotonRepository,
    this._httpService,
  );

  static final _log = Logger('ConnectionService');

  final HttpService _httpService;
  final GeneralStorageService _storageService;
  final NekotonRepository _nekotonRepository;

  /// This is useful to iterate over connections to find correct one.
  List<ConnectionData> get allConnections => [
        ...everPresets,
        ...venomPresets,
        ...customPresets,
        // TODO(alex-a4): add custom connections from storage when implemented
      ];

  // TODO(alex-a4): add getting custom connections from storage when implemented
  /// Set up first connection for app working.
  /// If app started first time, first ever connection will be used.
  Future<void> setUp() async {
    final lastConnectionName = _storageService.currentConnection;
    var connection =
        allConnections.firstWhereOrNull((c) => c.name == lastConnectionName);
    if (connection == null) {
      connection = everPresets.first;
      await _storageService.setCurrentConnection(connection.name);
    }
    await _updateTransportByConnection(connection);
  }

  /// Change connection of application.
  /// Typically it's called when user change connection in settings.
  Future<void> changeConnection(ConnectionData connection) async {
    await _storageService.setCurrentConnection(connection.name);
    await _updateTransportByConnection(connection);
  }

  /// Create nekoton's transport by connection, create transport's strategy
  /// by its type and put it in nekoton.
  Future<void> _updateTransportByConnection(ConnectionData connection) async {
    _log.finest('updateTransportByConnection: ${connection.name}');
    final type = connection.networkType;

    final transport = await connection.when<Future<Transport>>(
      gql: (name, networkId, group, endpoints, timeout, local, _) =>
          _nekotonRepository.createGqlTransport(
        post: _httpService.postTransportData,
        get: _httpService.getTransportData,
        name: name,
        networkId: networkId,
        group: group,
        endpoints: endpoints,
        local: local,
      ),
      jrpc: (name, networkId, group, endpoint, _) =>
          _nekotonRepository.createJrpcTransport(
        post: _httpService.postTransportData,
        name: name,
        networkId: networkId,
        group: group,
        endpoint: endpoint,
      ),
    );

    await _nekotonRepository.updateTransport(
      _createStrategyByType(type, transport),
    );
    _log.finest('updateTransportByConnection completed!');
  }

  /// Create TransportStrategy based on [type] of connection data.
  TransportStrategy _createStrategyByType(
    NetworkType type,
    Transport transport,
  ) {
    switch (type) {
      case NetworkType.ever:
        return EverTransportStrategy(transport: transport);
      case NetworkType.venom:
        return VenomTransportStrategy(transport: transport);
      case NetworkType.custom:
        return CustomTransportStrategy(transport: transport);
    }
  }
}

extension TransportTypeExtension on TransportStrategy {
  NetworkType get networkType {
    if (this is EverTransportStrategy) {
      return NetworkType.ever;
    } else if (this is VenomTransportStrategy) {
      return NetworkType.venom;
    } else {
      return NetworkType.custom;
    }
  }
}
