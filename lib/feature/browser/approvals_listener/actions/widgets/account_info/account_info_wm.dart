import 'package:app/core/error_handler_factory.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/approvals_listener/actions/widgets/account_info/account_info_model.dart';
import 'package:app/feature/browser/approvals_listener/actions/widgets/account_info/account_info_widget.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

AccountInfoWidgetModel defaultAccountInfoWidgetModelFactory(
  BuildContext context,
) =>
    AccountInfoWidgetModel(
      AccountInfoModel(
        createPrimaryErrorHandler(context),
        inject(),
      ),
    );

class AccountInfoWidgetModel
    extends WidgetModel<AccountInfoWidget, AccountInfoModel> {
  AccountInfoWidgetModel(super.model);

  late final account = model.getAccount(widget.account);

  Color get color => context.themeStyleV2.colors.background2;
}
