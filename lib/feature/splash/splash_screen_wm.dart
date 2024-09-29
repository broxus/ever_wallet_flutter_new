import 'dart:io';

import 'package:app/app/router/app_route.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/splash/splash_screen.dart';
import 'package:app/feature/splash/splash_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Factory method for creating [SplashScreenWidgetModel]
SplashScreenWidgetModel defaultSplashScreenWidgetModelFactory(
  BuildContext context,
) {
  return SplashScreenWidgetModel(
    SplashScreenModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
      inject(),
    ),
  );
}

/// [WidgetModel] для [SplashScreen]
class SplashScreenWidgetModel
    extends CustomWidgetModel<SplashScreen, SplashScreenModel> {
  SplashScreenWidgetModel(
    super.model,
  );

  late final isIos = Platform.isIOS;

  @override
  void initWidgetModel() {
    _init();
    super.initWidgetModel();
  }

  Future<void> _init() async {
    final isExistInternet = await model.isExistInternet;

    if (!isExistInternet) {
      contextSafe?.go(AppRoute.noInternet.path);
      return;
    }

    await model.configure();
  }
}
