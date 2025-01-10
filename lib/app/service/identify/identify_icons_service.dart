import 'package:app/app/service/identify/accounts_colors_collection.dart';
import 'package:app/app/service/identify/i_identify_icons_service.dart';
import 'package:app/app/service/identify/identy_icon_data.dart';
import 'package:app/app/service/service.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: IIdentifyIconsService)
class IdentifyIconsService implements IIdentifyIconsService {
  IdentifyIconsService(this._secureStorageService);

  @override
  final availableColors = IdentifyIconData.values;

  final AppStorageService _secureStorageService;

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
  IdentifyIconData get initialColor => availableColors[_initialIndex];

  AccountsColorsCollection get _accountsColors => _accountsColorsSubject.value;

  @override
  void setData(String key, IdentifyIconData identifyColor) {
    _accountsColors.setData(key, identifyColor);
    _accountsColorsSubject.add(_accountsColors);
  }

  @override
  Future<IdentifyIconData> getData(String key) {
    return _accountsColors.getData(key);
  }

  @override
  Future<void> clear() {
    return _accountsColors.clear();
  }
}
