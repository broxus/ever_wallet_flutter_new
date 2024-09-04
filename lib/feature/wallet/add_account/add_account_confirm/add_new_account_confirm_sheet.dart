import 'package:app/feature/wallet/add_account/add_account_confirm/add_account_confirm_widget.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// This is a helper method to display AddNewAccountSheet.
Future<void> showAddAccountConfirmSheet({
  required BuildContext context,
  required PublicKey publicKey,
}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.confirmAction.tr(),
    centerTitle: true,
    body: (_, scrollController) => AddAccountConfirmWidget(
      publicKey: publicKey,
    ),
  );
}
