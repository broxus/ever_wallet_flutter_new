import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/widgets/switch_to_seed_sheet/switch_to_seed_model.dart';
import 'package:app/feature/profile/widgets/switch_to_seed_sheet/switch_to_seed_widget.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

SwitchToSeedWidgetModel defaultSwitchToSeedWidgetModelFactory(
  BuildContext context,
) =>
    SwitchToSeedWidgetModel(
      SwitchToSeedModel(
        createPrimaryErrorHandler(context),
        inject(),
      ),
    );

class SwitchToSeedWidgetModel
    extends CustomWidgetModel<SwitchToSeedWidget, SwitchToSeedModel> {
  SwitchToSeedWidgetModel(super.model);

  ThemeStyleV2 get theme => context.themeStyleV2;

  Future<void> onSwitch() async {
    await model.changeCurrentAccount(widget.publicKey);
    contextSafe?.let((context) => Navigator.of(context).pop());
  }

  void onContinue() {
    Navigator.of(context).pop();
  }
}
