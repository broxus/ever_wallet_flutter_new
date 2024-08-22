import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class AccountInfoModel extends ElementaryModel {
  AccountInfoModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;

  KeyAccount? getAccount(Address address) =>
      _nekotonRepository.seedList.findAccountByAddress(address);
}
