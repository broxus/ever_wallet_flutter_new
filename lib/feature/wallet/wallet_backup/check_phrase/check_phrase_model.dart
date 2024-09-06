import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/app/service/secure_storage_service.dart';
import 'package:elementary/elementary.dart';
import 'package:ui_components_lib/constants.dart';

class CheckPhraseModel extends ElementaryModel {
  CheckPhraseModel(
    ErrorHandler errorHandler,
    this.messengerService,
    this.storage,
    this.phrases,
    this.address,
  ) : super(errorHandler: errorHandler);

  final MessengerService messengerService;
  final SecureStorageService storage;
  final List<String> phrases;
  final String address;

  void showValidateError(String message) {
    messengerService.show(
      Message.error(
        message: message,
        debounceTime: defaultInfoMessageDebounceDuration,
      ),
    );
  }

  void setShowingBackUpFlag() {
    storage.addToStorage(
      address + StorageConstants.showingManualBackupBadge,
      false,
    );
  }
}
