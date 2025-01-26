import 'package:app/app/service/http_clients.dart';
import 'package:app/app/service/service.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@singleton
class ConnectionFactory {
  ConnectionFactory(this._storage);

  final AppStorageService _storage;
  GqlConnection? _connection;

  /// Establishes and returns a GraphQL connection to dton.io.
  /// Returns a [Future] that completes with the established [GqlConnection].
  GqlConnection getTonGqlConnection() => _connection ??= GqlConnection.create(
        name: 'jetton-gql',
        group: 'jetton-gql',
        client: JettonGqlHttpClient(_storage),
        settings: const GqlNetworkSettings(
          endpoints: ['https://dton.io/graphql/graphql'],
          latencyDetectionInterval: 60000,
          maxLatency: 60000,
          endpointSelectionRetryCount: 5,
          local: false,
        ),
      );

  @disposeMethod
  void dispose() {
    _connection?.dispose();
  }
}
