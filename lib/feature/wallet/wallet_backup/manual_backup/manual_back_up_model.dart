import 'package:app/app/service/secure_storage_service.dart';
import 'package:elementary/elementary.dart';

class ManualBackUpModel extends ElementaryModel {
  ManualBackUpModel(
    ErrorHandler errorHandler,
    this.storage,
    this.phrases,
    this.address,
  ) : super(errorHandler: errorHandler);

  final SecureStorageService storage;
  final List<String> phrases;
  final String address;

  void setShowingBackUpFlag() {
    storage.addValue(
      address + StorageConstants.showingManualBackupBadge,
      true,
    );
  }
}
