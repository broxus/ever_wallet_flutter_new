import 'package:app/app/service/identify/identy_icon_data.dart';
import 'package:app/app/service/service.dart';

class AccountsColorsCollection {
  AccountsColorsCollection(
    this._secureStorageService,
    this._initialData,
  );

  final _map = <String, IdentifyIconData>{};

  final AppStorageService _secureStorageService;

  final IdentifyIconData _initialData;

  Future<void> clear() async {
    _map
      ..forEach((key, value) {
        _secureStorageService.delete(
          StorageKey.accountColor(key),
        );
      })
      ..clear();
  }

  Future<void> setData(String key, IdentifyIconData identifyColor) async {
    _map[key] = identifyColor;

    try {
      _secureStorageService.addValue<String>(
        StorageKey.accountColor(key),
        identifyColor.name,
      );
    } finally {}
  }

  Future<IdentifyIconData> getData(String key) async {
    try {
      return _map[key] ??= IdentifyIconData.byNameOrNull(
            _secureStorageService.getValue<String>(
              StorageKey.accountColor(key),
            ),
          ) ??
          _initialData;
    } catch (_) {
      return _initialData;
    }
  }
}
