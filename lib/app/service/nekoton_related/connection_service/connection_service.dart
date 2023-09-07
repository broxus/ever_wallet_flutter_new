import 'package:app/app/service/nekoton_related/connection_service/transport_strategies/transport_strategies.dart';
import 'package:app/app/service/service.dart';
import 'package:app/data/models/connection_data.dart';
import 'package:app/data/models/network_type.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide ConnectionData;

/// This is a service that switches between connections by creating
/// [Transport] and putting it in [NekotonRepository]. It has no public
/// methods, it uses [ConnectionsStorageService] as a source of connection
/// data.
/// The app should use [ConnectionsStorageService] to interact with
/// connection-related data.
@singleton
class ConnectionService {
  ConnectionService(
    this._storageService,
    this._nekotonRepository,
    this._httpService,
  );

  static final _log = Logger('ConnectionService');

  final HttpService _httpService;
  final ConnectionsStorageService _storageService;
  final NekotonRepository _nekotonRepository;

  /// Set up selected connection.
  Future<void> setUp() async {
    final connection = _storageService.currentConnection;
    _log.info('setUp: starting with ${connection.name}');
    await _updateTransportByConnection(connection);

    _storageService.currentConnectionStream.listen((connection) async {
      _log.info('setUp: switching to ${connection.name}');
      await _updateTransportByConnection(connection);
    });
  }

  /// Create nekoton's transport by connection, create transport's strategy
  /// by its type and put it in nekoton.
  Future<void> _updateTransportByConnection(ConnectionData connection) async {
    _log.finest('updateTransportByConnection: ${connection.name}');
    final type = connection.networkType;

    final transport = await connection.when<Future<Transport>>(
      gql: (_, name, networkId, group, endpoints, timeout, __, ___) =>
          _nekotonRepository.createGqlTransport(
        post: _httpService.postTransportData,
        get: _httpService.getTransportData,
        name: name,
        networkId: networkId,
        group: group,
        endpoints: endpoints,
        local: false,
      ),
      proto: (_, name, networkId, group, endpoint, __, ___) =>
          _nekotonRepository.createProtoTransport(
        post: _httpService.postTransportDataBytes,
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
