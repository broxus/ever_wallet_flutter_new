import 'package:app/app/service/ton/custom_ton_connector.dart';
import 'package:app/http/api/ton/ton_api.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class TonService {
  TonService(this._tonApi);

  final TonApi _tonApi;

  late final _connectors = <int, CustomTonConnector>{};

  CustomTonConnector? getConnectorById(int id) {
    return _connectors[id];
  }

  Future<String?> connect(
    CustomTonConnector connector,
    String targetManifestUrl, {
    bool? isReplaceConnection,
  }) async {
    final data = await _tonApi.fetchManifest(targetManifestUrl);

    return connector.connect(
      TonConnectData(
        name: data.name,
        iconUrl: data.iconUrl,
        aboutUrl: data.url,
        targetManifestUrl: targetManifestUrl,
      ),
      isReplaceConnection: isReplaceConnection,
    );
  }

  Future<String?> connectById(
    int connectorId,
    String targetManifestUrl, {
    bool? isReplaceConnection,
  }) async {
    final connector = _connectors[connectorId];

    if (connector == null) {
      return null;
    }

    return connect(
      connector,
      targetManifestUrl,
      isReplaceConnection: isReplaceConnection,
    );
  }

  Future<(CustomTonConnector, String?)?> createAndConnect(
    String targetManifestUrl, {
    bool? isReplaceConnection,
  }) async {
    final connector = CustomTonConnector();
    _connectors[connector.id] = connector;

    final link = await connect(
      connector,
      targetManifestUrl,
      isReplaceConnection: isReplaceConnection,
    );

    return (connector, link);
  }

  Future<void> disconnectById(int id) async {
    final connector = _connectors[id];

    if (connector == null) {
      return;
    }

    return connector.disconnect();
  }

  Future<void> disconnectAll() async {
    final connectors = _connectors.values;

    for (final connector in connectors) {
      await connector.disconnect();
    }
  }

  void restoreConnections() {
    _connectors.forEach((_, connector) {
      connector.restoreConnection();
    });
  }

  Future<dynamic> sendTransaction(
    int id,
    Map<String, dynamic> transactionData,
  ) async {
    return _connectors[id]?.sendTransaction(transactionData);
  }

  Future<dynamic> sendTransactionSafe(
    int id,
    Map<String, dynamic> transactionData,
  ) async {
    try {
      return await sendTransaction(id, transactionData);
    } catch (e) {
      return;
    }
  }

  @disposeMethod
  void dispose() {
    final connectors = _connectors.values;

    for (final connector in connectors) {
      connector.dispose();
    }
  }
}
