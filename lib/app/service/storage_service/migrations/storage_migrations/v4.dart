import 'package:app/app/service/presets_connection/presets_connection_service.dart';
import 'package:app/app/service/storage_service/balance_storage_service.dart';
import 'package:app/app/service/storage_service/general_storage_service.dart';
import 'package:app/app/service/storage_service/migrations/storage_migrations/storage_migration.dart';
import 'package:app/utils/common_utils.dart';
import 'package:get_storage/get_storage.dart';

class StorageMigrationV4 implements StorageMigration {
  StorageMigrationV4(
    this._presetsConnectionService,
  );

  static const int version = 4;

  final PresetsConnectionService _presetsConnectionService;

  @override
  Future<void> apply() async {
    await _migrateCurrencies();
    await _migrateBalances();
  }

  Future<void> _migrateCurrencies() async {
    final containers = [
      GeneralStorageService.currenciesContainer,
      GeneralStorageService.systemContractAssetsContainer,
      GeneralStorageService.customContractAssetsContainer,
    ];

    for (final container in containers) {
      await GetStorage.init(container);

      final storage = GetStorage(container);
      final encoded = storage.getEntries();

      final networks = _presetsConnectionService.networks;

      final networksMap = <String, String>{};

      for (final network in networks) {
        networksMap[network.networkType] = network.group;
      }
      for (final entry in encoded.entries) {
        try {
          final group =
              entry.key == 'custom' ? 'custom' : networksMap[entry.key];

          final value = entry.value;

          _updateNetworkGroup(value);

          if (group != null) {
            await storage.write(group, value);
            await storage.remove(entry.key);
          }
        } catch (_) {}
      }
    }
  }

  Future<void> _migrateBalances() async {
    for (final container in BalanceStorageService.containers) {
      await GetStorage.init(container);

      final storage = GetStorage(container);
      final encoded = storage.getEntries();

      for (final entry in encoded.entries) {
        try {
          final parts = entry.key.split('::');
          final key = parts[0];
          final group = getNetworkGroupByNetworkType(key);

          await storage.write('$group::${parts[1]}', entry.value);
          await storage.remove(entry.key);
        } catch (_) {}
      }
    }
  }

  void _updateNetworkGroup(dynamic value) {
    try {
      if (value is List) {
        for (final data in value) {
          _updateNetworkGroup(data);
        }
      } else if (value is Map) {
        value['networkGroup'] ??=
            getNetworkGroupByNetworkType(value['networkType']);
      }
    } catch (_) {}
  }

  @override
  Future<void> complete() async {}
}
