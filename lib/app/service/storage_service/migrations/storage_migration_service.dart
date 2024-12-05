import 'package:app/app/service/service.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logging/logging.dart';

final _logger = Logger('StorageMigrationService');
const _version = 2;
const _versionKey = 'version';

class StorageMigrationService {
  StorageMigrationService(
    this._encryptedStorage,
  ) : _storage = GetStorage();

  static Future<void> applyMigrations(
    EncryptedStorage encryptedStorage,
  ) async =>
      StorageMigrationService(
        encryptedStorage,
      ).migrate();

  final GetStorage _storage;
  final EncryptedStorage _encryptedStorage;

  int get currentVersion => _storage.read<int>(_versionKey) ?? 0;

  bool get needMigration => currentVersion < _version;

  Future<void> migrate() async {
    await GetStorage.init();

    if (!needMigration) return;

    final migrations = _getMigrations();

    try {
      for (final migration in migrations) {
        await migration.apply();
        await migration.complete();
      }
    } catch (e, t) {
      _logger.severe('migrate', e, t);
    } finally {
      await _storage.write(_versionKey, _version);
    }
  }

  Iterable<StorageMigration> _getMigrations() sync* {
    if (currentVersion < StorageMigrationV1.version) {
      yield StorageMigrationV1(encryptedStorage: _encryptedStorage);
    }
    if (currentVersion < StorageMigrationV2.version) {
      yield StorageMigrationV2();
    }
  }
}
