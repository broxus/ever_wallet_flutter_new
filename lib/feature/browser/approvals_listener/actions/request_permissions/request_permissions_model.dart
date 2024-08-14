import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class RequestPermissionsModel extends ElementaryModel {
  RequestPermissionsModel(
    ErrorHandler errorHandler,
    this._currentAccountsService,
    this._browserFaviconURLStorageService,
    this._permissionsService,
  ) : super(errorHandler: errorHandler);

  final CurrentAccountsService _currentAccountsService;
  final BrowserFaviconURLStorageService _browserFaviconURLStorageService;
  final PermissionsService _permissionsService;

  List<KeyAccount> get accounts =>
      _currentAccountsService.currentAccounts?.allAccounts ?? [];

  Future<String?> getFaviconUrl(Uri uri) =>
      _browserFaviconURLStorageService.getFaviconURL(uri);

  Future<void> setPermissions(Uri origin, Permissions permissions) =>
      _permissionsService.setPermissions(url: origin, permissions: permissions);
}
