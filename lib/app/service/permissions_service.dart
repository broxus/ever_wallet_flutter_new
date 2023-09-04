import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Service that allows listening for browser permissions and update it.
@singleton
class PermissionsService {
  PermissionsService(this.storage, this.nekotonRepository);

  final BrowserPermissionsStorageService storage;

  /// Uses to track account deletion callback
  final NekotonRepository nekotonRepository;

  void init() {
    _listenAccountsDeletion();
  }

  /// Stream that allows tracking permissions changing
  Stream<Map<Uri, Permissions>> get permissionsStream =>
      storage.permissionsStream.map(
        (event) => event.map((key, value) => MapEntry(Uri.parse(key), value)),
      );

  /// Get last existed permissions for browser.
  /// key - url, value - permissions
  Map<Uri, Permissions> get permissions =>
      storage.permissions.map((key, value) => MapEntry(Uri.parse(key), value));

  /// Set permissions for browser tab with url = [origin]
  Future<void> setPermissions({
    required Uri origin,
    required Permissions permissions,
  }) =>
      storage.setPermissions(
        origin: origin.toString(),
        permissions: permissions,
      );

  /// Delete permissions for browser tab with url=[origin]
  Future<void> deletePermissionsForOrigin(Uri origin) =>
      storage.deletePermissionsForOrigin(origin.toString());

  /// Delete permissions for specified account
  Future<void> deletePermissionsForAccount(Address address) =>
      storage.deletePermissionsForAccount(address);

  // we do not save stream sub, because it must stay all app life-time
  void _listenAccountsDeletion() {
    nekotonRepository.seedChangesStream.listen((changes) async {
      for (final account in changes.deletedAccounts) {
        await deletePermissionsForAccount(account.address);
      }
    });
  }
}
