import 'package:nekoton_repository/nekoton_repository.dart';

/// Timeout in milliseconds, that is used to find network connection.
const defaultLatencyDetectionInterval = 60000;

/// Timeout in milliseconds that is used to make network call.
const defaultMaxLatency = 60000;

/// How many times transport must try to check network connection if internet
/// was lost.
const defaultEndpointSelectionRetryCount = 5;

/// Repository that allows listen for transport changes in application
/// and change it.
abstract class TransportRepository {
  /// This returns current transport wrapped with its strategy.
  TransportStrategy get currentTransport;

  /// Stream to listen transport changes wrapped in its strategy.
  Stream<TransportStrategy> get currentTransportStream;

  /// This method allows change [currentTransport] and trigger different parts
  /// of application to change its state.
  ///
  /// !!! This method must be called during app initialization to set up
  /// transport first time
  /// !!!
  ///
  /// To create [Transport] instances, use [createGqlTransport] or
  /// [createJrpcTransport] and wrap it in suitable strategy based on its type.
  Future<void> updateTransport(TransportStrategy transport);

  /// This allows create GQL based transport from application.
  ///
  /// !!! This method do not modify [currentTransport]. To do it, use
  /// [updateTransport].
  Future<GqlTransport> createGqlTransport({
    required GqlConnectionPost post,
    required GqlConnectionGet get,
    required String name,
    required int networkId,
    required String group,
    required List<String> endpoints,
    required bool local,
  });

  /// This allows create JRPC based transport from application.
  ///
  /// !!! This method do not modify [currentTransport]. To do it, use
  /// [updateTransport].
  Future<JrpcTransport> createJrpcTransport({
    required JrpcConnectionPost post,
    required String name,
    required int networkId,
    required String group,
    required String endpoint,
  });
}
