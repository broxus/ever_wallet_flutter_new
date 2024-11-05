import 'package:darttonconnect/exceptions.dart';
import 'package:darttonconnect/ton_connect.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@singleton
class TonService {
  static const _manifestUrl =
      'https://l.sparxwallet.com/tonconnect-manifest.json';

  final _connector = TonConnect(_manifestUrl);

  void init() {
    restoreConnection();
  }

  void connect() {
    // WidgetsBiКnding.instance.addPostFrameCallback((_) {
    //   if (!_connector.connected) {
    //     restoreConnection();
    //   }
    // });
  }

  void disconnect() {
    if (_connector.connected) {
      _connector.disconnect();
    }
  }

  void restoreConnection() => _connector.restoreConnection();

  Future<void> sendTransaction() async {
    if (!_connector.connected) {
      return;
    }

    const transaction = <String, dynamic>{
      // "validUntil": 1918097354,
      // "messages": [
      //   {
      //     "address":
      //         "0:575af9fc97311a11f423a1926e7fa17a93565babfd65fe39d2e58b8ccb38c911",
      //     "amount": "20000000",
      //   }
      // ]
    };

    try {
      await _connector.sendTransaction(transaction);
    } on UserRejectsError catch (e) {
      /// TODO
    } catch (e) {
      /// TODO
    }
  }

  @disposeMethod
  void dispose() {
    disconnect();
  }

  // _() async {
  //   final wallets = await _connector.getWallets();
  //   final universalLink = await _connector.connect(walletConnectionSource);
  //   updateQRCode(universalLink);
  //   _connector.onStatusChange(onStatusChange);
  // }

  void onStatusChange(dynamic value) {}
}
