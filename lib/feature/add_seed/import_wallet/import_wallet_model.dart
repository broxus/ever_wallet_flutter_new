import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:elementary/elementary.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class ImportWalletModel extends ElementaryModel {
  ImportWalletModel(
    this._messengerService,
  );

  final MessengerService _messengerService;

  void showValidateError(String message) {
    _messengerService.show(
      Message.error(
        message: message,
        debounceTime: defaultInfoMessageDebounceDuration,
      ),
    );
  }

  Future<void> import() async {
    ///here add to navigation to Confirm password
  }
}
