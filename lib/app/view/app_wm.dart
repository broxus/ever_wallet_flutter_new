import 'package:app/app/view/app.dart';
import 'package:app/app/view/app_model.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';

/// Factory method for creating [AppWidgetModel]
AppWidgetModel defaultAppWidgetModelFactory(
  BuildContext context,
) {
  return AppWidgetModel(
    AppModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
      inject(),
      inject(),
      inject(),
      inject(),
    ),
  );
}

/// [WidgetModel] для [App]
class AppWidgetModel extends CustomWidgetModel<App, AppModel> {
  AppWidgetModel(
    super.model,
  );

  late final router = model.appRouter.router;

  List<LocalizationsDelegate<dynamic>> get localizationDelegates =>
      context.localizationDelegates;

  List<Locale> get supportedLocales => context.supportedLocales;

  Locale get locale => context.locale;
}
