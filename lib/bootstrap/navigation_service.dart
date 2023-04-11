import 'package:app/app/router/router.dart';
import 'package:app/app/service/services.dart';
import 'package:app/di/di.dart';

Future<void> configureNavigationService() async {
  final navigationService = inject<NavigationService>();
  await navigationService.init(AppRoute.defaultRoute.path);
}
