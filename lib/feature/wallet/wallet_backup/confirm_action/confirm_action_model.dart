import 'package:app/app/service/current_seed_service.dart';
import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

class ConfirmActionModel extends ElementaryModel {
  ConfirmActionModel(
    ErrorHandler errorHandler,
    this.account,
    this.nekotonRepository,
    this.currentSeedService,
    this.messengerService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository nekotonRepository;
  final CurrentSeedService currentSeedService;
  final MessengerService messengerService;
  final KeyAccount? account;

  Seed? get currentSeed => currentSeedService.currentSeed;

  Seed? findSeed(PublicKey publicKey) =>
      nekotonRepository.seedList.findSeed(publicKey);

  void showValidateError(String message) {
    messengerService.show(
      Message.error(
        message: message,
        debounceTime: defaultInfoMessageDebounceDuration,
      ),
    );
  }
}
