import 'package:app/feature/wallet/add_account/add_account_result/add_account_result_widget.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

Future<void> showAddAccountResultSheet({
  required BuildContext context,
  required Address address,
}) {
  return showCommonBottomSheet(
    context: context,
    body: (_, scrollController) => AddAccountResultWidget(
      address: address,
    ),
  );
}
