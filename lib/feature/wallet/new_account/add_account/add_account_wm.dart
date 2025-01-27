import 'package:app/app/router/app_route.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/new_account/add_account/add_account_model.dart';
import 'package:app/feature/wallet/new_account/add_account/add_account_view.dart';
import 'package:app/feature/wallet/new_account/add_account_confirm/add_new_account_confirm_sheet.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/theme_style_v2.dart';

AddAccountWidgetModel defaultAddAccountWidgetModelFactory(
  BuildContext context,
) =>
    AddAccountWidgetModel(
      AddAccountModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
      ),
    );

class AddAccountWidgetModel
    extends CustomWidgetModel<AddAccountView, AddAccountModel> {
  AddAccountWidgetModel(super.model);

  late final _currentAccount = createNotifierFromStream(model.currentAccount);
  late final _list = createNotifierFromStream(model.seedWithAccounts);

  ListenableState<List<Seed>> get list => _list;

  ListenableState<Seed?> get currentAccount => _currentAccount;

  ThemeStyleV2 get theme => context.themeStyleV2;

  void onSelect() {
    if ((list.value?.length ?? 0) > 1) {
      contextSafe?.goFurther(
        AppRoute.walletSelectSeed.path,
      );
    } else {
      if (contextSafe != null && _currentAccount.value?.publicKey != null) {
        showAddAccountConfirmSheet(
          context: contextSafe!,
          publicKey: _currentAccount.value!.publicKey,
          seedName: _currentAccount.value!.name,
        );
      }
    }
  }
}
