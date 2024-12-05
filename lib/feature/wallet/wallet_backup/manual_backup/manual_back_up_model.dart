import 'package:app/app/service/service.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class ManualBackUpModel extends ElementaryModel {
  ManualBackUpModel(
    ErrorHandler errorHandler,
    this.nekotonRepository,
    this.storage,
    this.phrases,
    this.address,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository nekotonRepository;
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
}
