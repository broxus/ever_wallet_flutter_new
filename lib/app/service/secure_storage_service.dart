import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<void> addValue<T>(String key, T value) async {
    await _storage.write(key: key, value: value.toString());
  }

  Future<T?> getValue<T>(String key) async {
    final value =
        await _storage.read(key: key, iOptions: IOSOptions.defaultOptions);
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

  Future<void> cleanStorage(String key) async {
    await _storage.delete(key: key);
  }
}

class StorageConstants {
  static const showingManualBackupBadge = 'showingManualBackupBadge';
  static const userWithNewWallet = 'userWithNewWallet';
}
