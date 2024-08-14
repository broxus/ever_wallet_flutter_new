import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class RequestPermissionsModel extends ElementaryModel {
  RequestPermissionsModel(
    ErrorHandler errorHandler,
    this._currentAccountsService,
    this._permissionsService,
  ) : super(errorHandler: errorHandler);

  final CurrentAccountsService _currentAccountsService;
  final PermissionsService _permissionsService;

  List<KeyAccount> get accounts =>
      _currentAccountsService.currentAccounts?.allAccounts ?? [];

  Future<void> setPermissions(Uri origin, Permissions permissions) =>
      _permissionsService.setPermissions(url: origin, permissions: permissions);
}
