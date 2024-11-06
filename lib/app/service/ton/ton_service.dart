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
    String manifestUrl, {
    int? id,
  }) async {
    final connector = _connectors[id] ?? CustomTonConnector();
    _connectors[connector.id] ??= connector;

    final data = await _tonApi.fetchManifest(manifestUrl);

    return connector.connect(
      TonConnectData(
        name: data.name,
        iconUrl: data.iconUrl,
        url: data.url,
        manifestUrl: manifestUrl,
      ),
    );
  }

  void disconnectAll() {
    _connectors.forEach((id, _) {
      disconnect(id);
    });
  }

  void disconnect(int id) {
    final connector = _connectors[id];

    if (connector == null) {
      return;
    }

    connector.disconnect();
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

  @disposeMethod
  void dispose() {
    disconnectAll();
  }
}
