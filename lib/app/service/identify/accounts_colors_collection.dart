import 'package:app/app/service/identify/identy_colors.dart';
import 'package:app/app/service/secure_storage_service.dart';

class AccountsColorsCollection {
  AccountsColorsCollection(
    this._secureStorageService,
    this._initialColor,
  );

  final _map = <String, IdentifyColor>{};

  final SecureStorageService _secureStorageService;

  final IdentifyColor _initialColor;

  Future<void> setColor(String key, IdentifyColor identifyColor) async {
    _map[key] = identifyColor;

    try {
      await _secureStorageService.addValue<int>(
        key,
        identifyColor.color.value,
      );
    } finally {}
  }

  Future<IdentifyColor> getColor(String key) async {
    try {
      return _map[key] ??= IdentifyColor.byInt(
            await _secureStorageService.getValue<int>(key),
          ) ??
          _initialColor;
    } catch (_) {
      return _initialColor;
    }
  }
}
