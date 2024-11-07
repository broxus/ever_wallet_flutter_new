import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/new_account/add_account_result/add_account_result_model.dart';
import 'package:app/feature/wallet/new_account/add_account_result/add_account_result_widget.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

AddAccountResultWidgetModel defaultAddAccountResultWidgetModelFactory(
  BuildContext context,
) =>
    AddAccountResultWidgetModel(
      AddAccountResultModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class AddAccountResultWidgetModel
    extends CustomWidgetModel<AddAccountResultWidget, AddAccountResultModel> {
  AddAccountResultWidgetModel(super.model);

  ThemeStyleV2 get theme => context.themeStyleV2;

  Future<void> onSwitch() async {
    await model.changeCurrentAccount(widget.address);
    contextSafe?.let((context) => Navigator.of(context).pop());
  }

  void onContinue() {
    Navigator.of(context).pop();
  }
}
