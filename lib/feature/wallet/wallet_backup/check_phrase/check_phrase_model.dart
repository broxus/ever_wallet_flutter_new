import 'package:app/app/service/service.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/constants.dart';

class CheckPhraseModel extends ElementaryModel {
  CheckPhraseModel(
    ErrorHandler errorHandler,
    this.nekotonRepository,
    this.messengerService,
    this.storage,
    this.phrases,
    this.address,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository nekotonRepository;
  final MessengerService messengerService;
  final AppStorageService storage;
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
    final account = nekotonRepository.accountsStorage.accounts
        .firstWhereOrNull((item) => item.address.address == address);
    final masterPublicKey = account?.let(
      (account) => nekotonRepository.seedList
          .findSeedByAnyPublicKey(account.publicKey)
          ?.masterPublicKey,
    );

    if (masterPublicKey == null) return;

    storage.addValue(
      StorageKey.showingManualBackupBadge(masterPublicKey.publicKey),
      false,
    );
  }
}
