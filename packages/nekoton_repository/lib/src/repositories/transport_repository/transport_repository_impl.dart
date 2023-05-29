import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

/// Implementation of TransportRepository.
/// Usage
/// ```
/// class NekotonRepository with TransportRepositoryImpl {}
/// ```
mixin TransportRepositoryImpl implements TransportRepository {
  final _transportSubject = BehaviorSubject<TransportStrategy>();

  @override
  TransportStrategy get currentTransport => _transportSubject.value;

  @override
  Stream<TransportStrategy> get currentTransportStream =>
      _transportSubject.stream;

  @override
  Future<void> updateTransport(TransportStrategy transport) async {
    final prev = _transportSubject.valueOrNull;
    _transportSubject.add(transport);
    prev?.transport.dispose();
  }

  @override
  Future<GqlTransport> createGqlTransport({
    required GqlConnectionPost post,
    required GqlConnectionGet get,
    required String name,
    required int networkId,
    required String group,
    required List<String> endpoints,
    required bool local,
  }) async {
    final settings = GqlNetworkSettings(
      endpoints: endpoints,
      latencyDetectionInterval: defaultLatencyDetectionInterval,
      maxLatency: defaultMaxLatency,
      endpointSelectionRetryCount: defaultEndpointSelectionRetryCount,
      local: local,
    );

    final connection = await GqlConnection.create(
      post: post,
      get: get,
      name: name,
      networkId: networkId,
      group: group,
      settings: settings,
    );

    return GqlTransport.create(gqlConnection: connection);
  }

  @override
  Future<JrpcTransport> createJrpcTransport({
    required JrpcConnectionPost post,
    required String name,
    required int networkId,
    required String group,
    required String endpoint,
  }) async {
    final settings = JrpcNetworkSettings(endpoint: endpoint);

    final connection = await JrpcConnection.create(
      post: post,
      name: name,
      networkId: networkId,
      group: group,
      settings: settings,
    );

    return JrpcTransport.create(jrpcConnection: connection);
  }
}
