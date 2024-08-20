import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

class ImportWalletScreenModel extends ElementaryModel {
  ImportWalletScreenModel(
    this._messengerService,
    this._nekotonRepository,
  );

  final MessengerService _messengerService;
  final NekotonRepository _nekotonRepository;

  void showValidateError(String message) {
    _messengerService.show(
      Message.error(
        message: message,
        debounceTime: defaultInfoMessageDebounceDuration,
      ),
    );
  }

  List<int> get allowedValues =>
      _nekotonRepository.currentTransport.seedPhraseWordsCount;
}
