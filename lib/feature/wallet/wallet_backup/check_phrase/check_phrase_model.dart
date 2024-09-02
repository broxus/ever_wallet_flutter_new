import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:elementary/elementary.dart';
import 'package:ui_components_lib/constants.dart';

class CheckPhraseModel extends ElementaryModel {
  CheckPhraseModel(
    ErrorHandler errorHandler,
    this.messengerService,
    this.phrases,
  ) : super(errorHandler: errorHandler);

  final MessengerService messengerService;
  final List<String> phrases;

  void showValidateError(String message) {
    messengerService.show(
      Message.error(
        message: message,
        debounceTime: defaultInfoMessageDebounceDuration,
      ),
    );
  }
}
