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
  /// key - origin of url, value - permissions
  ///
  /// If you are not sure, that your key is true origin, use [getPermissions].
  Map<Uri, Permissions> get permissions =>
      storage.permissions.map((key, value) => MapEntry(Uri.parse(key), value));

  /// Get permission, specified by [url].
  /// It's better to use this getter except of [permissions] to avoid errors,
  /// related to taking only origin from url.
  Permissions? getPermissions(Uri? url) =>
      url == null ? null : permissions[Uri.parse(url.origin)];

  /// Set permissions for browser tab with [url]
  void setPermissions({
    required Uri url,
    required Permissions permissions,
  }) =>
      storage.setPermissions(
        origin: url.origin,
        permissions: permissions,
      );

  /// Delete permissions for browser tab with [url]
  void deletePermissionsForOrigin(Uri url) =>
      storage.deletePermissionsForOrigin(url.origin);

  /// Delete permissions for specified account
  void deletePermissionsForAccount(Address address) =>
      storage.deletePermissionsForAccount(address);

  // we do not save stream sub, because it must stay all app life-time
  void _listenAccountsDeletion() {
    nekotonRepository.seedChangesStream.listen((changes) {
      for (final account in changes.deletedAccounts) {
        deletePermissionsForAccount(account.address);
      }
    });
  }
}
