import 'package:app/app/service/service.dart';
import 'package:app/feature/wallet/custodians_settings/custodian_data.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class CustodiansSettingsModel extends ElementaryModel {
  CustodiansSettingsModel(
    ErrorHandler errorHandler,
    this._storageService,
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  final AppStorageService _storageService;
  final MessengerService _messengerService;

  Future<String?> getString(String publicKey) async {
    return _storageService
        .getValue<String>(StorageKey.nameCustodian(publicKey));
  }

  Future<List<CustodianData>> initializeCustodians(List<String> keys) async {
    final custodians = <CustodianData>[];

    for (final key in keys) {
      final name =
          await getString(key) ?? PublicKey(publicKey: key).toEllipseString();
      custodians.add(
        CustodianData(
          name: name,
          key: PublicKey(publicKey: key),
        ),
      );
    }

    return custodians;
  }

  void showSuccessfulMessage() {
    _messengerService.show(
      Message.successful(
        message: LocaleKeys.custodianRenamed.tr(),
      ),
    );
  }

  Future<void> rename(PublicKey key, String newName) async {
    _storageService.addValue(
      StorageKey.nameCustodian(key.publicKey),
      newName,
    );
  }
}
