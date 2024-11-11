import 'dart:async';
import 'dart:math';

import 'package:darttonconnect/models/wallet_app.dart';
import 'package:darttonconnect/ton_connect.dart';

const _manifestUrl = 'https://l.sparxwallet.com/tonconnect-manifest.json';

final _r = Random();

class CustomTonConnector {
  CustomTonConnector() {
    id = _r.nextInt(1000);
    _init();
  }

  late final int id;

  late final Stream<dynamic> statusStream = _statusSubject.stream;

  late final _connector = TonConnect(_manifestUrl);

  late final _statusSubject = StreamController<StatusData?>.broadcast();

  WalletApp? _currentWalletApp;

  Function? _unSubscriber;

  String? get currentUrl => _currentWalletApp?.universalUrl;

  bool get isConnected => _connector.connected;

  Future<String?> connect(
    TonConnectData data, {
    bool? isReplaceConnection,
  }) async {
    if (isReplaceConnection ?? true) {
      await disconnect();
    }

    final walletApp = WalletApp(
      name: data.name,
      bridgeUrl: data.bridgeUrl,
      image: data.iconUrl,
      aboutUrl: data.aboutUrl,
      universalUrl: data.targetManifestUrl,
    );

    final link = await _connector.connect(walletApp);

    _currentWalletApp = walletApp;

    return link;
  }

  Future<void> disconnect() async {
    if (isConnected) {
      return _connector.disconnect();
    }
    return;
  }

  Future<bool> restoreConnection() async {
    if (isConnected) {
      return false;
    }

    return _connector.restoreConnection();
  }

  void dispose() {
    _unSubscribe();
  }

  Future<dynamic> sendTransaction(
    Map<String, dynamic> transactionData,
  ) async {
    if (!isConnected) {
      return;
    }

    return _connector.sendTransaction(transactionData);
  }

  void _init() {
    _unSubscriber = _connector.onStatusChange(_onStatusChange);
  }

  void _unSubscribe() {
    _unSubscriber?.call();
  }

  void _onStatusChange(dynamic value) {
    _statusSubject.add(
      StatusData(
        id: id,
        url: currentUrl,
        value: value,
      ),
    );
  }
}

class TonConnectData {
  const TonConnectData({
    required this.targetManifestUrl,
    required this.name,
    required this.bridgeUrl,
    required this.aboutUrl,
    required this.iconUrl,
  });

  final String targetManifestUrl;
  final String name;
  final String bridgeUrl;
  final String aboutUrl;
  final String iconUrl;
}

class StatusData {
  const StatusData({
    required this.id,
    this.url,
    required this.value,
  });

  final int id;
  final String? url;
  final dynamic value;
}
