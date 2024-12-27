// ignore_for_file: use_build_context_synchronously

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/bootstrap_failed/cubit/rerun_cubit/rerun_cubit.dart';
import 'package:app/feature/connection_fail/connection_fail_screen.dart';
import 'package:app/feature/connection_fail/connection_fail_screen_model.dart';
import 'package:app/feature/contact_support/widgets/contact_support/contact_support_mode.dart';
import 'package:app/feature/contact_support/widgets/contact_support/contact_support_sheet.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/text_styles_v2.dart';

/// Factory method for creating [ConnectionFailWidgetModel]
ConnectionFailWidgetModel defaultConnectionFailWidgetModelFactory(
  BuildContext context,
) {
  return ConnectionFailWidgetModel(
    ConnectionFailModel(
      createPrimaryErrorHandler(context),
      BootstrapRerunCubit(inject()),
    ),
  );
}

/// [WidgetModel] для [ConnectionFailScreen]
class ConnectionFailWidgetModel
    extends CustomWidgetModel<ConnectionFailScreen, ConnectionFailModel> {
  ConnectionFailWidgetModel(
    super.model,
  );

  ThemeStyleV2 get _theme => context.themeStyleV2;

  TextStylesV2 get textStyles => _theme.textStyles;

  ColorsPaletteV2 get colors => _theme.colors;

  Future<void> onPressedTryAgain() async {
    model.tryAgain(context);
  }

  void onPressedContactUs() {
    showContactSupportSheet(
      context: context,
      mode: ContactSupportMode.initiatedByCrash,
    );
  }
}
