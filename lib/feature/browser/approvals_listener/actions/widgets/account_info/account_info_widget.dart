import 'package:app/feature/browser/approvals_listener/actions/widgets/account_info/account_info_wm.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/utils/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class AccountInfoWidget extends ElementaryWidget<AccountInfoWidgetModel> {
  const AccountInfoWidget({
    required this.account,
    Key? key,
    WidgetModelFactory wmFactory = defaultAccountInfoWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final Address account;

  @override
  Widget build(AccountInfoWidgetModel wm) =>
      wm.account?.let(
        (account) => AccountInfo(account: account, color: wm.color),
      ) ??
      const SizedBox.shrink();
}
