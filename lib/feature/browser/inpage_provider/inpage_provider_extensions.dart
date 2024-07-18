import 'package:app/data/models/models.dart';
import 'package:nekoton_repository/nekoton_repository.dart' as nr;
import 'package:nekoton_webview/nekoton_webview.dart';

const defaultLatencyDetectionInterval = 60000;
const defaultMaxLatency = 60000;

extension ConnectionDataExtension on ConnectionData {
  NetworkConfig get networkConfig => NetworkConfig(
    nativeTokenTicker,
    blockExplorerUrl,
    manifestUrl,
  );

  Object get networkConnection => when<Object>(
    gql: (
        _,
        __,
        ___,
        endpoints,
        ____,
        _____,
        isLocal,
        ______,
        _______,
        ________,
        _________,
        __________,
        ___________,
        ) =>
        GqlConnection('graphql', GqlSocketParams(
            endpoints,
            defaultLatencyDetectionInterval,
            defaultMaxLatency,
            isLocal,
          ),
        ),
    proto: (
        _,
        __,
        ___,
        endpoint,
        ____,
        _____,
        ______,
        _______,
        ________,
        _________,
        __________,
        ) =>
        ProtoConnection('proto', JrpcSocketParams(endpoint)),
    jrpc: (
        _,
        __,
        ___,
        endpoint,
        ____,
        _____,
        ______,
        _______,
        ________,
        _________,
        __________,
        ) => JrpcConnection('jrpc', JrpcSocketParams(endpoint)),
  );
}

extension AddNetworkExtension on AddNetwork {
  ConnectionData get connectionData {
    final json = connection as Map<String, dynamic>;

    if (json['type'] == 'graphql') {
      final c = GqlConnection.fromJson(json);
      return ConnectionData.gqlCustom(
        name: name,
        endpoints: c.data.endpoints,
        isLocal: c.data.local,
        blockExplorerUrl: config?.explorerBaseUrl ?? '',
        manifestUrl: config?.tokensManifestUrl ?? '',
        nativeTokenTicker: config?.symbol ?? '',
      );
    }

    if (json['type'] == 'proto') {
      // JS types workaround: JrpcConnection and ProtoConnection are the same
      final c = JrpcConnection.fromJson(json);
      return ConnectionData.protoCustom(
        name: name,
        endpoint: (c.data as JrpcSocketParams).endpoint,
        blockExplorerUrl: config?.explorerBaseUrl ?? '',
        manifestUrl: config?.tokensManifestUrl ?? '',
        nativeTokenTicker: config?.symbol ?? '',
      );
    }

    if (json['type'] == 'jrpc') {
      final c = JrpcConnection.fromJson(json);
      return ConnectionData.jrpcCustom(
        name: name,
        endpoint: c.data.endpoint,
        blockExplorerUrl: config?.explorerBaseUrl ?? '',
        manifestUrl: config?.tokensManifestUrl ?? '',
        nativeTokenTicker: config?.symbol ?? '',
      );
    }

    throw Exception('Unsupported connection type: ${toJson()}');
  }
}

extension TransportExtension on nr.Transport {
  Future<NetworkDescription> getNetworkDescription() async {
    final config = await getBlockchainConfig();
    final signatureId = await getSignatureId();

    return NetworkDescription(
      config.globalId,
      '0x${config.capabilities.toRadixString(16)}',
      signatureId,
    );
  }
}
