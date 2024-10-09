import 'package:app/app/router/router.dart';
import 'package:app/app/service/nekoton_related/connection_service/transport_strategies/transport_strategies.dart';
import 'package:app/data/models/models.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart'
    show GqlTransport, TransportStrategy;
import 'package:nekoton_webview/nekoton_webview.dart';

/// Open new tab in browser with [url].
/// This is ridiculous, but we need to navigate to browser page first and then
/// navigate to it second time, after StatefulShellRoute is set up.
void browserNewTab(BuildContext context, String url) {
  context.goNamed(
    AppRoute.browser.name,
  );
  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.goNamed(
      AppRoute.browser.name,
      queryParameters: {
        browserUrlQueryParam: url,
      },
    );
  });
}

extension TransportExtension on TransportStrategy {
  ConnectionData? get connection => switch (this) {
        EverTransportStrategy(:final connection) => connection,
        VenomTransportStrategy(:final connection) => connection,
        CustomTransportStrategy(:final connection) => connection,
        _ => null,
      };

  Future<Network> toNetwork() async {
    final data = connection;
    final config = await transport.getBlockchainConfig();
    final signatureId = await transport.getSignatureId();
    final capabilities = config.capabilities.toRadixString(16);

    if (data == null) {
      throw UnsupportedError('Unsupported type: $runtimeType');
    }

    return Network(
      data.name,
      NetworkDescription(
        config.globalId,
        '0x$capabilities',
        signatureId,
      ),
      data.when(
        gql: (
          id,
          name,
          group,
          endpoints,
          timeout,
          networkType,
          isLocal,
          blockExplorerUrl,
          manifestUrl,
          nativeTokenTicker,
          isPreset,
          canBeEdited,
          sortingOrder,
        ) {
          final settings = (transport as GqlTransport).gqlConnection.settings;
          return GqlConnection(
            'graphql',
            GqlSocketParams(
              endpoints,
              settings.latencyDetectionInterval,
              settings.maxLatency,
              isLocal,
            ),
          );
        },
        proto: (
          id,
          name,
          group,
          endpoint,
          networkType,
          blockExplorerUrl,
          manifestUrl,
          nativeTokenTicker,
          isPreset,
          canBeEdited,
          sortingOrder,
        ) =>
            ProtoConnection('proto', JrpcSocketParams(endpoint)),
        jrpc: (
          id,
          name,
          group,
          endpoint,
          networkType,
          blockExplorerUrl,
          manifestUrl,
          nativeTokenTicker,
          isPreset,
          canBeEdited,
          sortingOrder,
        ) =>
            JrpcConnection('jrpc', JrpcSocketParams(endpoint)),
      ),
      NetworkConfig(
        data.nativeTokenTicker,
        data.blockExplorerUrl,
        data.manifestUrl,
      ),
    );
  }
}
