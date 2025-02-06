import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/storage_migration.dart';
import 'package:app/utils/common_utils.dart';
import 'package:get_storage/get_storage.dart';

class StorageMigrationV3 implements StorageMigration {
  static const int version = 3;

  @override
  Future<void> apply() async {
    final containers = [
      GeneralStorageService.currenciesContainer,
      GeneralStorageService.systemContractAssetsContainer,
      GeneralStorageService.customContractAssetsContainer,
    ];

    for (final container in containers) {
      await GetStorage.init(container);

      final storage = GetStorage(container);
      final encoded = storage.getEntries();

      for (final entry in encoded.entries) {
        try {
          final key = _NetworkType.from(entry.key);
          final value = entry.value;

          await storage.write(key.toString(), value);
        } catch (_) {
          await storage.remove(entry.key);
        }
      }
    }
  }

  @override
  Future<void> complete() async {}
}

enum _NetworkType {
  ever,
  venom,
  tycho,
  ton,
  custom;

  factory _NetworkType.from(String value) =>
      int.tryParse(value)?.let(
        (index) => index < _NetworkType.values.length
            ? _NetworkType.values[index]
            : null,
      ) ??
      _NetworkType.values.firstWhere(
        (e) => e.toString().split('.').last == value,
        orElse: () => _NetworkType.custom,
      );
}
