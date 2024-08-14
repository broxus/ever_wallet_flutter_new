import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/app/service/network_connection/network_connection_service.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ImportWalletScreenModel extends ElementaryModel {
  ImportWalletScreenModel(
    this._messengerService,
    this._networkConnectionService,
  );

  final MessengerService _messengerService;
  final NetworkConnectionService _networkConnectionService;

  Future<bool> get isConnected => _networkConnectionService.isConnected;

  void showValidateError(String message) {
    _messengerService.show(
      Message.error(
        message: message,
        debounceTime: defaultInfoMessageDebounceDuration,
      ),
    );
  }

  void showConnectionError() {
    _messengerService.show(
      Message.error(
        message: LocaleKeys.connectingNetworkFailed.tr(),
      ),
    );
  }
}
