import 'package:app/app/service/identify/accounts_colors_collection.dart';
import 'package:app/app/service/identify/i_identify_icons_service.dart';
import 'package:app/app/service/identify/identy_colors.dart';
import 'package:app/app/service/secure_storage_service.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: IIdentifyIconsService)
class IdentifyIconsService implements IIdentifyIconsService {
  IdentifyIconsService(this._secureStorageService);

  @override
  final availableColors = IdentifyColor.values;

  final SecureStorageService _secureStorageService;

  final _initialIndex = 1;

  late final _accountsColorsSubject =
      BehaviorSubject<AccountsColorsCollection>.seeded(
    AccountsColorsCollection(
      _secureStorageService,
      availableColors[_initialIndex],
    ),
  );

  @override
  Stream<AccountsColorsCollection> get accountsColorsStream =>
      _accountsColorsSubject.stream;

  @override
  IdentifyColor get initialColor => availableColors[_initialIndex];

  AccountsColorsCollection get _accountsColors => _accountsColorsSubject.value;

  @override
  void setColor(String key, IdentifyColor identifyColor) {
    _accountsColors.setColor(key, identifyColor);
    _accountsColorsSubject.add(_accountsColors);
  }

  @override
  Future<IdentifyColor> getColor(String key) {
    return _accountsColors.getColor(key);
  }
}
