import 'package:app/app/service/connection/connection_service/http_clients.dart';
import 'package:app/app/service/connection/connection_service/transport_strategies/custom_transport_strategy.dart';
import 'package:app/app/service/connection/connection_service/transport_strategies/ever_transport_strategy.dart';
import 'package:app/app/service/connection/connection_service/transport_strategies/tycho_transport_strategy.dart';
import 'package:app/app/service/connection/connection_service/transport_strategies/venom_transport_strategy.dart';
import 'package:app/app/service/connection/presets_connection/presets_connection_service.dart';
import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
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
    this._presetsConnectionService,
  );

  static final _log = Logger('ConnectionService');

  final ConnectionsStorageService _storageService;
  final NekotonRepository _nekotonRepository;
  final PresetsConnectionService _presetsConnectionService;

  /// Set up selected connection.
  Future<bool> setUp() async {
    await _presetsConnectionService.fetchConnectionsList();

    final connection = _storageService.currentConnection;

    if (connection == null) {
      return false;
    }

    _log.info('setUp: starting with ${connection.name}');
    await _updateTransportByConnection(connection);

    // skip 1 due to duplicate events
    _storageService.currentConnectionStream.skip(1).listen((connection) async {
      _log.info('setUp: switching to ${connection?.name}');
      if (connection != null) {
        await _updateTransportByConnection(connection);
      }
    });

    return true;
  }

  /// Create TransportStrategy based on [ConnectionData.networkType] of
  /// [connection] data.
  TransportStrategy createStrategyByConnection(
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
      case NetworkType.tycho:
        return TychoTransportStrategy(
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

  Future<Transport> createTransportByConnection(ConnectionData connection) {
    return connection.when<Future<Transport>>(
      gql: (
        _,
        name,
        group,
        endpoints,
        __,
        isLocal,
        ___,
        ____,
        _____,
        ______,
        _______,
        ________,
        latencyDetectionInterval,
        maxLatency,
        endpointSelectionRetryCount,
      ) =>
          _nekotonRepository.createGqlTransport(
        client: GqlHttpClient(),
        name: name,
        group: group,
        endpoints: endpoints,
        local: isLocal,
        latencyDetectionInterval: latencyDetectionInterval,
        maxLatency: maxLatency,
        endpointSelectionRetryCount: endpointSelectionRetryCount,
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
        client: ProtoHttpClient(),
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
        client: JrpcHttpClient(),
        name: name,
        group: group,
        endpoint: endpoint,
      ),
    );
  }

  /// Create nekoton's transport by connection, create transport's strategy
  /// by its type and put it in nekoton.
  // ignore: long-method
  Future<void> _updateTransportByConnection(ConnectionData connection) async {
    _log.finest('updateTransportByConnection: ${connection.name}');
    try {
      final transport = await createTransportByConnection(connection);

      await _nekotonRepository.updateTransport(
        createStrategyByConnection(transport, connection),
      );
      _storageService.updateNetworksIds(
        [(connection.id, transport.networkId)],
      );

      _log.finest('updateTransportByConnection completed!');
    } catch (e, t) {
      inject<MessengerService>().showConnectionError(null);
      _log.severe('updateTransportByConnection', e, t);

      final base = _storageService.baseConnection;

      if (base != null && base.id != connection.id) {
        _storageService.saveCurrentConnectionId(base.id);
        return;
      }

      /// Тут. Вернуть на 1 сеть
      // allow level above to track fail
      rethrow;
    }
  }
}

extension TransportTypeExtension on TransportStrategy {
  NetworkType get networkType {
    if (this is EverTransportStrategy) {
      return NetworkType.ever;
    } else if (this is VenomTransportStrategy) {
      return NetworkType.venom;
    } else if (this is TychoTransportStrategy) {
      return NetworkType.tycho;
    } else {
      return NetworkType.custom;
    }
  }
}

// final _jsonTest = {
//   "default_connection_id": "preset_ever_mainnet_proto",
//   "networks": [
//     {
//       "type": "proto",
//       "id": "preset_ever_mainnet_proto",
//       "name": "Everscale",
//       "group": "mainnet",
//       "endpoint": "https://jrpc.everwallet.net",
//       "networkType": "ever", // NetworkType.ever,
//       "blockExplorerUrl": "https://everscan.io",
//       "manifestUrl":
//           "https://raw.githubusercontent.com/broxus/ton-assets/master/manifest.json",
//       "sortingOrder": 1
//     },
//     {
//       "type": "gql",
//       "id": "preset_ever_mainnet_gql",
//       "name": "Everscale (reserve)",
//       "group": "mainnet",
//       "endpoints": [
//         "https://mainnet.evercloud.dev/89a3b8f46a484f2ea3bdd364ddaee3a3/graphql"
//       ],
//       "networkType": "ever", //NetworkType.ever,
//       "blockExplorerUrl": "https://everscan.io",
//       "manifestUrl":
//           "https://raw.githubusercontent.com/broxus/ton-assets/master/manifest.json",
//       "sortingOrder": 2
//     },
//     {
//       "type": "proto",
//       "id": "preset_venom_mainnet_proto",
//       "name": "Venom",
//       "group": "venom_mainnet",
//       "endpoint": "https://jrpc.venom.foundation",
//       "networkType": "venom", //NetworkType.venom,
//       "blockExplorerUrl": "https://venomscan.com",
//       "manifestUrl":
//           "https://cdn.venom.foundation/assets/mainnet/manifest.json",
//       "sortingOrder": 3
//     },
//     {
//       "type": "proto",
//       "id": "preset_tycho_testnet_proto",
//       "name": "Tycho Testnet",
//       "group": "tycho_testnet",
//       "endpoint": "https://rpc-testnet.tychoprotocol.com/",
//       "networkType": "tycho", //NetworkType.tycho
//       "blockExplorerUrl": "https://testnet.tychoprotocol.com/",
//       "manifestUrl":
//           "https://raw.githubusercontent.com/broxus/ton-assets/refs/heads/tychotestnet/manifest.json",
//       "sortingOrder": 4
//     }
//   ]
// };
