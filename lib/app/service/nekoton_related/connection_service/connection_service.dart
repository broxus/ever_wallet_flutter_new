import 'package:app/app/service/nekoton_related/connection_service/transport_strategies/transport_strategies.dart';
import 'package:app/app/service/service.dart';
import 'package:app/data/models/connection_data.dart';
import 'package:app/data/models/network_type.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

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

    // skip 1 due to duplicate events
    _storageService.currentConnectionStream.skip(1).listen((connection) async {
      _log.info('setUp: switching to ${connection.name}');
      await _updateTransportByConnection(connection);
    });
  }

  /// Create nekoton's transport by connection, create transport's strategy
  /// by its type and put it in nekoton.
  // ignore: long-method
  Future<void> _updateTransportByConnection(ConnectionData connection) async {
    _log.finest('updateTransportByConnection: ${connection.name}');
    try {
      final transport = await connection.when<Future<Transport>>(
        gql: (
          _,
          name,
          group,
          endpoints,
          timeout,
          __,
          isLocal,
          ___,
          ____,
          _____,
          ______,
          _______,
          ________,
        ) =>
            _nekotonRepository.createGqlTransport(
          post: _httpService.postTransportData,
          get: _httpService.getTransportData,
          name: name,
          group: group,
          endpoints: endpoints,
          local: isLocal,
        ),
        proto: (
          _,
          name,
          group,
          endpoint,
          __,
          ___,
          ____,
          _____,
          ______,
          _______,
          ________,
        ) =>
            _nekotonRepository.createProtoTransport(
          post: _httpService.postTransportDataBytes,
          name: name,
          group: group,
          endpoint: endpoint,
        ),
        jrpc: (
          _,
          name,
          group,
          endpoint,
          __,
          ___,
          ____,
          _____,
          ______,
          _______,
          ________,
        ) =>
            _nekotonRepository.createJrpcTransport(
          post: _httpService.postTransportData,
          name: name,
          group: group,
          endpoint: endpoint,
        ),
      );

      await _nekotonRepository.updateTransport(
        _createStrategyByConnection(transport, connection),
      );
      _log.finest('updateTransportByConnection completed!');
    } catch (e, t) {
      inject<MessengerService>().showConnectionError();
      _log.severe('updateTransportByConnection', e, t);

      // allow level above to track fail
      rethrow;
    }
  }

  /// Create TransportStrategy based on [ConnectionData.networkType] of
  /// [connection] data.
  TransportStrategy _createStrategyByConnection(
    Transport transport,
    ConnectionData connection,
  ) {
    switch (connection.networkType) {
      case NetworkType.ever:
        return EverTransportStrategy(
          transport: transport,
          connection: connection,
        );
      case NetworkType.venom:
        return VenomTransportStrategy(
          transport: transport,
          connection: connection,
        );
      case NetworkType.custom:
        return CustomTransportStrategy(
          transport: transport,
          connection: connection,
        );
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
