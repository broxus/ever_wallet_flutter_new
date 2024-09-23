import 'package:app/app/service/identify/identy_icon_data.dart';
import 'package:app/app/service/secure_storage_service.dart';

class AccountsColorsCollection {
  AccountsColorsCollection(
    this._secureStorageService,
    this._initialColor,
  );

  final _map = <String, IdentifyIconData>{};

  final SecureStorageService _secureStorageService;

  final IdentifyIconData _initialColor;

  Future<void> setColor(String key, IdentifyIconData identifyColor) async {
    _map[key] = identifyColor;

    try {
      await _secureStorageService.addValue<int>(
        key,
        identifyColor.backgroundColor.value,
      );
    } finally {}
  }

  Future<IdentifyIconData> getColor(String key) async {
    try {
      return _map[key] ??= IdentifyIconData.byInt(
            await _secureStorageService.getValue<int>(key),
          ) ??
          _initialColor;
    } catch (_) {
      return _initialColor;
    }
  }
}
