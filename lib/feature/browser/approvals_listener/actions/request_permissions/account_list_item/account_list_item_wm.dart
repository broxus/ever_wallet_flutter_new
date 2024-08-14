import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/approvals_listener/actions/request_permissions/account_list_item/account_list_item_model.dart';
import 'package:app/feature/browser/approvals_listener/actions/request_permissions/account_list_item/account_list_item_widget.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';

AccountListItemWidgetModel defaultAccountListItemWidgetModelFactory(
  BuildContext context,
) =>
    AccountListItemWidgetModel(
      AccountListItemModel(
        createPrimaryErrorHandler(context),
        inject(),
      ),
    );

class AccountListItemWidgetModel
    extends WidgetModel<AccountListItemWidget, AccountListItemModel> {
  AccountListItemWidgetModel(super.model);

  final _balance = StateNotifier<Money?>();
  late final _active = StateNotifier<bool>(initValue: widget.active);
  late final StreamSubscription<Money> _subscription;

  ListenableState<Money?> get balance => _balance;
  ListenableState<bool> get active => _active;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _subscription =
        model.getBalanceStream(widget.account.address).listen(_balance.accept);
  }

  @override
  void didUpdateWidget(AccountListItemWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _active.accept(widget.active);
  }

  @override
  void dispose() {
    _balance.dispose();
    _subscription.cancel();
    super.dispose();
  }
}
