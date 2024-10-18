import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<void> addValue<T>(StorageKey key, T value) async {
    await _storage.write(key: key.value, value: value.toString());
  }

  Future<T?> getValue<T>(StorageKey key) async {
    final value = await _storage.read(
      key: key.value,
      iOptions: IOSOptions.defaultOptions,
    );
    if (value == null) {
      return null;
    }

    if (T == bool) {
      return (value.toLowerCase() == 'true') as T;
    } else if (T == int) {
      return int.tryParse(value) as T?;
    } else if (T == double) {
      return double.tryParse(value) as T?;
    }
    return value as T;
  }

  Future<void> cleanStorage(StorageKey key) async {
    await _storage.delete(key: key.value);
  }
}

class StorageKey {
  factory StorageKey.userWithNewWallet() => StorageKey._('userWithNewWallet');

  factory StorageKey.showingManualBackupBadge(String masterKey) =>
      StorageKey._('showingManualBackupBadge', masterKey);

  factory StorageKey.accountColor(String key) =>
      StorageKey._('accountColor', key);

  StorageKey._(this._baseKey, [this._entityKey]);

  final String _baseKey;
  final String? _entityKey;

  String get value => toString();

  @override
  String toString() {
    if (_entityKey == null) return _baseKey;
    return '$_baseKey:$_entityKey';
  }
}
