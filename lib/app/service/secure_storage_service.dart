import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  SecureStorageService();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<void> addToStorage<T>(String key, T value) async {
    await _storage.write(key: key, value: value.toString());
  }

  Future<bool?> getFromStorage(String key) async {
    final value = await _storage.read(key: key);
    if (value == null) {
      return null;
    }

    return value.toLowerCase() == 'true';
  }

  Future<void> cleanStorage(String key) async {
    await _storage.delete(key: key);
  }
}

class StorageConstants {
  static const showingManualBackupBadge = 'showingManualBackupBadge';
  static const userWithNewWallet = 'userWithNewWallet';
}
