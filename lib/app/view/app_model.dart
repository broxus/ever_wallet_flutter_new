import 'package:app/app/router/router.dart';
import 'package:app/app/service/bootstrap_service.dart';
import 'package:app/app/service/navigation/service/navigation_service.dart';
import 'package:app/app/view/app.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [ElementaryModel] for [App]
class AppModel extends ElementaryModel {
  AppModel(
    ErrorHandler errorHandler,
    this._bootstrapService,
    this._navigationService,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final BootstrapService _bootstrapService;
  final NavigationService _navigationService;
  final NekotonRepository _nekotonRepository;

  late final appRouter = AppRouter(
    _bootstrapService,
    _navigationService,
    _nekotonRepository,
  );

  @override
  void dispose() {
    appRouter.dispose();
    super.dispose();
  }
}
