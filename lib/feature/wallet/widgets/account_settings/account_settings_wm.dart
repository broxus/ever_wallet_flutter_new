import 'dart:convert';

import 'package:app/app/router/app_route.dart';
import 'package:app/app/router/routs/wallet/wallet.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/wallet/widgets/account_settings/account_settings_model.dart';
import 'package:app/feature/wallet/widgets/account_settings/account_settings_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

AccountSettingsWidgetModel defaultAccountSettingsWidgetModelFactory(
  BuildContext context,
) =>
    AccountSettingsWidgetModel(
      AccountSettingsModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class AccountSettingsWidgetModel
    extends CustomWidgetModel<AccountSettingsWidget, AccountSettingsModel> {
  AccountSettingsWidgetModel(super.model);

  late final _displayAccounts = createNotifierFromStream(model.displayAccounts);

  ListenableState<List<KeyAccount>> get displayAccounts => _displayAccounts;

  void onCustodiansSettings(List<PublicKey> custodians) {
    Navigator.of(context).pop();
    final publicKeys = <String>[];
    for (final custodian in custodians) {
      publicKeys.add(custodian.publicKey);
    }

    context.goFurther(
      AppRoute.custodiansSettings.pathWithData(
        queryParameters: {
          custodianSettingsCustodiansParam: jsonEncode(publicKeys),
        },
      ),
    );
  }

  void onViewInExplorer() {
    Navigator.of(context).pop();
    browserNewTab(
      context,
      model.getAccountExplorerLink(widget.account.address),
    );
  }

  void onRename() {
    Navigator.of(context)
      ..pop()
      ..push(getRenameAccountSheet(context, widget.account.address));
  }

  void onCopyAddress() {
    model.copyAddress(context, widget.account.address);
  }

  void onHideAccount() {
    Navigator.of(context).pop();
    model.hideAccount(widget.account.address);
  }
}
