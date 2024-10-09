// ignore_for_file: use_build_context_synchronously

import 'package:app/app/router/app_route.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/no_internet/no_internet_screen.dart';
import 'package:app/feature/no_internet/no_internet_screen_model.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/text_styles_v2.dart';

/// Factory method for creating [NoInternetScreenWidgetModel]
NoInternetScreenWidgetModel defaultNoInternetScreenWidgetModelFactory(
  BuildContext context,
) {
  return NoInternetScreenWidgetModel(
    NoInternetScreenModel(
      createPrimaryErrorHandler(context),
      inject(),
    ),
  );
}

/// [WidgetModel] для [NoInternetScreen]
class NoInternetScreenWidgetModel
    extends CustomWidgetModel<NoInternetScreen, NoInternetScreenModel> {
  NoInternetScreenWidgetModel(
    super.model,
  );

  ThemeStyleV2 get _theme => context.themeStyleV2;

  TextStylesV2 get textStyles => _theme.textStyles;

  ColorsPaletteV2 get colors => _theme.colors;

  Future<void> onPressedTryAgain() async {
    final isExistInternet = await model.isExistInternet;
    if (isExistInternet) {
      context.go(AppRoute.splash.path);
    }
  }
}
