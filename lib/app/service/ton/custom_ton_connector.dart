import 'dart:async';
import 'dart:math';

import 'package:darttonconnect/exceptions.dart';
import 'package:darttonconnect/models/wallet_app.dart';
import 'package:darttonconnect/ton_connect.dart';

const _manifestUrl = 'https://l.sparxwallet.com/tonconnect-manifest.json';

final _r = Random();

class CustomTonConnector {
  CustomTonConnector() {
    _unSubscriber = _connector.onStatusChange(_onStatusChange);
  }

  late final id = _r.nextInt(1000);

  late final Stream<dynamic> statusStream = _statusSubject.stream;

  late final _connector = TonConnect(_manifestUrl);

  late final _statusSubject = StreamController<StatusData?>.broadcast();

  String _currentSourceName = '';

  Function? _unSubscriber;

  bool get isConnected => _connector.connected;

  Future<String?> connect(TonConnectData data) async {
    await disconnect();

    final link = await _connector.connect(
      WalletApp(
        name: data.name,
        bridgeUrl: 'https://bridge.tonapi.io/bridge',
        image: data.iconUrl,
        aboutUrl: data.url,
        universalUrl: data.manifestUrl,
      ),
    );

    _currentSourceName = data.name;

    return link;
  }

  Future<void> disconnect() async {
    if (isConnected) {
      return _connector.disconnect();
    }
    return;
  }

  Future<bool> restoreConnection() => _connector.restoreConnection();

  void dispose() {
    disconnect();
    _unSubscribe();
  }

  Future<dynamic> sendTransaction(
    Map<String, dynamic> transactionData,
  ) async {
    if (!isConnected) {
      return;
    }

    try {
      await _connector.sendTransaction(transactionData);
    } on UserRejectsError catch (e) {
      // TODO
    } catch (e) {
      // TODO
    }
  }

  void _unSubscribe() {
    _unSubscriber?.call();
  }

  void _onStatusChange(dynamic value) {
    _statusSubject.add(
      StatusData(
        name: _currentSourceName,
        value: value,
      ),
    );
  }
}

class TonConnectData {
  const TonConnectData({
    required this.manifestUrl,
    required this.name,
    required this.url,
    required this.iconUrl,
  });

  final String manifestUrl;
  final String name;
  final String url;
  final String iconUrl;
}

class StatusData {
  const StatusData({
    required this.name,
    required this.value,
  });

  final String name;
  final dynamic value;
}
