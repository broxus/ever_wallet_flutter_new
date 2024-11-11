import 'package:app/app/service/ton/custom_ton_connector.dart';
import 'package:app/http/api/ton/ton_api.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@lazySingleton
class TonService {
  TonService(
    this._tonApi,
  );

  final TonApi _tonApi;

  final _connector = CustomTonConnector();

  Future<void> connect(
    String targetManifestUrl, {
    bool? isReplaceConnection,
  }) async {
    final data = await _tonApi.fetchManifest(targetManifestUrl);

    final link = await _connector.connect(
      TonConnectData(
        name: data.name,
        iconUrl: data.iconUrl,
        bridgeUrl: 'https://bridge.tonapi.io/bridge',
        aboutUrl: data.url,
        targetManifestUrl: targetManifestUrl,
      ),
      isReplaceConnection: isReplaceConnection,
    );

    if (link == null) {
      return;
    }

    final uri = Uri.parse(link);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> disconnect() {
    return _connector.disconnect();
  }

  Future<bool> restoreConnection() {
    return _connector.restoreConnection();
  }

  Future<dynamic> sendTransaction(
    Map<String, dynamic> transactionData,
  ) async {
    return _connector.sendTransaction(transactionData);
  }

  Future<dynamic> sendTransactionSafe(
    Map<String, dynamic> transactionData,
  ) async {
    try {
      return await sendTransaction(transactionData);
    } catch (e) {
      return;
    }
  }

  @disposeMethod
  void dispose() {
    _connector.dispose();
  }
}
