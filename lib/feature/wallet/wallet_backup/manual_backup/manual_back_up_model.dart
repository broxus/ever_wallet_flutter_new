import 'package:app/app/service/service.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class ManualBackUpModel extends ElementaryModel {
  ManualBackUpModel(
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
      true,
    );
  }

  void showMessageAboutCopy() {
    messengerService.show(
      Message.successful(
        message: LocaleKeys.copiedExclamation.tr(),
      ),
    );
  }
}
