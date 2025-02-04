import 'package:app/app/router/app_route.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/new_account/add_account_result/add_account_result_model.dart';
import 'package:app/feature/wallet/new_account/add_account_result/add_account_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

AddAccountResultWidgetModel defaultAddAccountResultWidgetModelFactory(
  BuildContext context,
  // ignore: avoid_positional_boolean_parameters
  bool isExternal,
) {
  return AddAccountResultWidgetModel(
    AddAccountResultModel(
      createPrimaryErrorHandler(context),
      isExternal,
      inject(),
      inject(),
      inject(),
    ),
  );
}

class AddAccountResultWidgetModel
    extends CustomWidgetModel<AddAccountResultWidget, AddAccountResultModel> {
  AddAccountResultWidgetModel(super.model);

  ThemeStyleV2 get theme => context.themeStyleV2;

  Future<void> onSwitch() async {
    final address = repackAddress(widget.address);
    model.changeCurrentAccount(address);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
    if (model.isExternal) {
      contextSafe?.goNamed(AppRoute.wallet.name);
    }
  }

  void onContinue() {
    Navigator.of(context).pop();
    if (model.isExternal) {
      contextSafe?.goNamed(AppRoute.wallet.name);
    }
  }
}
